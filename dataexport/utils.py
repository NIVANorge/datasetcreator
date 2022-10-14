import logging
from dataclasses import dataclass
from datetime import datetime, timedelta
from typing import List

import numpy as np
import xarray as xr

from dataexport.cfarray.base import DEFAULT_ENCODING


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


def save_dataset(dataset_name: str, ds: xr.Dataset):

    first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s").replace(":", "")
    filename = f"{first_timestamp}_{dataset_name}.nc"
    ds.to_netcdf(filename, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

    logging.info(f"Data {ds.time[0]} --> {ds.time[-1]} exported")
