import logging
import xarray as xr
from dataclasses import dataclass, asdict
import abc
from typing import List
from dataexport.sources.odm2.extractor import NamedTimeseries
from dataexport.cfarray.base import DatasetAttrs
from dataexport.cfarray.time_series import timeseriesdataset, timeseriescoords


@dataclass
class TimeseriesDatasetBuilder(abc.ABC):
    uuid: str
    title: str
    summary: str
    dataset_name: str
    station_name: str
    project_name: str
    is_acdd: bool

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
                latitude=timeseries.location.latitude,
                longitude=timeseries.location.longitude,
            )
        )

    @abc.abstractmethod
    def map_to_cfarray(self, timeseries: NamedTimeseries) -> xr.DataArray:
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
