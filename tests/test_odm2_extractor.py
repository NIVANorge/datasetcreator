from datetime import datetime, timedelta

import pytest
from sqlalchemy.exc import NoResultFound

from dscreator.sources import odm2


@pytest.fixture
def msource_extractor(db_engine) -> odm2.extractor.TimeseriesExtractor:
    timeseries_extractor = odm2.extractor.TimeseriesExtractor(
        db_engine,
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
def test_extractor_values(msource_extractor):
    data_dict = msource_extractor.fetch_slice(datetime(2022, 9, 14, 14, 20), datetime(2022, 9, 15, 14, 20))
    assert len(data_dict) == 6
    assert "temp" in data_dict
    assert "turbidity" in data_dict
    assert data_dict["temp"] == [22.1]

    ts_list_bigger_window = msource_extractor.fetch_slice(datetime(2022, 9, 14, 14, 19), datetime(2022, 9, 15, 14, 20))
    assert ts_list_bigger_window["temp"] == [22.8, 22.1]
