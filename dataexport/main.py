import logging
import sys
from datetime import datetime, timedelta
from functools import partial
from typing import List

import psycopg2
import typer

from dataexport import datasets, thredds, utils
from dataexport.config import DATABASE_URL
from dataexport.sources import odm2
from dataexport.utils import DatetimeInterval

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

    dataset_name = "msource-inlet"
    project_name = "Multisource"
    sampling_feature_code = "MSOURCE1"
    variable_codes = [
        "Temp",
        "LevelValue",
        "Turbidity",
    ]

    conn = psycopg2.connect(DATABASE_URL)
    timeseries_slice_function = partial(
        odm2.builder.timeseries,
        conn=conn,
        result_variable_list=odm2.builder.resultuuids(conn, sampling_feature_code, variable_codes),
    )
    point_info = odm2.queries.point_by_sampling_code(conn, sampling_feature_code)
    dataset_create_function = partial(
        datasets.msource.create,
        uuid="268ac6d7-c991-48e6-8c9c-f554eb5a9516",
        station_name=dataset_name,
        point_info=point_info,
    )
    timestamp_fetcher = partial(
        odm2.queries.timestamp_by_code,
        conn=conn,
        variable_codes=variable_codes,
        sampling_feature_code=sampling_feature_code,
    )
    start_time = timestamp_fetcher(is_asc=True) if start_from_scratch else thredds.end_time(dataset_name)
    end_time = timestamp_fetcher(is_asc=False)
    time_intervals = create_time_intervals(start_time, end_time, every_n_hours, stop_after_n_files)
    acdd_function = lambda ds: datasets.msource.add_acdd(ds, project_name) if acdd else ds
    dataset_save_function = partial(utils.save_dataset, project_name=project_name, filename=dataset_name)
    run_export(timeseries_slice_function, dataset_create_function, dataset_save_function, acdd_function, time_intervals)
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
        odm2.queries.timestamp_by_code,
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
    sampling_feature_code = "bbee7983-e91c-4282-9a5d-d0894a9b7cb0"
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
        odm2.queries.timestamp_by_code,
        conn=conn,
        sampling_feature_code=sampling_feature_code,
        variable_codes=variable_codes,
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


def create_time_intervals(
    start_time: datetime, end_time: datetime, every_n_hours: int, stop_after_n_files: int
) -> List[DatetimeInterval]:
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=every_n_hours))
    last_index = len(time_intervals) if stop_after_n_files < 0 else stop_after_n_files

    return time_intervals[0:last_index]


def run_export(
    timeseries_slice_function,
    dataset_create_function,
    dataset_save_function,
    acdd_function,
    time_intervals: List[DatetimeInterval],
):

    logging.info(f"Start dumping for {time_intervals[0]} -> {time_intervals[-1]}")

    for interval in time_intervals:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ts = timeseries_slice_function(start_time=interval.start_time, end_time=interval.end_time)
        ds = dataset_create_function(named_timeseries=ts)
        if ds.dims["time"] > 0:
            dataset_save_function(ds=acdd_function(ds))
        else:
            logging.info("Found no data for interval")


if __name__ == "__main__":
    app()
