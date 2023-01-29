import logging
import sys
from datetime import datetime, timedelta
from functools import partial

import psycopg2
import typer

from dataexport import datasets, thredds, utils
from dataexport.config import DATABASE_URL
from dataexport.export_types import ProjectExport, SamplingExport
from dataexport.sources import odm2

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

    title = "Test MSource/DigiVeivann Inlet"
    projectdescription = "Test MSource/DigiVeivann Inlet"
    dataset_name = "msource-inlet"
    project_name = "Multisource"
    sampling_feature_code = "MSOURCE1"
    variable_codes = [
        "Temp",
        "LevelValue",
        "Turbidity",
    ]

    conn = psycopg2.connect(DATABASE_URL)

    dataset_by_interval = partial(
        datasets.msource.create,
        conn=conn,
        uuid="268ac6d7-c991-48e6-8c9c-f554eb5a9516",
        sampling_feature_code=sampling_feature_code,
        variable_codes=variable_codes,
        station_name=dataset_name,
    )

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_sampling_code,
        conn=conn,
        variable_codes=variable_codes,
        sampling_feature_code=sampling_feature_code,
    )
    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)

    acdd_function = lambda ds: datasets.msource.add_acdd(ds, title, projectdescription, project_name) if acdd else ds
    run_export(
        acdd_function,
        dataset_by_interval,
        project_name,
        dataset_name,
        every_n_hours,
        start_time,
        end_time,
        stop_after_n_files,
    )
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
    title = "Test MSource/DigiVeivann Outlet"
    summary = "Test MSource/DigiVeivann Outlet"
    dataset_name = "msource-outlet"
    project_name = "Multisource"
    sampling_feature_code = "MSOURCE2"
    variable_codes = [
        "LevelValue",
        "Turbidity",
    ]
    conn = psycopg2.connect(DATABASE_URL)

    dataset_by_interval = partial(
        datasets.msource.create,
        conn=conn,
        uuid="09eb5028-9bc7-4587-b8ff-0436bc00494a",
        sampling_feature_code=sampling_feature_code,
        variable_codes=variable_codes,
        station_name=dataset_name,
    )

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_sampling_code,
        conn=conn,
        variable_codes=variable_codes,
        sampling_feature_code=sampling_feature_code,
    )
    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)

    acdd_function = lambda ds: datasets.msource.add_acdd(ds, title, summary, project_name) if acdd else ds
    run_export(
        acdd_function,
        dataset_by_interval,
        project_name,
        dataset_name,
        every_n_hours,
        start_time,
        end_time,
        stop_after_n_files,
    )
    conn.close()


@app.command()
def sios(every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False):
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting SIOS dataset")

    uuid = "29b7de62-e1fa-4dce-90e4-7ff8a0931397"
    title = "SIOS sensor buoy in Adventfjorden"
    summary = "Summary"
    project_name = "SIOS"
    project_station_code = "20"
    dataset_name = "sios"
    variable_codes = [
        "Temp",
        "Turbidity",
        "Salinity",
        "ChlaValue",
        "CondValue",
        # "OxygenCon",
        # "OxygenSat",
        # "RawBackScattering",
        # "fDOM",
    ]

    conn = psycopg2.connect(DATABASE_URL)

    dataset_by_interval = partial(
        datasets.sios.create,
        conn=conn,
        uuid="09eb5028-9bc7-4587-b8ff-0436bc00494a",
        project_name=project_name,
        project_station_code=project_station_code,
        variable_codes=variable_codes,
    )

    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_project,
        conn=conn,
        variable_codes=variable_codes,
        project_name=project_name,
        project_station_code=project_station_code,
    )

    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)

    acdd_function = lambda ds: datasets.msource.add_acdd(ds, title, summary, project_name) if acdd else ds
    run_export(
        acdd_function,
        dataset_by_interval,
        project_name,
        dataset_name,
        every_n_hours,
        start_time,
        end_time,
        stop_after_n_files,
    )
    conn.close()


def run_export(
    acdd_function,
    dataset_by_interval,
    project_name: str,
    dataset_name: str,
    every_n_hours: int,
    start_time: datetime,
    end_time: datetime,
    stop_after_n_files: int,
):

    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    logging.info(f"Start dumping for {start_time} -> {end_time}")

    for interval in time_intervals[0:last_index]:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ds = dataset_by_interval(start_time=interval.start_time, end_time=interval.end_time)
        if ds.dims["time"] > 0:
            utils.save_dataset(acdd_function(ds), project_name, dataset_name)
        else:
            logging.info("Found no data for interval")


if __name__ == "__main__":
    app()
