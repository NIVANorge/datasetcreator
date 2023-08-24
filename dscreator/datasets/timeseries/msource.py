import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import DatasetAttrsDiscrete, VariableAttrs
from dscreator.cfarray.base import dataarraybytime
from dscreator.datasets.base import TimeseriesDatasetBuilder
from dscreator.sources.odm2.extractor import NamedTimeseries


@dataclass
class MSourceInletBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        A good keywords viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer

        """
        return DatasetAttrsDiscrete(
            title="MULTISOURCE/DIGIVEIVANN Inlet",
            title_no="MULTISOURCE/DIGIVEIVANN Innløp",
            summary="In the MULTISOURCE/DigiVEIVANN project, we are testing a rain garden as a nature-based solution for water treatment (NBSWT) to treat road runoff.",
            summary_no="I prosjektet MULTISOURCE/DigiVEIVANN så tester vi regnbed som en naturbasert renseløsning for forurenset overvann.",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL IMPACTS > WATER RESOURCES",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL GOVERNANCE/MANAGEMENT > WATER MANAGEMENT > WATER STORAGE",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL GOVERNANCE/MANAGEMENT > WATER MANAGEMENT > STORMWATER MANAGEMENT",
                    "GCMDSK:EARTH SCIENCE > BIOSPHERE > ECOSYSTEMS > ANTHROPOGENIC/HUMAN INFLUENCED ECOSYSTEMS > URBAN LANDS > ROADSIDE",
                    "GCMDSK:EARTH SCIENCE > ATMOSPHERE > PRECIPITATION > PRECIPITATION PROFILES > RAIN WATER PATH",
                    "GCMDSK:EARTH SCIENCE > TERRESTRIAL HYDROSPHERE > WATER QUALITY/WATER CHEMISTRY",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                ]
            ),
            iso_topic_category="inlandWaters",
            featureType=ds.attrs["featureType"],
            date_created=str(datetime.now()),
            project=self.project_name,
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
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
                    attrs=VariableAttrs(
                        short_name="temperature", long_name="Rain Garden Water Temperature", units="degree_Celsius"
                    ),
                )
                array.attrs["comment"] = "An operational parameter affected by a heating device during winter"
            case "LevelValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="levelvalue",
                    attrs=VariableAttrs(short_name="water_level", long_name="Water Level Weir Box", units="m"),
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    attrs=VariableAttrs(
                        short_name="turbidity", long_name="Rain Garden Water Turbidity", units="NTU"
                    ),
                )
            case "CondValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="conductivity",
                    attrs=VariableAttrs(
                        short_name="conductivity", long_name="Rain Garden Water Conductivity", units="uS cm-1"
                    ),
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_name}")
                raise RuntimeError(f"Array definition not found for: {timeseries.variable_name}")

        return array


@dataclass
class MSourceOutletBuilder(MSourceInletBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        For more information on keywords this is the best resource https://gcmd.earthdata.nasa.gov/KeywordViewer/. We can add keywords and
        also link to the vocabulary.
        """
         
        return DatasetAttrsDiscrete(
            title="MULTISOURCE/DIGIVEIVANN Outlet",
            title_no="MULTISOURCE/DIGIVEIVANN Utløp",
            summary="In the MULTISOURCE/DigiVEIVANN project, we are testing a rain garden as a nature-based solution for water treatment (NBSWT) to treat road runoff.",
            summary_no="I prosjektet MULTISOURCE/DigiVEIVANN så tester vi regnbed som en naturbasert renseløsning for forurenset overvann.",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL IMPACTS > WATER RESOURCES",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL GOVERNANCE/MANAGEMENT > WATER MANAGEMENT > WATER STORAGE",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL GOVERNANCE/MANAGEMENT > WATER MANAGEMENT > STORMWATER MANAGEMENT",
                    "GCMDSK:EARTH SCIENCE > BIOSPHERE > ECOSYSTEMS > ANTHROPOGENIC/HUMAN INFLUENCED ECOSYSTEMS > URBAN LANDS > ROADSIDE",
                    "GCMDSK:EARTH SCIENCE > ATMOSPHERE > PRECIPITATION > PRECIPITATION PROFILES > RAIN WATER PATH",
                    "GCMDSK:EARTH SCIENCE > TERRESTRIAL HYDROSPHERE > WATER QUALITY/WATER CHEMISTRY",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                ]
            ),
            iso_topic_category="inlandWaters",
            featureType=ds.attrs["featureType"],
            date_created=str(datetime.now()),
            project=self.project_name,
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
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
            case "LevelValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="levelvalue",
                    attrs=VariableAttrs(short_name="water_level", long_name="Water Level Manhole", units="m"),
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    attrs=VariableAttrs(
                        short_name="turbidity", long_name="Rain Garden Water Turbidity", units="NTU"
                    ),
                )
            case "CondValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="conductivity",
                    attrs=VariableAttrs(
                        short_name="conductivity", long_name="Rain Garden Water Conductivity", units="uS cm-1"
                    ),
                )     
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_name}")
                raise RuntimeError(f"Array definition not found for: {timeseries.variable_name}")

        return array
