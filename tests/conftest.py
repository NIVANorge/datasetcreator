import os

import pytest
from sqlalchemy import create_engine


def pytest_generate_tests(metafunc):
    os.environ["DATABASE_URL"] = "postgresql://postgres:postgres@127.0.0.1:32998/db"
    os.environ["STORAGE_PATH"] = "./tests/data"
    os.environ["THREDDS_URL"] = "http://thredds"


@pytest.fixture(scope="session")
def db_engine(docker_ip, docker_services):
    port = docker_services.port_for("test-db", 5432)
    host = docker_ip

    return create_engine(f"postgresql://postgres:postgres@{host}:{port}/db")
