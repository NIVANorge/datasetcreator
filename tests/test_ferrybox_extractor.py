from datetime import datetime

import pytest

from dscreator.sources import ferrybox


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
def test_trajectory_extractor_timestamps(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    assert ferrybox_extractor.first_timestamp() == datetime(2022, 12, 12, 16, 0)
    assert ferrybox_extractor.last_timestamp() == datetime(2020, 1, 2, 23, 59, 40)


@pytest.mark.docker
def test_trajectory_values(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    data_dict = ferrybox_extractor.fetch_slice(datetime(2020, 1, 1, 14, 20), datetime(2020, 1, 1, 14, 22))
    assert len(data_dict) == 9
    assert "temperature" in data_dict
    assert "oxygen" in data_dict
    assert data_dict["temperature"] == [5.425, 5.519]
    assert data_dict["salinity"] == [26.248, 26.309]
    assert data_dict["time"] == [datetime(2020, 1, 1, 14, 20, 38), datetime(2020, 1, 1, 14, 21, 39)]
