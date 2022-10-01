from dataclasses import dataclass
import numpy as np
from typing import List
from datetime import datetime, timedelta


def numpy_to_datetime(dt: np.datetime64) -> datetime:
    """convert ns numpy.datetime64 to datetime"""
    match dt.dtype:
        case "datetime64[s]":
            factor = 1
        case "datetime64[us]":
            factor = 1e6
        case "datetime64[ns]":
            factor = 1e9
    return datetime.utcfromtimestamp(dt.astype(int) / factor)


@dataclass
class DatetimeInterval:
    start_time: datetime
    end_time: datetime


def datetime_intervals(start_time: datetime, end_time: datetime, delta: timedelta) -> List[DatetimeInterval]:
    """Generate datetime intervals of size delta"""

    intervals = []
    current = start_time
    while current < end_time:
        intervals.append(DatetimeInterval(current, current + delta))
        current = intervals[-1].end_time
    return intervals
