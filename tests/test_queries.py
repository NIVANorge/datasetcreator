from dataexport.sources.odm2 import queries
import pytest
from sqlalchemy import create_engine
from datetime import datetime
from sqlalchemy.exc import NoResultFound


@pytest.fixture(scope="module")
def engine(docker_ip, docker_services):
    port = docker_services.port_for("test-odm2", 5432)
    host = docker_ip
    dsn = f"postgresql://postgres:postgres@{host}:{port}/odm2"
    return create_engine(dsn)

@pytest.mark.docker
def test_point_by_sampling_code_success(engine):
    
    point = queries.point_by_sampling_code(engine, "MSOURCE1")
    assert point.longitude == 10.7484615
    assert point.latitude == 59.943095

@pytest.mark.docker
def test_point_by_sampling_code_not_there(engine):
    
    with pytest.raises(NoResultFound):
        point = queries.point_by_sampling_code(engine, "Not There")
    

@pytest.mark.docker
def test_resultids(engine):
     resid = queries.resultuuids_by_code(engine, "MSOURCE1", "LevelValue")
     assert resid=="23a7cdcc-e61b-4993-a5fe-a18f35f860b2"

@pytest.mark.docker
def test_point_by_sampling_code_success(engine):
    ts = queries.timeseries_by_resultuuid(engine, "23a7cdcc-e61b-4993-a5fe-a18f35f860b2", datetime(2022, 9, 14), datetime(2022, 9, 15))
    assert len(ts.values) == 2