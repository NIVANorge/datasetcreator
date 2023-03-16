import abc
import json
import logging
import os
import tempfile
from dataclasses import dataclass, field
from datetime import datetime
from typing import Dict, List, Optional

import xarray as xr
from google.cloud import storage

from dscreator import utils
from dscreator.cfarray.base import TIME_ENCODING
from dscreator.config import SETTINGS


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
    filename_prefix: str
    encoding: Dict
    workdir: str = field(init=False)
    restart_filepath: str = field(init=False)
    unlimited_dims: List[str]

    def __post_init__(self):
        self.workdir = os.path.join("datasets", self.project_name.lower(), self.dataset_name)
        self.restart_filepath = os.path.join(self.workdir, "." + self.dataset_name + ".restart.json")

    def save_netcdf(self, ds: xr.Dataset, filename: str):
        encoding = self.encoding
        if "time" in ds:
            encoding.update(TIME_ENCODING)
        ds.to_netcdf(filename, unlimited_dims=self.unlimited_dims, encoding=encoding)

    def dataset_to_filename(self, ds: xr.Dataset):
        prefix = self.filename_prefix
        if prefix is None:
            if "time" in ds:
                prefix = utils.to_isoformat(ds.time[0].values).replace(":", "-")
            else:
                prefix = ds.attrs["time_coverage_start"].replace(":", "-")

        filename = f"{prefix}_"
        if "Conventions" in ds.attrs and "ACDD" in ds.attrs["Conventions"]:
            filename += "acdd_"
        filename += f"{self.dataset_name.lower()}.nc"
        return os.path.join(self.workdir, filename)

    def _restart_dict(self, ds: xr.Dataset) -> dict:
        return {"end_time": utils.to_isoformat(ds.time[-1].values)}

    def _restart_info(self, raw_dict: dict) -> RestartInfo:
        end_time = utils.from_isoformat(raw_dict["end_time"])
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
        self.save_netcdf(ds, tmp_file.name)
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
        logging.info(f"Saved restart info to bucket gs://{self.bucket_name}/{self.restart_filepath}")

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
        self.save_netcdf(ds, save_location)

        logging.info(f"Exported to {save_location}")

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


def get_storage_handler(
    project_name: str,
    dataset_name: str,
    filename_prefix: Optional[str] = None,
    encoding: Optional[Dict] = None,
    unlimited_dims: Optional[List] = None,
) -> BaseHandler:
    """Return either cloud handler or local handler

    Wrapper that selects storage handler based on 'SETTINGS.storage_path' env variable.

    filename_prefix(optional): a prefix for the filename for dynamic data it is infered from the 'time' dimension
    encoding (optional): extra encoding for data variables, 'time' will use default from TIME_ENCODING. 
                         Try to avoid int64 encoding since it can be troublesome for some clients
    """
    if unlimited_dims is None:
        unlimited_dims = []

    if SETTINGS.storage_path.startswith("gs://"):
        return GCSStorageHandler(
            project_name=project_name,
            dataset_name=dataset_name,
            filename_prefix=filename_prefix,
            encoding=encoding,
            unlimited_dims=unlimited_dims,
            bucket_name=SETTINGS.storage_path.removeprefix("gs://"),
        )
    else:
        return LocalStorageHandler(
            project_name=project_name,
            dataset_name=dataset_name,
            filename_prefix=filename_prefix,
            encoding=encoding,
            unlimited_dims=unlimited_dims,
        )
