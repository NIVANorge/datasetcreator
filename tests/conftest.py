import pytest

import os


def pytest_generate_tests(metafunc):
    os.environ["DB_HOST"] = "dbhost"
    os.environ["DB_USER"] = "dbuser"
    os.environ["THREDDS_SERVER"] = "thredds"
