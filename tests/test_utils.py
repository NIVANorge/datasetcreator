from datetime import datetime, timedelta

import numpy as np
import pytest
import xarray as xr

from dscreator import utils


def test_numpy_to_datetime():
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "s")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "us")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "ns")) == datetime(2019, 8, 26)


def test_to_isotime():
    assert utils.to_isoformat(np.datetime64("2019-08-26T12:10:30.00", "s")) == "2019-08-26T12:10:30Z"
    assert utils.to_isoformat(datetime(2020, 2, 2)) == "2020-02-02T00:00:00Z"


def test_from_isotime():
    assert utils.from_isoformat("2020-02-02T00:00:00Z") == datetime(2020, 2, 2)
    assert utils.from_isoformat("2020-02-02T05:00:05Z") == datetime(2020, 2, 2, 5, 0, 5)


@pytest.mark.parametrize(
    "start_time,end_time, delta, expected",
    [
        (
            datetime(2022, 9, 29, 9, 45),
            datetime(2022, 9, 30, 9, 45),
            timedelta(days=1),
            1,
        ),
        (
            datetime(2022, 10, 2, 6, 30),
            datetime(2022, 10, 12, 10, 45),
            timedelta(hours=24),
            11,
        ),
        (
            datetime(2022, 9, 20, 9, 45),
            datetime(2022, 9, 30, 9, 45),
            timedelta(days=1),
            10,
        ),
        (
            datetime(2022, 9, 30, 9, 45),
            datetime(2022, 9, 30, 10, 45),
            timedelta(minutes=30),
            2,
        ),
    ],
)
def test_time_interval(start_time, end_time, delta, expected):

    intervals = utils.datetime_intervals(start_time, end_time, delta)
    assert len(intervals) == expected
    assert intervals[0].start_time == start_time
    assert intervals[-1].start_time + delta == intervals[-1].end_time
