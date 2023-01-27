import logging
import sys
from datetime import datetime, timedelta

import psycopg2
import typer
from functools import partial


from dataexport import datasets, utils, thredds
from dataexport.sources import odm2
from dataexport.config import DATABASE_URL
from dataexport.export_types import ProjectExport, SamplingExport

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

    export_info = SamplingExport(
        uuid="268ac6d7-c991-48e6-8c9c-f554eb5a9516",
        title="Test MSource/DigiVeivann Inlet",
        projectdescription="Test MSource/DigiVeivann Inlet",
        filename="msource-inlet",
        station_name="msource-inlet",
        project_name="Multisource",
        sampling_feature_code="MSOURCE1",
        variable_codes=[
            "Temp",
            "LevelValue",
            "Turbidity",
        ],
    )
    conn = psycopg2.connect(DATABASE_URL)

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_sampling_code,
        conn=conn,
        variable_codes=export_info.variable_codes,
        sampling_feature_code=export_info.sampling_feature_code,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(export_info.filename)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.msource.create(conn, export_info, interval.start_time, interval.end_time, acdd)
        if ds.dims["time"] > 0:
            utils.save_dataset(export_info.filename, ds)
        else:
            logging.info("Found no data for interval")

    conn.close()


@app.command()
def msource_outlet(
    every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False
):
    """Export msource data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")

    export_info = SamplingExport(
        uuid="09eb5028-9bc7-4587-b8ff-0436bc00494a",
        title="Test MSource/DigiVeivann Outlet",
        projectdescription="Test MSource/DigiVeivann Outlet",
        filename="msource-outlet",
        station_name="msource-outlet",
        project_name="Multisource",
        sampling_feature_code="MSOURCE2",
        variable_codes=[
            "LevelValue",
            "Turbidity",
        ],
    )
    conn = psycopg2.connect(DATABASE_URL)

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_sampling_code,
        conn=conn,
        variable_codes=export_info.variable_codes,
        sampling_feature_code=export_info.sampling_feature_code,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(export_info.filename)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.msource.create(conn, export_info, interval.start_time, interval.end_time, acdd)
        if ds.dims["time"] > 0:
            utils.save_dataset(export_info.filename, ds)
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

    export_info = ProjectExport(
        uuid="29b7de62-e1fa-4dce-90e4-7ff8a0931397",
        title="SIOS sensor buoy in Adventfjorden",
        project_name="SIOS",
        project_station_code="20",
        filename="sios",
        variable_codes=[
            "Temp",
            "Turbidity",
            "Salinity",
            "ChlaValue",
            "CondValue",
            # "OxygenCon",
            # "OxygenSat",
            # "RawBackScattering",
            # "fDOM",
        ],
    )
    conn = psycopg2.connect(DATABASE_URL)

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_project,
        conn=conn,
        variable_codes=export_info.variable_codes,
        project_name=export_info.project_name,
        project_station_code=export_info.project_station_code,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(export_info.filename)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = datasets.sios.create(conn, export_info, interval.start_time, interval.end_time, acdd)
        if ds.dims["time"] > 0:
            utils.save_dataset(export_info.filename, ds)
        else:
            logging.info("Found no data for interval")

    conn.close()


if __name__ == "__main__":
    app()
