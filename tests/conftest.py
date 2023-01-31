import os

import pytest


def pytest_generate_tests(metafunc):
    os.environ["DATABASE_URL"] = "dbhost"
    os.environ["STORAGE_PATH"] = "./tests/data"
    os.environ["THREDDS_URL"] = "http://thredds"
