import logging
import sys
from datetime import datetime, timedelta

import psycopg2
import typer
from functools import partial


from dataexport import datasets, utils
from dataexport import odm2, thredds
from dataexport.config import DATABASE_URL

app = typer.Typer()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)


@app.command()
def msource_inlet(
    every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False
):
    """Export msource data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")

    dataset_name = "msource_inlet"

    conn = psycopg2.connect(DATABASE_URL)

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_sampling_code,
        conn=conn,
        variable_codes=datasets.msource_inlet.VARIABLE_CODES,
        sampling_feature_code=datasets.msource_inlet.SAMPLING_FEATURE_CODE,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.msource_inlet.dump(conn, interval.start_time, interval.end_time, acdd)
        if ds.dims["time"] > 0:
            utils.save_dataset(dataset_name, ds)
        else:
            logging.info("Found no data for interval")

    conn.close()


@app.command()
def sios(every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False):
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting SIOS dataset")

    dataset_name = "sios"

    conn = psycopg2.connect(DATABASE_URL)

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_project,
        conn=conn,
        variable_codes=datasets.sios.VARIABLE_CODES,
        project_name=datasets.sios.PROJECT_NAME,
        project_station_code=datasets.sios.PROJECT_STATION_CODE,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.sios.dump(conn, interval.start_time, interval.end_time, acdd)
        if ds.dims["time"] > 0:
            utils.save_dataset(dataset_name, ds)
        else:
            logging.info("Found no data for interval")

    conn.close()


if __name__ == "__main__":
    app()
