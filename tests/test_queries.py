from datetime import datetime

import pytest
from sqlalchemy.exc import NoResultFound

from dscreator.sources.odm2 import queries


@pytest.mark.docker
def test_point_by_sampling_code_success(db_engine):
    point = queries.point_by_sampling_code(db_engine, "MSOURCE1")
    assert point.longitude == 10.7484615
    assert point.latitude == 59.943095


@pytest.mark.docker
def test_point_by_sampling_code_not_there(db_engine):
    with pytest.raises(NoResultFound):
        point = queries.point_by_sampling_code(db_engine, "Not There")


@pytest.mark.docker
def test_resultids(db_engine):
    resid = queries.resultuuids_by_code(db_engine, "MSOURCE1", "LevelValue")
    assert resid == "23a7cdcc-e61b-4993-a5fe-a18f35f860b2"


@pytest.mark.docker
def test_timeseries_values(db_engine):
    ts = queries.timeseries_by_resultuuid(
        db_engine, "23a7cdcc-e61b-4993-a5fe-a18f35f860b2", datetime(2022, 9, 14), datetime(2022, 9, 15)
    )
    assert len(ts.values) == 2
