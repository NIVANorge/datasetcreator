"""Test extracting from sample db and creating dataset

Tests using a sample database and testing integration between
dscreator.sources and dscreator.datasets
"""

import os

from datetime import datetime, timedelta

import pytest
import xarray as xr

from dscreator.sources import ferrybox
from dscreator.datasets.trajectories.ferrybox import NorsoopFantasy

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
        project_name="projectname",
        is_acdd=True,
    ).create(ferrybox_extractor.fetch_slice(datetime(2020, 1, 1, 14, 20), datetime(2021, 1, 1, 14, 20)))

    ds_expected = xr.open_dataset(os.path.join(TEST_DATA_DIR, "fa_test_dataset.nc"))

    assert ds.temperature.equals(ds_expected.sea_water_temperature)
    assert ds.salinity.equals(ds_expected.salinity)
    assert ds.oxygen.equals(ds_expected.oxygen)
