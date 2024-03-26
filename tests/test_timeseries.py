from datetime import datetime

import numpy as np

from dscreator.datasets.timeseries import msource
from dscreator.sources.base import Point


def test_timeseries_builder():
    data_dict = dict(
        levelvalue=[1, 2, 3],
        temp=[10, 11, 12],
        time=[datetime(1909, 10, 4), datetime(1909, 10, 5), datetime(1909, 10, 6)],
        latitude=[10.70],
        longitude=[50.70],
    )

    example_builder = msource.MSourceInletBuilder("uuid", "dataset_name", "station_name", "project_name", True)

    ds = example_builder.create(data_dict)

    assert len(ds.levelvalue) == 3
    assert ds.longitude.item(0) == 50.70
    assert ds.latitude.item(0) == 10.70
    assert ds.station_name == "station_name"
    assert all(ds.temp == [10, 11, 12])
    assert all(ds.levelvalue == [1, 2, 3])
    assert ds.levelvalue.attrs["long_name"] == "Water Level Weir Box"
    assert ds.levelvalue.attrs["units"] == "m"


def test_timeseries_builder():
    data_dict = dict(
        levelvalue=[1, 2, 3],
        condvalue=[10, 11, 12],
        time=[datetime(1909, 10, 4), datetime(1909, 10, 5), datetime(1909, 10, 6)],
        latitude=[10.70],
        longitude=[50.70],
    )

    example_builder = msource.MSourceOutletBuilder("uuid", "dataset_name", "station_name", "project_name", True)

    ds = example_builder.create(data_dict)

    assert len(ds.levelvalue) == 3
    assert ds.longitude.item(0) == 50.70
    assert ds.latitude.item(0) == 10.70
    assert ds.station_name == "station_name"
    assert all(ds.condvalue == [10, 11, 12])
    assert all(ds.levelvalue == [1, 2, 3])
    assert ds.levelvalue.attrs["long_name"] == "Water Level Manhole"
    assert ds.levelvalue.attrs["units"] == "m"


def test_empty_data():
    """Test that empty data creates an empty dataset. lat/lon should always be present."""

    data_dict = dict(
        levelvalue=[],
        time=[],
        latitude=[1],
        longitude=[1],
    )

    example_builder = msource.MSourceOutletBuilder("uuid", "dataset_name", "station_name", "project_name", True)

    ds = example_builder.create(data_dict)

    assert len(ds.levelvalue) == 0
