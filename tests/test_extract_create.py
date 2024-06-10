"""Test extracting from sample db and creating dataset

Tests using a sample database and testing integration between
dscreator.sources and dscreator.datasets
"""

import os

from datetime import datetime

import pytest
import xarray as xr

from dscreator.sources import ferrybox, odm2
from dscreator.datasets.trajectories.ferrybox import NorsoopFantasy
from dscreator.datasets.timeseries.msource import MSourceInletBuilder

TEST_DATA_DIR = os.path.join(os.path.dirname(os.path.realpath(__file__)), "data", "nc")


@pytest.fixture
def ferrybox_extractor(db_engine) -> ferrybox.extractor.TrajectoryExtractor:
    traj_extractor = ferrybox.extractor.TrajectoryExtractor(
        db_engine,
        variable_codes=["temperature", "salinity", "oxygen"],
        variable_uuid_map=ferrybox.uuid_variable_code_mapper.MAPPER["FA_20"],
        qc_flags=[1],
    )
    return traj_extractor


@pytest.mark.docker
def test_ferrybox_ds_create(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    ds = NorsoopFantasy(
        uuid="uuid",
        dataset_name="datasetname",
        station_name="stationname",
        grouping="projectname",
        is_acdd=True,
    ).create(ferrybox_extractor.fetch_slice(datetime(2020, 1, 1, 14, 20), datetime(2021, 1, 1, 14, 20)))

    ds_expected = xr.open_dataset(os.path.join(TEST_DATA_DIR, "fa_test_dataset.nc"))

    assert ds.temperature.equals(ds_expected.sea_water_temperature)
    assert ds.salinity.equals(ds_expected.salinity)
    assert ds.oxygen.equals(ds_expected.oxygen)


@pytest.mark.docker
def test_timeseries_ds_create(db_engine):
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        db_engine,
        sampling_feature_code="MSOURCE1",
        variable_codes=[
            "Temp",
            "LevelValue",
            "Turbidity",
        ],
    )
    ds = MSourceInletBuilder(
        uuid="uuid",
        dataset_name="datasetname",
        station_name="stationname",
        grouping="projectname",
        is_acdd=True,
    ).create(timeseries_extractor.fetch_slice(datetime(2022, 9, 14, 14, 19), datetime(2022, 9, 17, 14, 20)))

    ds_expected = xr.open_dataset(os.path.join(TEST_DATA_DIR, "msource_test_dataset.nc"))
    assert ds.temp.equals(ds_expected.temp)
    assert ds.levelvalue.equals(ds_expected.levelvalue)
    assert ds.turbidity.equals(ds_expected.turbidity)
    for k in ds.attrs:
        assert k in ds_expected.attrs
        if k not in ["date_created"]:
            assert ds.attrs[k] == ds_expected.attrs[k]
