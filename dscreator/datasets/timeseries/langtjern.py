import logging
from dataclasses import asdict, dataclass

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import DatasetAttrsDiscrete, VariableAttrs
from dscreator.datasets.base import TimeseriesDatasetBuilder

_DESCRIPTION = (
    "Climate change will lead to warming and changes in snowmelt and precipitation patterns. "
    "Such changes can affect lake ice cover and water temperatures, with possible consequences "
    "for fish and water-dwelling insects, food webs and oxygen availability. Also, greenhouse "
    "gas production, water color and acidity may be impacted. There are few lake ecosystems in "
    "Norway where such processes are studied in a comprehensive manner, while it is important "
    "both for research and policy to be able to study and document impacts of climate change on "
    "lakes. Therefore, NIVA initiated the establishment of a highly instrumented site for the "
    "study of climate impacts on lake processes. The existing long-term field site of Langtjern "
    "was chosen, which was established in the 1970s for monitoring of acid rain impacts on water "
    "quality and aquatic biology. Other research topics include mercury pollution effects, "
    "dissolved organic matter and production of greenhouse gases."
)

_DESCRIPTION_NO = (
    "Klimaendringer vil føre til oppvarming og endringer i snøsmelting og nedbørsmønstre. "
    "Slike endringer kan påvirke islegging og vanntemperatur i innsjøer, med mulige konsekvenser "
    "for fisk og vannlevende insekter, næringsnett og oksygentilgang. I tillegg kan produksjon av "
    "klimagasser, vannfarge og surhet bli påvirket. Det finnes få innsjøøkosystemer i Norge der "
    "slike prosesser studeres på en helhetlig måte, men det er viktig både for forskning og "
    "forvaltning å kunne studere og dokumentere klimaendringers effekt på innsjøer. NIVA har "
    "derfor etablert et høyinstrumentert feltanlegg for studier av klimaeffekter på "
    "innsjøprosesser. Det langsiktige feltanlegget Langtjern ble valgt, etablert på 1970-tallet "
    "for overvåking av sur nedbørs effekter på vannkvalitet og vannbiologi. Andre forskningstemaer "
    "inkluderer kvikksølvforurensning, løst organisk materiale og produksjon av klimagasser."
)

_KEYWORDS = ",".join(
    [
        "GCMDSK:EARTH SCIENCE > TERRESTRIAL HYDROSPHERE > SURFACE WATER > LAKES",
        "GCMDLOC:CONTINENT > EUROPE > NORTHERN EUROPE > SCANDINAVIA > NORWAY",
        "GEMET:Hydrography",
        "NORTHEMES:Weather and climate",
    ]
)

_KEYWORDS_VOCABULARY = ",".join(
    [
        "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
        "GCMDPLA:GCMD Platforms:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/platforms",
        "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
        "GEMET:INSPIRE Themes:http://inspire.ec.europa.eu/theme",
        "NORTHEMES:GeoNorge Themes:https://register.geonorge.no/metadata-kodelister/nasjonal-temainndeling",
    ]
)


def _base_dataset_attrs(title: str, summary: str, title_no: str, summary_no: str, ds: xr.Dataset) -> DatasetAttrsDiscrete:
    return DatasetAttrsDiscrete(
        title=title,
        summary=summary,
        title_no=title_no,
        summary_no=summary_no,
        keywords=_KEYWORDS,
        keywords_vocabulary=_KEYWORDS_VOCABULARY,
        iso_topic_category="inlandWaters",
        featureType=ds.attrs["featureType"],
        date_created=utils.iso_now(),
        processing_level="Experimental",
        project="Langtjern",
        time_coverage_start=utils.to_isoformat(ds.time.min().values),
        time_coverage_end=utils.to_isoformat(ds.time.max().values),
        geospatial_lat_min=float(ds.latitude.min()),
        geospatial_lat_max=float(ds.latitude.max()),
        geospatial_lon_min=float(ds.longitude.min()),
        geospatial_lon_max=float(ds.longitude.max()),
        spatial_representation="point",
        collection="ADC",
    )


