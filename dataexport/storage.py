import abc
import json
import logging
import os
import tempfile
from dataclasses import asdict, dataclass, field
from datetime import datetime, timedelta
from typing import Optional

import numpy as np
import xarray as xr
from google.cloud import storage

from dataexport import utils
from dataexport.cfarray.base import DEFAULT_ENCODING
from dataexport.config import SETTINGS


@dataclass
class RestartInfo:
    end_time: datetime


@dataclass
class BaseHandler(abc.ABC):
    """Handles read and write of files

    Each file is written into a folder `datasets/{project_name}/{dataset_name}` folder.
    The filename starts with the timestamps followed with underscore dataset_name.
    """

    project_name: str
    dataset_name: str
    workdir: str = field(init=False)
    restart_filepath: str = field(init=False)

    def __post_init__(self):
        self.workdir = os.path.join("datasets", self.project_name.lower(), self.dataset_name)
        self.restart_filepath = os.path.join(self.workdir, "." + self.dataset_name + ".restart.json")

    def dataset_to_filename(self, ds: xr.Dataset):
        first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s").replace(":", "")
        return os.path.join(self.workdir, f"{first_timestamp}_{self.dataset_name.lower()}.nc")

    def _restart_dict(self, ds: xr.Dataset) -> dict:
        return {"end_time": utils.numpy_to_datetime(ds.time[-1].values).isoformat()}

    def _restart_info(self, raw_dict: dict) -> RestartInfo:
        end_time = datetime.fromisoformat(raw_dict["end_time"])
        return RestartInfo(end_time)

    @abc.abstractmethod
    def save_dataset(self, ds: xr.Dataset):
        pass

    @abc.abstractmethod
    def save_restart(self, ds: xr.Dataset):
        """Fetch restart info from the given storage"""
        pass

    @abc.abstractmethod
    def open_restart(self) -> Optional[RestartInfo]:
        """Fetch restart info from the given storage"""
        pass


@dataclass
class GCSStorageHandler(BaseHandler):
    """Handles read and write of files

    Each file is written into a folder `datasets/{project_name}` folder.
    The filename starts with the timestamps followed with underscore dataset_name.
    """

    bucket_name: str

    def save_dataset(self, ds: xr.Dataset):
        """Save the dataset to a gcs bucket"""

        storage_client = storage.Client()
        filepath = self.dataset_to_filename(ds)

        tmp_file = tempfile.NamedTemporaryFile()
        ds.to_netcdf(tmp_file.name, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)
        bucket = storage_client.bucket(self.bucket_name)
        blob = bucket.blob(filepath)
        blob.upload_from_filename(tmp_file.name)
        tmp_file.close()
        save_location = os.path.join(SETTINGS.storage_path, filepath)

        logging.info(f"Data {ds.time[0].values} --> {ds.time[-1].values} exported to {save_location}")

    def save_restart(self, ds: xr.Dataset):
        """Fetch restart info from the given storage"""
        storage_client = storage.Client()
        bucket = storage_client.bucket(self.bucket_name)
        blob = bucket.blob(self.restart_filepath)
        blob.upload_from_string(json.dumps(self._restart_dict(ds)))
        logging.info(f"Saved restart info to bucket gs://{bucket}/{self.restart_filepath}")

    def open_restart(self) -> Optional[RestartInfo]:
        """Fetch restart info from the given storage"""
        storage_client = storage.Client()
        bucket = storage_client.bucket(self.bucket_name)
        blob = bucket.blob(self.restart_filepath)
        if blob.exists():
            restart_dict = json.loads(blob.download_as_string())
            return self._restart_info(restart_dict)
        if len([b for b in bucket.list_blobs(prefix=self.workdir, max_results=2)]) == 0:
            return None
        raise RuntimeError("Failing due to missing restart file")


@dataclass
class LocalStorageHandler(BaseHandler):
    """Handles read and write of files

    Each file is written into a folder `datasets/{project_name}` folder.
    The filename starts with the timestamps followed with underscore dataset_name.
    """

    def save_dataset(self, ds: xr.Dataset):
        """Save the dataset to the local filesystem"""

        filepath = self.dataset_to_filename(ds)

        save_location = os.path.join(SETTINGS.storage_path, filepath)
        os.makedirs(os.path.dirname(save_location), exist_ok=True)
        ds.to_netcdf(save_location, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

        logging.info(f"Data {ds.time[0].values} --> {ds.time[-1].values} exported to {save_location}")

    def save_restart(self, ds: xr.Dataset):
        """Fetch restart info from the given storage"""
        restart_dict = self._restart_dict(ds)
        save_location = os.path.join(SETTINGS.storage_path, self.restart_filepath)

        with open(save_location, "w") as f:
            json.dump(restart_dict, f)

        logging.info(f"Saved restart info to {save_location}")

    def open_restart(self) -> Optional[RestartInfo]:
        """Fetch restart info from the given storage

        If this is the first run towards a storage location return None.
        """

        restart_location = os.path.join(SETTINGS.storage_path, self.restart_filepath)
        dataset_dir = os.path.join(SETTINGS.storage_path, self.workdir)

        if os.path.exists(restart_location):
            with open(restart_location, "r") as f:
                restart_dict = json.load(f)
            return self._restart_info(restart_dict)
        elif not os.path.exists(dataset_dir):
            return None
        elif len([f for f in os.listdir(dataset_dir)]) == 0:
            return None

        raise RuntimeError("Failing due to missing restart file")


def get_storage_handler(project_name: str, dataset_name: str) -> BaseHandler:
    if SETTINGS.storage_path.startswith("gs://"):
        return GCSStorageHandler(project_name, dataset_name, bucket_name=SETTINGS.storage_path.removeprefix("gs://"))
    else:
        return LocalStorageHandler(project_name, dataset_name)
