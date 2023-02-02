from datetime import datetime, timedelta

import pytest
from sqlalchemy.exc import NoResultFound

from dataexport.sources import odm2


@pytest.fixture
def msource_extractor(odm2engine) -> odm2.extractor.TimeseriesExtractor:
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        odm2engine,
        sampling_feature_code="MSOURCE1",
        variable_codes=[
            "Temp",
            "LevelValue",
            "Turbidity",
        ],
    )
    return timeseries_extractor


@pytest.mark.docker
def test_timeseries_extractor_timestamps(msource_extractor):
    assert msource_extractor.first_timestamp() == datetime(2022, 9, 14, 14, 20) - timedelta(minutes=1)
    assert msource_extractor.last_timestamp() == datetime(2022, 9, 19, 10, 52, 30) + timedelta(minutes=1)


@pytest.mark.docker
def test__extractor_values(msource_extractor):
    ts_list = msource_extractor.fetch_slice(datetime(2022, 9, 14, 14, 20), datetime(2022, 9, 15, 14, 20))
    assert len(ts_list) == 3
    assert ts_list[0].variable_name == "Temp"
    assert ts_list[2].variable_name == "Turbidity"
    assert ts_list[0].values == [22.1]

    ts_list_bigger_window = msource_extractor.fetch_slice(datetime(2022, 9, 14, 14, 19), datetime(2022, 9, 15, 14, 20))
    assert ts_list_bigger_window[0].values == [22.8, 22.1]
