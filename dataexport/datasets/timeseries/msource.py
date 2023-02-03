import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.datasets.base import TimeseriesDatasetBuilder
from dataexport.sources.odm2.extractor import NamedTimeseries


@dataclass
class MSourceInletBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset.
        More information can be found here https://adc.met.no/node/96
        """
        return DatasetAttrs(
            title="Test MSOURCE/DIGIVEIVANN Inlet",
            summary="Summary",
            keywords=[
                "Land-based Platforms",
                "EARTH SCIENCE > LAND SURFACE",
            ],
            featureType=ds.attrs["featureType"],
            date_created=str(datetime.now()),
            project=self.project_name,
            time_coverage_start=str(ds.time.min().values),
            time_coverage_end=str(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
        )

    def map_to_cfarray(self, timeseries: NamedTimeseries) -> xr.DataArray:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        match timeseries.variable_name:
            case "Temp":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="temperature",
                    standard_name="rainbed_temperature",
                    long_name="Rainbed Water Temperature",
                    units="degree_Celsius",
                )
            case "LevelValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="levelvalue",
                    standard_name="rainbed_water_level",
                    long_name="Rainbed Water Level",
                    units="m",
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    standard_name="rainbed_turbidity",
                    long_name="Rainbed Water Turbidity",
                    units="NTU",
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_name}")
                raise RuntimeError(f"Array definition not found for: {timeseries.variable_name}")

        return array


@dataclass
class MSourceOutletBuilder(MSourceInletBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset.
        More information can be found here https://adc.met.no/node/96
        """
        return DatasetAttrs(
            title="Test MSOURCE/DIGIVEIVANN Outlet",
            summary="Summary",
            keywords=[
                "Land-based Platforms",
                "EARTH SCIENCE > LAND SURFACE",
            ],
            featureType=ds.attrs["featureType"],
            date_created=str(datetime.now()),
            project=self.project_name,
            time_coverage_start=str(ds.time.min().values),
            time_coverage_end=str(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
        )