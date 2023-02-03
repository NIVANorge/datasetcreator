from datetime import datetime

from dscreator.datasets.timeseries import msource
from dscreator.sources.base import NamedTimeseries, Point


def test_timeseries_builder():

    time_series = NamedTimeseries(
        "LevelValue",
        locations=[Point(10.70, 50.70)],
        values=[1, 2, 3],
        datetime_list=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
    )

    example_builder = msource.MSourceInletBuilder("uuid", "dataset_name", "station_name", "project_name", True)

    ds = example_builder.create([time_series])

    assert len(ds.levelvalue) == 3
    assert ds.longitude == 10.70
    assert ds.latitude == 50.70
    assert all([actual == expected for actual, expected in zip(ds.levelvalue, [1, 2, 3])])
