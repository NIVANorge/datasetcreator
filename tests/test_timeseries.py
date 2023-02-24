from datetime import datetime

from dscreator.datasets.timeseries import msource
from dscreator.sources.base import NamedTimeseries, Point, NamedTimeArray
import numpy as np


def test_timeseries_builder():

    array1 = NamedTimeArray(
        "LevelValue",
        values=[1, 2, 3],
        locations=[Point(10.70, 50.70)],
        datetime_list=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
    )

    array2 = NamedTimeArray(
        "Temp",
        values=[101, 100],
        locations=[Point(10.70, 50.70)],
        datetime_list=[datetime(1909, 10, 4), datetime(1909, 10, 5)],
    )

    example_builder = msource.MSourceInletBuilder("uuid", "dataset_name", "station_name", "project_name", True)

    ds = example_builder.create(NamedTimeseries(array_list=[array1, array2]))

    assert len(ds.levelvalue) == 5
    assert ds.longitude == 10.70
    assert ds.latitude == 50.70
    print(ds.levelvalue)
    assert all([np.isnan(v) for v in ds.levelvalue[:2]])
    assert all([actual == expected for actual, expected in zip(ds.levelvalue[2:], [1, 2, 3])])
