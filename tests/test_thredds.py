from unittest import mock
import pytest
from dataexport import thredds
from dataexport.config import Settings

settings = Settings()
THREDDS_DATASETS = f"{settings.thredds_url}/thredds/dodsC/datasets"


@pytest.mark.parametrize(
    "text,expected",
    [
        ("Dataset {\n    Int32 time[time = 192];\n} datasets/sios.nc;\n", 192),
        ("Dataset {\n    Int32 time[time = 0];\n} datasets/sios.nc;\n", 0),
    ],
)
def test_dds_to_index(text, expected):
    assert thredds.dds_to_index(text) == expected


@pytest.mark.parametrize(
    "text,expected",
    [
        ("Dataset {\n    Int32 time[time = 192];\n} datasets/sios.nc;\n", 192),
        ("Dataset {\n    Int32 time[time = 0];\n} datasets/sios.nc;\n", 0),
        ("Error {\n    code = 404;\n    message = 'datasets/siosf.nc (No such file or directory)';\n};\n", None),
    ],
)
def test_last_index(requests_mock, text, expected):
    requests_mock.get(f"{THREDDS_DATASETS}/sample.nc.dds?time", text=text)
    assert thredds.get_last_index("sample", "time") == expected
