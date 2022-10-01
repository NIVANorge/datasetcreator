from datetime import datetime
import numpy as np
import pytest
from datetime import datetime, timedelta

from dataexport import utils


def test_numpy_to_datetime():
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "s")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "us")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "ns")) == datetime(2019, 8, 26)


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
    assert intervals[-1].start_time + delta == intervals[-1].end_time
