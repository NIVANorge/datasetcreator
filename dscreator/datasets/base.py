import abc
import logging
from dataclasses import asdict, dataclass

import xarray as xr

from dscreator.cfarray.attributes import DatasetAttrsDiscrete
from dscreator.cfarray.time_series import timeseriescoords
from dscreator.cfarray.trajectory import trajectorycoords
from dscreator.cfarray.base import idarray
from dscreator.cfarray.dims import TIME


@dataclass
class DatasetBuilder(abc.ABC):
    uuid: str
    dataset_name: str
    station_name: str
    project_name: str
    is_acdd: bool

    @abc.abstractmethod
    def create(self, data_dict: dict[str, dict]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""
        pass

    @abc.abstractmethod
    def variable_attributes(self, variable_name: str) -> dict:
        """Match variable name to C&F

        Match variable name to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        pass

    def add_acdd(self, ds: xr.Dataset):
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset
        """
        logging.info(f"Adding ACDD attributes")
        ds.attrs.update(asdict(self.dataset_attributes(ds)))

    @abc.abstractmethod
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        pass


@dataclass
class TimeseriesDatasetBuilder(DatasetBuilder):
    def create(self, data_dict: dict[str, list]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        ds = xr.Dataset.from_dict(
            {k: dict(dims=(TIME), data=data_dict[k]) for k in data_dict if k not in ["latitude", "longitude"]}
        )
        ds = ds.assign_coords(
            timeseriescoords(
                time=ds.time,
                latitude=data_dict["latitude"][0],
                longitude=data_dict["longitude"][0],
            )
        )
        for variable in ds.data_vars:
            ds[variable].attrs = self.variable_attributes(variable)

        ds.attrs["id"] = self.uuid
        ds["station_name"] = idarray(self.station_name, "timeseries_id")
        ds.attrs["featureType"] = "timeseries"

        if self.is_acdd and ds.dims["time"] > 0:
            # need to have data to add acdd
            self.add_acdd(ds)

        return ds


@dataclass
class TrajectoryDatasetBuilder(DatasetBuilder):
    def create(self, data_dict: dict[str, list]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        ds = xr.Dataset.from_dict({k: dict(dims=(TIME), data=data_dict[k]) for k in data_dict})

        ds = ds.assign_coords(
            trajectorycoords(
                time=data_dict["time"],
                latitude=data_dict["latitude"],
                longitude=data_dict["longitude"],
            )
        )

        for variable in ds.data_vars:
            ds[variable].attrs = self.variable_attributes(variable)

        ds.attrs["id"] = self.uuid
        ds["trajectory_name"] = idarray(self.station_name, "trajectory_id")
        ds.attrs["featureType"] = "trajectory"

        if self.is_acdd and ds.dims["time"] > 0:
            # need to have data to add acdd
            self.add_acdd(ds)

        return ds
