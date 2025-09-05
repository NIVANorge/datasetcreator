import logging
from dataclasses import dataclass

import xarray as xr
from dataclasses import asdict

from dscreator import utils
from dscreator.cfarray.attributes import VariableAttrs, CFVariableAttrs, DatasetAttrsDiscrete
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
            title="AKVABY: environment and water surveillance in aquaponics pilot",
            summary="Continuous measurements of environmental and water quality parameters in the aquaponics pilot to ensure fish welfare, good growing conditions for growth in hydroponics and control of the facility. The aquaponics pilot is part of the project AKVABY, read more here: https://www.niva.no/prosjekter/akvaby.",
            title_no="AKVABY: Miljø- og vannkvalitetsovervåkning I akvaponipilot",
            summary_no="Kontinuerlige målinger av miljø- og vannkvalitetsparametere i akvaponipilot for å sikre fiskevelferd, gode vekstvilkår for vekst I hydroponi og kontroll av fasiliteten. Akvaponipiloten er en del av prosjektet AKVABY, les mer her: https://www.niva.no/prosjekter/akvaby.",
            keywords=",".join(
                [
                    # GEMET & NORTHEMES
                    "GCMDSK:EARTH SCIENCE > AGRICULTURE > AGRICULTURAL AQUATIC SCIENCES > AQUACULTURE",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > ENVIRONMENTAL GOVERNANCE/MANAGEMENT > WATER MANAGEMENT > STORMWATER MANAGEMENT",
                    "GCMDSK:EARTH SCIENCE > HUMAN DIMENSIONS > SUSTAINABILITY > SUSTAINABLE DEVELOPMENT",
                    "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
                    "GEMET:Agricultural and aquaculture facilities" "NORTHEMES:Agriculture",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                    "GEMET:INSPIRE Themes:http://inspire.ec.europa.eu/theme",
                    "NORTHEMES:GeoNorge Themes:https://register.geonorge.no/metadata-kodelister/nasjonal-temainndeling",
                ]
            ),
            iso_topic_category="farming",
            featureType=ds.attrs["featureType"],
            date_created=utils.iso_now(),
            processing_level="Raw Sensor Data",
            project="USAGE,AKVABY",
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
            case "temp":
                return asdict(
                    VariableAttrs(
                        short_name="temperature", long_name="Water Temperature Aquaponics", units="degree_Celsius"
                    )
                )
            case "temp_air":
                return asdict(
                    CFVariableAttrs(
                        standard_name="air_temperature", long_name="Air Temperature Aquaponics", units="degree_Celsius"
                    )
                )
            case "phvalue":
                return asdict(VariableAttrs(short_name="pH", long_name="Water pH Aquaponics", units=""))
            case "oxygencon":
                return asdict(
                    VariableAttrs(
                        short_name="oxygen_concentration",
                        long_name="Oxygen Concentration in Water Aquaponics",
                        units="mg/l",
                    )
                )
            case "oxygensat":
                return asdict(
                    VariableAttrs(
                        short_name="oxygen_saturation",
                        long_name="Oxygen Saturation in Water Aquaponics",
                        units="%",
                    )
                )
            case "lf_psnt_avg":
                return asdict(
                    VariableAttrs(
                        short_name="humidity",
                        long_name="Humidity Aquaponics",
                        units="%RH",
                    )
                )
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")
