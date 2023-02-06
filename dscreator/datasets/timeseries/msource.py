import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dscreator.cfarray.base import DatasetAttrs, dataarraybytime
from dscreator.datasets.base import TimeseriesDatasetBuilder
from dscreator.sources.odm2.extractor import NamedTimeseries


@dataclass
class MSourceInletBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        A good keywords viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer

        """
        return DatasetAttrs(
            title="Test MSOURCE/DIGIVEIVANN Inlet",
            summary="Summary",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                ]
            ),
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

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        For more information on keywords this is the best resource https://gcmd.earthdata.nasa.gov/KeywordViewer/. We can add keywords and
        also link to the vocabulary.
        """
        return DatasetAttrs(
            title="Test MSOURCE/DIGIVEIVANN Outlet",
            summary="Summary",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                ]
            ),
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
