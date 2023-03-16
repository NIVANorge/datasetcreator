import abc
import logging
from dataclasses import asdict, dataclass
from typing import List

import xarray as xr

from dscreator.cfarray.attributes import DatasetAttrsDiscrete
from dscreator.cfarray.time_series import timeseriescoords, timeseriesdataset
from dscreator.cfarray.trajectory import trajectorycoords, trajectorydataset
from dscreator.sources.base import FeatureBase, NamedArray, NamedTimeArray, NamedTimeseries, NamedTrajectory


@dataclass
class DatasetBuilder(abc.ABC):
    uuid: str
    dataset_name: str
    station_name: str
    project_name: str
    is_acdd: bool

    @abc.abstractmethod
    def create(self, named_timeseries: FeatureBase) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""
        pass

    @abc.abstractmethod
    def cftimearray(self, timeseries: NamedArray) -> xr.DataArray:
        """Convert a NamedTimearray to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """
        pass

    @abc.abstractmethod
    def map_to_cfarray(self, timeseries: NamedArray) -> xr.DataArray:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
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
    def create(self, named_timeseries: NamedTimeseries) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        time_arrays = map(self.cftimearray, named_timeseries.array_list)

        ds = timeseriesdataset(named_dataarrays=list(time_arrays), station_name=self.station_name)
        ds.attrs["id"] = self.uuid

        if self.is_acdd and ds.dims["time"] > 0:
            # need to have data to add acdd
            self.add_acdd(ds)

        return ds

    def cftimearray(self, timeseries: NamedTimeArray) -> xr.DataArray:
        """Convert a NamedTimeseries to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """

        array = self.map_to_cfarray(timeseries)

        return array.assign_coords(
            timeseriescoords(
                time=timeseries.datetime_list,
                latitude=timeseries.locations[0].latitude,
                longitude=timeseries.locations[0].longitude,
            )
        )


@dataclass
class TrajectoryDatasetBuilder(DatasetBuilder):
    def create(self, named_trajectory: NamedTrajectory) -> xr.Dataset:
        """Entrypoint for creating a xarray dataset"""

        time_arrays = map(self.cftimearray, named_trajectory.array_list)
        ds = trajectorydataset(named_dataarrays=list(time_arrays), trajectory_name=self.station_name)
        ds = ds.assign_coords(
            trajectorycoords(
                time=named_trajectory.datetime_list,
                latitude=[loc.latitude for loc in named_trajectory.locations],
                longitude=[loc.longitude for loc in named_trajectory.locations],
            )
        )
        ds.attrs["id"] = self.uuid

        if self.is_acdd and ds.dims["time"] > 0:
            # need to have data to add acdd
            self.add_acdd(ds)

        return ds

    def cftimearray(self, timeseries: NamedArray) -> xr.DataArray:
        """Convert a NamedTimeseries to a coordinated dataarray

        The variables names are also mapped to C&F variables if possible.
        """

        array = self.map_to_cfarray(timeseries)

        return array
        #     .assign_coords(
        #     trajectorycoords(
        #         time=timeseries.datetime_list,
        #         latitude=[loc.latitude for loc in timeseries.locations],
        #         longitude=[loc.longitude for loc in timeseries.locations],
        #     )
        # )
