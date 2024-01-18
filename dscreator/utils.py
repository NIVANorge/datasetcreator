import logging
from dataclasses import dataclass
from datetime import datetime, timedelta
from typing import List, Union

import numpy as np
import pytz
import xarray as xr


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


def to_isoformat(date_time: Union[np.datetime64, datetime]) -> str:
    """Convert datetime to iso str"""
    if isinstance(date_time, np.datetime64):
        dt = numpy_to_datetime(date_time)
    else:
        dt = date_time
    return dt.strftime("%Y-%m-%dT%H:%M:%SZ")


def from_isoformat(iso_str: str) -> datetime:
    """Convert iso str to datetime"""
    return datetime.strptime(iso_str, "%Y-%m-%dT%H:%M:%SZ")

def iso_now() -> str:
    return to_isoformat(datetime.utcnow())

@dataclass
class DatetimeInterval:
    start_time: datetime
    end_time: datetime


def datetime_intervals(start_time: datetime, end_time: datetime, delta: timedelta) -> List[DatetimeInterval]:
    """Generate datetime intervals of size delta"""

    intervals = []
    current = start_time
    logging.info(f"current {current} and end_time {end_time}")
    while current < end_time:
        intervals.append(DatetimeInterval(current, current + delta))
        current = intervals[-1].end_time
    return intervals