@dataclass
class LangtjernBoyeBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern – buoy",
            summary=_DESCRIPTION,
            title_no="Klimaovervåking ved Langtjern – bøye",
            summary_no=_DESCRIPTION_NO,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "oxygensat_6m":
                return asdict(VariableAttrs(short_name="oxygen_saturation", long_name="Oxygen Saturation at 6 m Depth", units="%"))
            case "oxygensat_1m":
                return asdict(VariableAttrs(short_name="oxygen_saturation", long_name="Oxygen Saturation at 1 m Depth", units="%"))
            case "temp_0.5m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 0.5 m Depth", units="degree_Celsius"))
            case "temp_1.5m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 1.5 m Depth", units="degree_Celsius"))
            case "temp_1m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 1 m Depth", units="degree_Celsius"))
            case "temp_2m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 2 m Depth", units="degree_Celsius"))
            case "temp_3m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 3 m Depth", units="degree_Celsius"))
            case "temp_4m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 4 m Depth", units="degree_Celsius"))
            case "temp_6m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 6 m Depth", units="degree_Celsius"))
            case "temp_8m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 8 m Depth", units="degree_Celsius"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")


@dataclass
class LangtjernInletBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern – inlet",
            summary=_DESCRIPTION,
            title_no="Klimaovervåking ved Langtjern – innløp",
            summary_no=_DESCRIPTION_NO,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "temp_ground_15cm_avg":
                return asdict(VariableAttrs(short_name="soil_temperature", long_name="Soil Temperature at 15 cm Depth (Riparian)", units="degree_Celsius"))
            case "temp_ground_20cm_avg":
                return asdict(VariableAttrs(short_name="soil_temperature", long_name="Soil Temperature at 20 cm Depth (Riparian)", units="degree_Celsius"))
            case "temp_water_avg":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature", units="degree_Celsius"))
            case "levelvalue_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="m"))
            case "co2value_avg":
                return asdict(VariableAttrs(short_name="mole_fraction_of_carbon_dioxide_in_water", long_name="CO2 Concentration in Water", units="ppm"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")


@dataclass
class LangtjernOutletBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern – outlet",
            summary=_DESCRIPTION,
            title_no="Klimaovervåking ved Langtjern – utløp",
            summary_no=_DESCRIPTION_NO,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "temp_air_avg":
                return asdict(VariableAttrs(short_name="air_temperature", long_name="Air Temperature", units="degree_Celsius"))
            case "temp_ground_avg":
                return asdict(VariableAttrs(short_name="soil_temperature", long_name="Ground Temperature", units="degree_Celsius"))
            case "temp_water_avg":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature", units="degree_Celsius"))
            case "phvalue_avg":
                return asdict(VariableAttrs(short_name="water_ph", long_name="Water pH", units=""))
            case "condvalue_avg":
                return asdict(VariableAttrs(short_name="water_electrical_conductivity", long_name="Water Conductivity", units="mS/m"))
            case "co2value_avg":
                return asdict(VariableAttrs(short_name="mole_fraction_of_carbon_dioxide_in_water", long_name="CO2 Concentration in Water", units="ppm"))
            case "cdomdigitalfinal_avg":
                return asdict(VariableAttrs(short_name="water_cdom", long_name="Colored Dissolved Organic Matter in Water", units="µg/L"))
            case "levelvalue_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="m"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")


@dataclass
class LangtjernWeatherBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern – weather station",
            summary=_DESCRIPTION,
            title_no="Klimaovervåking ved Langtjern – værstasjon",
            summary_no=_DESCRIPTION_NO,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "lt_gr_c_avg":
                return asdict(VariableAttrs(short_name="air_temperature", long_name="Air Temperature", units="degree_Celsius"))
            case "vh_3_s_max":
                return asdict(VariableAttrs(short_name="wind_speed", long_name="Maximum Wind Velocity", units="m/s"))
            case "vh_mps_wvc(1)":
                return asdict(VariableAttrs(short_name="wind_speed", long_name="Wind Velocity", units="m/s"))
            case "vh_mps_wvc(2)":
                return asdict(VariableAttrs(short_name="wind_from_direction", long_name="Wind Direction", units="degrees"))
            case "lf_psnt_avg":
                return asdict(VariableAttrs(short_name="relative_humidity", long_name="Relative Air Humidity", units="%"))
            case "gs_wpm2_avg":
                return asdict(VariableAttrs(short_name="surface_downwelling_shortwave_flux_in_air", long_name="Solar Radiation", units="W/m2"))
            case "nb_mm":
                return asdict(VariableAttrs(short_name="rainfall_amount", long_name="Rainfall", units="mm"))
            case "waterlevel_mm_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="mm"))
            case "snowdepth_cm_avg":
                return asdict(VariableAttrs(short_name="surface_snow_thickness", long_name="Snow Depth", units="cm"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")
