import pytest
from dataexport.thredds import dds_to_index


@pytest.mark.parametrize(
    "text,expected",
    [
        ("Dataset {\n    Int32 time[time = 192];\n} datasets/sios.nc;\n", 192),
        ("Dataset {\n    Int32 time[time = 0];\n} datasets/sios.nc;\n", 0),
    ],
)
def test_dds_to_index(text, expected):
    assert dds_to_index(text) == expected
