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
from dataexport.datasets.base import TimeseriesDatasetBuilder
from dataexport.datasets import timeseries

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
    conn = psycopg2.connect(DATABASE_URL)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        conn,
        sampling_feature_code="MSOURCE1",
        variable_codes=[
            "Temp",
            "LevelValue",
            "Turbidity",
        ],
    )

    dataset_builder = timeseries.MSourceBuilder(
        uuid="268ac6d7-c991-48e6-8c9c-f554eb5a9516",
        title="Test MSOURCE/DIGIVEIVANN Inlet",
        summary="summary",
        dataset_name="msource-inlet",
        station_name="msource-inlet",
        project_name="Multisource",
        is_acdd=acdd
    )

    start_time = (
        timeseries_extractor.start_time() if start_from_scratch else thredds.end_time(dataset_builder.dataset_name)
    )
    end_time = timeseries_extractor.end_time()
    time_intervals = create_time_intervals(start_time, end_time, every_n_hours, stop_after_n_files)
    run_export(timeseries_extractor, dataset_builder, time_intervals)
    conn.close()


def run_export(
    extractor: odm2.extractor.TimeseriesExtractor,
    dataset_builder: TimeseriesDatasetBuilder,
    time_intervals: List[DatetimeInterval],
):

    logging.info(f"Start dumping for {time_intervals[0]} -> {time_intervals[-1]}")

    for interval in time_intervals:
        logging.info(f"Dumping {interval.start_time} -> {interval.end_time}")
        ts = extractor.fetch_slice(start_time=interval.start_time, end_time=interval.end_time)
        ds = dataset_builder.create(ts)
        if ds.dims["time"] > 0:
            utils.save_dataset(ds, dataset_builder.project_name, filename=dataset_builder.dataset_name)
        else:
            logging.info("Found no data for interval")


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


if __name__ == "__main__":
    app()
