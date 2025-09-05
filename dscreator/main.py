import logging
import sys
from datetime import datetime, timedelta
from enum import Enum

import typer
from sqlalchemy import create_engine

from dscreator.config import SETTINGS
from dscreator.datasets import timeseries, trajectories
from dscreator.runner import DataRunner
from dscreator.sources import ferrybox, odm2


app = typer.Typer()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(module)s.%(funcName)s %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)


class ACDDOptions(str, Enum):
    no = "no"
    """Do not add ACDD attributes"""
    yes = "yes"
    """Add ACDD attributes"""
    ncml = "ncml"
    """Add ACDD attributes and create a ncml template"""


@app.command()
def msource_inlet(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build an msource inlet dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")

    engine = create_engine(SETTINGS.odm2_connection_str)

    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="MSOURCE1",
        variable_codes=["Temp", "LevelValue", "Turbidity", "CondValue"],
    )

    dataset_builder = timeseries.msource.MSourceInletBuilder(
        uuid="no.niva:d2675936-8ebf-4fc5-988c-4a5198b2df57",
        dataset_name="msource-inlet",
        station_name="msource-inlet",
        grouping="Multisource",
        is_acdd=False if acdd == "no" else True,
    )

    runner = DataRunner(
        custom_start_time=datetime(2022, 9, 23),
        extractor=timeseries_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
    )
    runner.start()


@app.command()
def msource_outlet(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build an msource outlet dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting MSOURCE dataset")

    engine = create_engine(SETTINGS.odm2_connection_str)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="MSOURCE2",
        variable_codes=["LevelValue", "Turbidity", "CondValue"],
    )

    dataset_builder = timeseries.msource.MSourceOutletBuilder(
        uuid="no.niva:4b123377-e0a6-4c7e-b466-2f8a3199bc86",
        dataset_name="msource-outlet",
        station_name="msource-outlet",
        grouping="Multisource",
        is_acdd=False if acdd == "no" else True,
    )

    runner = DataRunner(
        custom_start_time=datetime(2022, 9, 23),
        extractor=timeseries_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
    )

    runner.start()


@app.command()
def glomma_baterod(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build glomma Baterød dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting Glomma Baterød dataset")
    engine = create_engine(SETTINGS.odm2_connection_str)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="Baterod",
        variable_codes=["Temp_water_Avg", "PhValue_Avg", "CondValue_Avg", "Turbidity_Avg", "CDOMdigitalFinal"],
    )
    dataset_builder = timeseries.glomma.GlommaBuilder(
        uuid="no.niva:af047ff6-e92a-47a0-a9ab-1b2d1e011092",
        dataset_name="baterod",
        station_name="Baterod",
        grouping="glomma",
        is_acdd=False if acdd == "no" else True,
    )
    runner = DataRunner(
        extractor=timeseries_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
        end_time_delay=timedelta(days=7),
    )

    runner.start()


@app.command()
def sios(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build test sios dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting SIOS dataset")
    engine = create_engine(SETTINGS.odm2_connection_str)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="bbee7983-e91c-4282-9a5d-d0894a9b7cb0",
        variable_codes=[
            "Temp",
            "TurbCalib",
            "Salinity",
            "ChlaCalib",
            "CondValue",
            "fDOMCalib",
        ],
    )
    dataset_builder = timeseries.sios.SiosBuilder(
        uuid="no.niva:29b7de62-e1fa-4dce-90e4-7ff8a0931397",
        dataset_name="sios",
        station_name="adventfjorden",
        grouping="SIOS",
        is_acdd=False if acdd == "no" else True,
    )
    runner = DataRunner(
        extractor=timeseries_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
    )

    runner.start()


@app.command()
def nrt_color_fantasy(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build nrt color fantasy dataset from data in tsb"""

    logging.info("Exporting NRT FA dataset")
    trajectory_extractor = ferrybox.extractor.TrajectoryExtractor(
        create_engine(SETTINGS.tsb_connection_str),
        variable_codes=["temperature", "salinity", "oxygen_sat", "chlorophyll", "turbidity", "fdom"],
        variable_uuid_map=ferrybox.uuid_variable_code_mapper.MAPPER["FA_19"],
        qc_flags=[1],
    )

    dataset_builder = trajectories.ferrybox.DailyFantasy(
        uuid="no.niva:af11ba01-dfe3-4432-b9d2-4e6fd10714db",
        dataset_name="color_fantasy",
        station_name="color_fantasy",
        grouping="nrt",
        is_acdd=False if acdd == "no" else True,
    )

    runner = DataRunner(
        custom_start_time=datetime(2023, 1, 1),
        extractor=trajectory_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
        end_time_delay=timedelta(minutes=90),
    )

    runner.start()


@app.command()
def usage(max_time_slice: int = 24, stop_after_n_files: int = -1, acdd: ACDDOptions = "no"):
    """Build USAGE dataset from data in odm2

    The dataset tries to follow the climate & forecast convention and is dumped as netcdf.
    """

    logging.info("Exporting USAGE dataset")
    engine = create_engine(SETTINGS.odm2_connection_str)
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        engine,
        sampling_feature_code="USAGE",
        variable_codes=[
            "LF_psnt_Avg",
            "OxygenCon",
            "OxygenSat",
            "PhValue",
            "Temp",
            "Temp_air",
        ],
    )
    dataset_builder = timeseries.usage.UsageBuilder(
        uuid="no.niva:10816f11-2eb2-4dc4-a9b2-19274b181c39",
        dataset_name="usage",
        station_name="USAGE",
        grouping="usage",
        is_acdd=False if acdd == "no" else True,
    )
    runner = DataRunner(
        extractor=timeseries_extractor,
        dataset_builder=dataset_builder,
        hourly_delta=max_time_slice,
        n_intervals=stop_after_n_files,
        ncml=True if acdd == "ncml" else False,
    )

    runner.start()


if __name__ == "__main__":
    app()
