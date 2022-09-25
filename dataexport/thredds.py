from typing import Optional
import requests
from tenacity import retry, wait_fixed, stop_after_attempt
from dataexport.config import Settings

settings = Settings()


def dds_to_index(dds_time_text: str) -> int:
    return int(dds_time_text.split("\n")[1].split("=")[-1].split("]")[0])


@retry(wait=wait_fixed(2), stop=stop_after_attempt(3))
def get_last_index(dataset_name: str, variable:str) -> Optional[int]:
    """Get last timestamp from thredds server

    Get the last timestamp for a given dataset on the thredds server 
    """
    res = requests.get(f"{settings.thredds_server}/thredds/dodsC/datasets/{dataset_name}.nc.dds?{variable}")

    res.raise_for_status()

    return dds_to_index(res.text) if res.text else None