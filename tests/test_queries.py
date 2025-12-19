from datetime import datetime

import pytest
from sqlalchemy.exc import NoResultFound

from dscreator.sources.odm2 import queries as odm2_queries
from dscreator.sources.ferrybox import queries as fb_queries


@pytest.mark.docker
def test_point_by_sampling_code_success(db_engine):
    point = odm2_queries.point_by_sampling_code(db_engine, "MSOURCE1")
    assert point.longitude == 10.7484615
    assert point.latitude == 59.943095


@pytest.mark.docker
def test_point_by_sampling_code_not_there(db_engine):
    with pytest.raises(NoResultFound):
        point = odm2_queries.point_by_sampling_code(db_engine, "Not There")


@pytest.mark.docker
def test_resultids(db_engine):
    resid = odm2_queries.resultuuids_by_code(db_engine, "MSOURCE1", "LevelValue")
    assert resid == "23a7cdcc-e61b-4993-a5fe-a18f35f860b2"


@pytest.mark.docker
def test_timeseries_values(db_engine):
    ts = odm2_queries.timeseries_by_resultuuid(
        db_engine, ["23a7cdcc-e61b-4993-a5fe-a18f35f860b2"], ["somevalue"], datetime(2022, 9, 14), datetime(2022, 9, 15)
    )
    assert len(ts) == 2
    assert ts[0]["somevalue"] == 0.128


@pytest.mark.docker
def test_spectra_values(db_engine):
    ts = fb_queries.get_spectra(
        db_engine,
        "4d9ff393-25a3-47b8-aaf1-8fbbccfec3c3",
        ["f8a2e40c-1225-4b51-8a07-eb2051a5d736"],
        [344],
        datetime(2025, 2, 5),
        datetime(2025, 2, 6),
    )

    assert len(ts) == 2
    
