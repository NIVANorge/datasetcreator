import logging
import sys
from datetime import datetime, timedelta
from functools import partial
from typing import List

import typer
from sqlalchemy import create_engine

from dataexport import thredds, utils
from dataexport.config import SETTINGS
from dataexport.datasets import timeseries
from dataexport.datasets.base import TimeseriesDatasetBuilder
from dataexport.sources import base, odm2
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
    """Build an msource inlet dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")
    engine = create_engine(SETTINGS.database_url)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
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
        is_acdd=acdd,
    )

    time_intervals = create_time_intervals(
        timeseries_extractor, dataset_builder.dataset_name, start_from_scratch, every_n_hours, stop_after_n_files
    )
    run_export(timeseries_extractor, dataset_builder, time_intervals)


@app.command()
def msource_outlet(
    every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False
):
    """Build an msource outlet dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")
    engine = create_engine(SETTINGS.database_url)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="MSOURCE2",
        variable_codes=[
            "LevelValue",
            "Turbidity",
        ],
    )

    dataset_builder = timeseries.MSourceBuilder(
        uuid="09eb5028-9bc7-4587-b8ff-0436bc00494a",
        title="Test MSOURCE/DIGIVEIVANN Outlet",
        summary="summary",
        dataset_name="msource-outlet",
        station_name="msource-outlet",
        project_name="Multisource",
        is_acdd=acdd,
    )

    time_intervals = create_time_intervals(
        timeseries_extractor, dataset_builder.dataset_name, start_from_scratch, every_n_hours, stop_after_n_files
    )
    run_export(timeseries_extractor, dataset_builder, time_intervals)


@app.command()
def sios(every_n_hours: int = 24, start_from_scratch: bool = False, stop_after_n_files: int = -1, acdd: bool = False):
    """Build test sios dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting SIOS dataset")
    engine = create_engine(SETTINGS.database_url)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="bbee7983-e91c-4282-9a5d-d0894a9b7cb0",
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
    dataset_builder = timeseries.SiosBuilder(
        uuid="29b7de62-e1fa-4dce-90e4-7ff8a0931397",
        title="SIOS sensor buoy in Adventfjorden",
        summary="summary",
        dataset_name="sios",
        station_name="adventfjorden",
        project_name="SIOS",
        is_acdd=acdd,
    )

    time_intervals = create_time_intervals(
        timeseries_extractor, dataset_builder.dataset_name, start_from_scratch, every_n_hours, stop_after_n_files
    )
    run_export(timeseries_extractor, dataset_builder, time_intervals)


def create_time_intervals(
    extractor: base.BaseExtractor,
    dataset_name: str,
    start_from_scratch: bool,
    hourly_delta: int,
    n_intervals: int,
) -> List[DatetimeInterval]:
    """Create timeintervals for each dataset slice

    If starting from scratch the start time provided by the extractor is used, else
    the last timestamp from the thredds server is used.
    """
    start_time = extractor.first_timestamp() if start_from_scratch else thredds.end_time(dataset_name)
    end_time = extractor.last_timestamp()
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=hourly_delta))
    last_index = len(time_intervals) if n_intervals < 1 else n_intervals

    return time_intervals[0:last_index]


def run_export(
    extractor: odm2.extractor.TimeseriesExtractor,
    dataset_builder: TimeseriesDatasetBuilder,
    time_intervals: List[DatetimeInterval],
):

    logging.info(f"Start dumping for {time_intervals[0].start_time} -> {time_intervals[-1].end_time}")

    for interval in time_intervals:
        logging.info(f"Dumping {interval.start_time} < time <= {interval.end_time}")
        ts = extractor.fetch_slice(start_time=interval.start_time, end_time=interval.end_time)
        ds = dataset_builder.create(ts)
        if ds.dims["time"] > 0:
            utils.save_dataset(ds, dataset_builder.project_name, filename=dataset_builder.dataset_name)
        else:
            logging.info("Found no data for interval")


if __name__ == "__main__":
    app()
