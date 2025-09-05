import logging
from dataclasses import dataclass

import xarray as xr
from dataclasses import asdict

from dscreator import utils
from dscreator.cfarray.attributes import VariableAttrs, DatasetAttrsDiscrete
from dscreator.datasets.base import TimeseriesDatasetBuilder


@dataclass
class UsageBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        A good keywords viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer.
        For converting CF standard names erddap also contains a good converter for cf standard names.
        """
        return DatasetAttrsDiscrete(
            title="",
            summary="",
            title_no="",
            summary_no="",
            keywords=",".join(
                [
                    # GEMET & NORTHEMES
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                    "NORTHEMES:Weather and climate",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDPLA:GCMD Platforms:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/platforms",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                    "GEMET:INSPIRE Themes:http://inspire.ec.europa.eu/theme",
                    "NORTHEMES:GeoNorge Themes:https://register.geonorge.no/metadata-kodelister/nasjonal-temainndeling",
                ]
            ),
            iso_topic_category="inlandWaters",
            featureType=ds.attrs["featureType"],
            date_created=utils.iso_now(),
            processing_level="Experimental",
            project="USAGE,AKVABY",
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
            spatial_representation="point",
            collection="",
        )

    def variable_attributes(self, variable_name) -> dict:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        match variable_name:
            case "temp":
                return asdict(
                    VariableAttrs(short_name="temperature", long_name="Water Temperature", units="degree_Celsius")
                )
            case "temp_air":
                return asdict(
                    VariableAttrs(short_name="temperature_air", long_name="Air Temperature", units="degree_Celsius")
                )
            case "phvalue":
                return asdict(VariableAttrs(short_name="pH", long_name="Water pH", units=""))
            case "oxygencon":
                return asdict(
                    VariableAttrs(
                        short_name="dissolved_oxygen_concentration",
                        long_name="Dissolved Oxygen Concentration in Water",
                        units="mg/l",
                    )
                )
            case "oxygensat":
                return asdict(
                    VariableAttrs(
                        short_name="dissolved_oxygen_saturation",
                        long_name="Dissolved Oxygen Saturation in Water",
                        units="%",
                    )
                )
            case "lf_psnt_avg":
                return asdict(
                    VariableAttrs(
                        short_name="humidity",
                        long_name="Humidity",
                        units="%RH",
                    )
                )
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")
