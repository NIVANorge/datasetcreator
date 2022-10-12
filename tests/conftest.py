import os

import pytest


def pytest_generate_tests(metafunc):
    os.environ["DB_HOST"] = "dbhost"
    os.environ["DB_USER"] = "dbuser"
    os.environ["THREDDS_URL"] = "http://thredds"
