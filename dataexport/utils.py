import logging
import os
import tempfile
from dataclasses import dataclass
from datetime import datetime, timedelta
from typing import List

import numpy as np
import xarray as xr
from google.cloud import storage

from dataexport.cfarray.base import DEFAULT_ENCODING
from dataexport.config import SETTINGS


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


def save_dataset(ds: xr.Dataset, project_name: str, filename: str):

    first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s").replace(":", "")
    filepath = os.path.join("datasets", project_name.lower(), f"{first_timestamp}_{filename.lower()}.nc")

    if SETTINGS.storage_path.startswith("gs://"):
        storage_client = storage.Client()
        tmp_file = tempfile.NamedTemporaryFile()
        ds.to_netcdf(tmp_file.name, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)
        bucket = storage_client.bucket(SETTINGS.storage_path)
        blob = bucket.blob(filepath)
        blob.upload_from_filename(tmp_file.name)
        tmp_file.close()
        filepath = os.path.join(SETTINGS.storage_path, filepath)
    else:
        filepath = os.path.join(SETTINGS.storage_path, filepath)
        os.makedirs(os.path.dirname(filepath), exist_ok=True)
        ds.to_netcdf(filepath, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

    logging.info(f"Data {ds.time[0]} --> {ds.time[-1]} exported to {filepath}")
