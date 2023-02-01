import abc
import logging
from dataclasses import asdict, dataclass
from typing import List

import xarray as xr

from dataexport.cfarray.base import DatasetAttrs
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.cfarray.trajectory import trajectorycoords, trajectorydataset
from dataexport.sources.base import NamedTimeArray, NamedTimeseries, NamedTrajectory


@dataclass
class DatasetBuilder(abc.ABC):
    uuid: str
    title: str
    summary: str
    dataset_name: str
    station_name: str
    project_name: str
    is_acdd: bool

    @abc.abstractmethod
    def create(self, named_timeseries: List[NamedTimeArray]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""
        pass

    @abc.abstractmethod
    def cftimearray(self, timeseries: NamedTimeArray) -> xr.DataArray:
        """Convert a NamedTimearray to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """
        pass

    @abc.abstractmethod
    def map_to_cfarray(self, timeseries: NamedTimeArray) -> xr.DataArray:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        pass

    def add_acdd(self, ds: xr.Dataset) -> xr.Dataset:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset
        """
        logging.info(f"Adding ACDD attributes")
        ds.attrs.update(asdict(self.dataset_attributes(ds)))
        return ds

    @abc.abstractmethod
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:
        pass

@dataclass
class TimeseriesDatasetBuilder(DatasetBuilder):
    def create(self, named_timeseries: List[NamedTimeseries]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        time_arrays = map(self.cftimearray, named_timeseries)

        ds = timeseriesdataset(named_dataarrays=list(time_arrays), station_name=self.station_name)
        ds.attrs["id"] = self.uuid

        logging.info("Created xarray dataset")

        return self.add_acdd(ds) if self.is_acdd else ds

    def cftimearray(self, timeseries: NamedTimeseries) -> xr.DataArray:
        """Convert a NamedTimeseries to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """

        array = self.map_to_cfarray(timeseries)

        return array.assign_coords(
            timeseriescoords(
                time=timeseries.datetime,
                latitude=timeseries.locations[0].latitude,
                longitude=timeseries.locations[0].longitude,
            )
        )

@dataclass
class TrajectoryDatasetBuilder(DatasetBuilder):
    def create(self, named_timeseries: List[NamedTrajectory]) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        time_arrays = map(self.cftimearray, named_timeseries)
        ds = trajectorydataset(named_dataarrays=list(time_arrays), trajectory_name=self.station_name)
        ds.attrs["id"] = self.uuid

        logging.info("Created xarray dataset")

        return self.add_acdd(ds) if self.is_acdd else ds

    def cftimearray(self, timeseries: NamedTrajectory) -> xr.DataArray:
        """Convert a NamedTimeseries to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """

        array = self.map_to_cfarray(timeseries)

        return array.assign_coords(
            trajectorycoords(
                time=timeseries.datetime,
                latitude=[loc.latitude for loc in timeseries.locations],
                longitude=[loc.longitude for loc in timeseries.locations],
            )
        )