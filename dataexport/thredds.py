import logging
from typing import Optional

import requests
import xarray as xr
from datetime import datetime
from tenacity import retry, stop_after_attempt, wait_fixed

from dataexport.config import THREDDS_DATASET_URL
from dataexport import utils


def dds_to_index(dds_time_text: str) -> int:
    return int(dds_time_text.split("\n")[1].split("=")[-1].split("]")[0])


@retry(wait=wait_fixed(2), stop=stop_after_attempt(3))
def last_index(dataset_name: str, variable: str) -> Optional[int]:
    """Get dataset end index

    Get the last index for a dataset on the thredds server
    """
    res = requests.get(f"{THREDDS_DATASET_URL}/thredds/dodsC/datasets/{dataset_name}.nc.dds?{variable}")
    res.raise_for_status()
    if res.text.startswith("Error"):
        logging.error(res.text)
        return None
    return dds_to_index(res.text)


def end_time(dataset_name: str) -> datetime:
    """Get dataset end time

    Fetch the last timestamp for a dataset on the thredds server
    """
    start_time = xr.open_dataset(f"{THREDDS_DATASET_URL}/{dataset_name}.nc").time.values[-1]
    return utils.numpy_to_datetime(start_time)
