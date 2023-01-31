import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime

from dataexport.datasets.base import TimeseriesDatasetBuilder
from dataexport.sources.odm2.extractor import NamedTimeseries


@dataclass
class MSourceBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset
        """
        return DatasetAttrs(
            title=self.title,
            summary=self.summary,
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
                    standard_name="rainbed_level",
                    long_name="Rainbed Water Level",
                    units="m",
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    standard_name="rainbed_turbidity",
                    long_name="Rainbed Water Turbidity",
                    units="m",
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_name}")
                # raise RuntimeError("Unknown variable code")

        return array


@dataclass
class SiosBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset
        """
        return DatasetAttrs(
            title=self.title,
            summary=self.summary,
            keywords=[
                "Water-based Platforms > Buoys > Moored > BUOYS",
                "EARTH SCIENCE > Oceans > Salinity/Density > Salinity",
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
                    standard_name="sea_water_temperature",
                    long_name="Sea Water Temperature",
                    units="degree_Celsius",
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    standard_name="sea_water_turbidity",
                    long_name="Sea Water Turbidity",
                    units="NTU",
                )
            case "Salinity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="salinity",
                    standard_name="sea_water_salinity",
                    long_name="Sea Water Salinity",
                    units="1e-3",
                )
            case "ChlaValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="chlorophylla",
                    standard_name="mass_concentration_of_chlorophyll_a_in_sea_water",
                    long_name="Mass Concentration of Chlorophyll A in Sea Water",
                    units="µg/l",
                )
            case "CondValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="conductivity",
                    standard_name="sea_water_electrical_conductivity",
                    long_name="Sea Water Conductivity",
                    units="S/m",
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_code}")
                # raise RuntimeError("Unknown variable code")
        return array
