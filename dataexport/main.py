import logging
import sys
from datetime import datetime, timedelta

import psycopg2
import typer

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
def sios_dump(
    every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False
):
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting SIOS dataset")
    logging.info(f"{acdd}")

    dataset_name = "sios"

    conn = psycopg2.connect(DATABASE_URL)
    start_time = (
        odm2.queries.first_timestamp(
            conn,
            datasets.sios.VARIABLE_CODES,
            datasets.sios.PROJECT_NAME,
            datasets.sios.PROJECT_STATION_CODE,
        )
        if start_from_scratch
        else thredds.end_time(dataset_name)
    )

    time_intervals = utils.datetime_intervals(start_time, datetime.now(), timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.sios.dump(conn, interval.start_time, interval.end_time, acdd)
        if ds.dims['time']>0:
            utils.save_dataset(dataset_name, ds)
        else:
            logging.info("No data for interval")

    conn.close()


if __name__ == "__main__":
    app()
