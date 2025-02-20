import logging
from dataclasses import dataclass

import xarray as xr
from dataclasses import asdict

from dscreator import utils
from dscreator.cfarray.attributes import VariableAttrs, DatasetAttrsDiscrete
from dscreator.datasets.base import TimeseriesDatasetBuilder


@dataclass
class GlommaBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        A good keywords viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer.
        For converting CF standard names erddap also contains a good converter for cf standard names.
        """
        return DatasetAttrsDiscrete(
            title="Sensor station at Baterød in Glomma",
            summary="Water quality sensor measurements collected in the Glomma river at Baterød waterworks. The purpose of the station is to monitor natural dynamics and trends in important physical and chemical water properties.",
            title_no="Sensorstasjon ved Baterød i nedre Glomma",
            summary_no="Vannkvalitets målinger fra sensorstasjon i Glomma ved Baterød vannverk. Hensikten med stasjonen er å overvåke naturlig dynamikk og trender i viktige fysisk-kjemiske vannkvalitetsparametere.",
            keywords=",".join(
                [
                    # GEMET & NORTHEMES
                    "GCMDSK:EARTH SCIENCE > TERRESTRIAL HYDROSPHERE > SURFACE WATER > SURFACE WATER FEATURES > RIVERS/STREAMS",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                    "GEMET:Hydrography",
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
            project="Elveovervåkingsprogrammet,AquaINFRA",
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
            spatial_representation="point",
            collection="ADC",
        )

    def variable_attributes(self, variable_name) -> dict:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        match variable_name:
            case "temp_water_avg":
                return asdict(
                    VariableAttrs(
                        short_name="water_temperature", long_name="River Water Temperature", units="degree_Celsius"
                    )
                )
            case "phvalue_avg":
                return asdict(VariableAttrs(short_name="water_ph", long_name="River Water pH", units=""))
            case "condvalue_avg":
                return asdict(
                    VariableAttrs(
                        short_name="water_electrical_conductivity",
                        long_name="River Water Conductivity",
                        units="µS/cm",
                    )
                )
            case "turbidity_avg":
                return asdict(
                    VariableAttrs(short_name="water_turbidity", long_name="River Water Turbidity", units="NTU")
                )
            case "cdomdigitalfinal":
                return asdict(
                    VariableAttrs(
                        short_name="water_cdom",
                        long_name="Colored Dissolved Organic Matter In River Water",
                        units="µg/l",
                    )
                )
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")
