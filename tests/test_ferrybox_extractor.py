from datetime import datetime, timedelta

import pytest
from sqlalchemy.exc import NoResultFound

from dscreator.sources import ferrybox


@pytest.fixture
def ferrybox_extractor(db_engine) -> ferrybox.extractor.TrajectoryExtractor:
    traj_extractor = ferrybox.extractor.TrajectoryExtractor(
        db_engine,
        variable_codes=["Temperature", "Salinity", "Oxygen"],
        variable_uuid_map=ferrybox.uuid_variable_code_mapper.MAPPER['FA_20'],
        qc_flags=[1]
    )
    return traj_extractor


@pytest.mark.docker
def test_trajectory_extractor_timestamps(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    assert ferrybox_extractor.first_timestamp() == datetime(2022, 12, 12, 16, 0) 
    assert ferrybox_extractor.last_timestamp() == datetime(2020, 1, 2, 23, 59, 40)


@pytest.mark.docker
def test_trajectory_values(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    traj_list = ferrybox_extractor.fetch_slice(datetime(2020, 1, 1, 14, 20), datetime(2020, 1, 1, 14, 22))
    assert len(traj_list.array_list) == 6
    assert traj_list.array_list[0].variable_name == "Temperature"
    assert traj_list.array_list[2].variable_name == "Oxygen"
    assert traj_list.array_list[0].values == [5.425, 5.519]
    assert traj_list.array_list[1].values == [26.248, 26.309]
    assert traj_list.datetime_list == [datetime(2020, 1, 1, 14, 20, 38), datetime(2020, 1, 1, 14, 21, 39)]
