import logging
from typing import Optional

import requests
from tenacity import retry, stop_after_attempt, wait_fixed

from dataexport.config import THREDDS_DATASET_URL


def dds_to_index(dds_time_text: str) -> int:
    return int(dds_time_text.split("\n")[1].split("=")[-1].split("]")[0])


@retry(wait=wait_fixed(2), stop=stop_after_attempt(3))
def get_last_index(dataset_name: str, variable: str) -> Optional[int]:
    """Get last timestamp from thredds server

    Get the last timestamp for a given dataset on the thredds server
    """
    res = requests.get(f"{THREDDS_DATASET_URL}/thredds/dodsC/datasets/{dataset_name}.nc.dds?{variable}")
    res.raise_for_status()
    if res.text.startswith("Error"):
        logging.error(res.text)
        return None
    return dds_to_index(res.text)
