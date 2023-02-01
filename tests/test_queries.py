from dataexport.sources.odm2 import queries
import pytest
from sqlalchemy import create_engine

@pytest.fixture(scope="module")
def engine(docker_ip, docker_services):
    port = docker_services.port_for("test-odm2", 5432)
    host = docker_ip
    dsn = f"postgresql://postgres:postgres@{host}:{port}/odm2"
    return create_engine(dsn)

@pytest.mark.docker
def test_timeseries_metadata(engine):
    
    point = queries.point_by_sampling_code(engine, "MSOURCE1")
    assert point.longitude == 10.7484615
    assert point.latitude == 59.943095
