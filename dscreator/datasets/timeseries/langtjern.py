import logging
from dataclasses import asdict, dataclass

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import DatasetAttrsDiscrete, VariableAttrs, CFVariableAttrs
from dscreator.datasets.base import TimeseriesDatasetBuilder

_UPDATE_NOTE = (
    "The dataset is usually updated daily. "
    "Data has been through automatic quality control, and changes to previously published data may occur."
)

_UPDATE_NOTE_NO = (
    "Datasettet oppdateres vanligvis daglig. "
    "Data har gjennomgått automatisk kvalitetskontroll, og endringer i tidligere publiserte data kan forekomme."
)

_ABOUT = (
    "About Langtjern: Climate change will lead to warming and changes in snowmelt and precipitation patterns. "
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

_ABOUT_NO = (
    "Om Langtjern: Klimaendringer vil føre til oppvarming og endringer i snøsmelting og nedbørsmønstre. "
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
        creator_email="heleen.de.wit@niva.no",
        processing_level="Operational",
        project="Økofersk",
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
    _summary = " ".join(
        [
            "This dataset contains water temperature and oxygen saturation measurements from sensors mounted on the buoy at Langtjern.",
            _UPDATE_NOTE,
            _ABOUT,
        ]
    )
    _summary_no = " ".join(
        [
            "Dette datasettet inneholder målinger av vanntemperatur og oksygenmetning fra sensorer montert på bøyen ved Langtjern.",
            _UPDATE_NOTE_NO,
            _ABOUT_NO,
        ]
    )

    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern - buoy",
            summary=self._summary,
            title_no="Klimaovervåking ved Langtjern - bøye",
            summary_no=self._summary_no,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "oxygensat_6m":
                return asdict(VariableAttrs(short_name="oxygen_saturation", long_name="Oxygen Saturation at 6 m Depth", units="%"))
            case "oxygensat_1m":
                return asdict(VariableAttrs(short_name="oxygen_saturation", long_name="Oxygen Saturation at 1 m Depth", units="%"))
            case "temp_0_5m":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature at 0.5 m Depth", units="degree_Celsius"))
            case "temp_1_5m":
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
    _summary = " ".join(
        [
            "This dataset contains water temperature, water level, soil temperature, and CO2 measurements from the inlet of Langtjern.",
            _UPDATE_NOTE,
            _ABOUT,
        ]
    )
    _summary_no = " ".join(
        [
            "Dette datasettet inneholder målinger av vanntemperatur, vannstand, jordtemperatur og CO2 fra innløpet til Langtjern.",
            _UPDATE_NOTE_NO,
            _ABOUT_NO,
        ]
    )

    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern - inlet",
            summary=self._summary,
            title_no="Klimaovervåking ved Langtjern - innløp",
            summary_no=self._summary_no,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "temp_ground_15cm_avg":
                return asdict(CFVariableAttrs(standard_name="temperature_in_ground", long_name="Soil Temperature at 15 cm Depth (Riparian)", units="degree_Celsius"))
            case "temp_ground_20cm_avg":
                return asdict(CFVariableAttrs(standard_name="temperature_in_ground", long_name="Soil Temperature at 20 cm Depth (Riparian)", units="degree_Celsius"))
            case "temp_water_avg":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature", units="degree_Celsius"))
            case "levelvalue_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="m"))
            case "co2value_avg":
                attrs = asdict(VariableAttrs(short_name="pco2", long_name="pCO2 in water (unprocessed signal)", units="ppm"))
                attrs["comment"] = "Internal sensor pCO2 in equilibrium with water"
                return attrs
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")


@dataclass
class LangtjernOutletBuilder(TimeseriesDatasetBuilder):
    _summary = " ".join(
        [
            "This dataset contains water temperature, air temperature, water level, pH, conductivity, CO2, and CDOM measurements from the outlet of Langtjern.",
            _UPDATE_NOTE,
            _ABOUT,
        ]
    )
    _summary_no = " ".join(
        [
            "Dette datasettet inneholder målinger av vanntemperatur, lufttemperatur, vannstand, pH, ledningsevne, CO2 og KDOM fra utløpet av Langtjern.",
            _UPDATE_NOTE_NO,
            _ABOUT_NO,
        ]
    )

    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern - outlet",
            summary=self._summary,
            title_no="Klimaovervåking ved Langtjern - utløp",
            summary_no=self._summary_no,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "temp_air_avg":
                return asdict(CFVariableAttrs(standard_name="air_temperature", long_name="Air Temperature", units="degree_Celsius"))
            case "temp_ground_avg":
                return asdict(CFVariableAttrs(standard_name="soil_temperature", long_name="Ground Temperature", units="degree_Celsius"))
            case "temp_water_avg":
                return asdict(VariableAttrs(short_name="water_temperature", long_name="Water Temperature", units="degree_Celsius"))
            case "phvalue_avg":
                return asdict(VariableAttrs(short_name="water_ph", long_name="Water pH", units=""))
            case "condvalue_avg":
                return asdict(VariableAttrs(short_name="conductivity", long_name="Water Conductivity", units="mS/m"))
            case "co2value_avg":
                attrs = asdict(VariableAttrs(short_name="pco2", long_name="pCO2 in water (unprocessed signal)", units="ppm"))
                attrs["comment"] = "Internal sensor pCO2 in equilibrium with water"
                return attrs
            case "cdomdigitalfinal_avg":
                return asdict(VariableAttrs(short_name="water_cdom", long_name="Colored Dissolved Organic Matter in Water", units="µg/L"))
            case "levelvalue_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="m"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")


@dataclass
class LangtjernWeatherBuilder(TimeseriesDatasetBuilder):
    _summary = " ".join(
        [
            "This dataset contains meteorological measurements from the weather station at Langtjern, including air temperature, wind, humidity, solar radiation, precipitation, and snow depth.",
            _UPDATE_NOTE,
            _ABOUT,
        ]
    )
    _summary_no = " ".join(
        [
            "Dette datasettet inneholder meteorologiske målinger fra værstasjonen ved Langtjern, inkludert lufttemperatur, vind, fuktighet, solstråling, nedbør og snødybde.",
            _UPDATE_NOTE_NO,
            _ABOUT_NO,
        ]
    )

    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        return _base_dataset_attrs(
            title="Climate monitoring at Langtjern - weather station",
            summary=self._summary,
            title_no="Klimaovervåking ved Langtjern - værstasjon",
            summary_no=self._summary_no,
            ds=ds,
        )

    def variable_attributes(self, variable_name: str) -> dict:
        match variable_name:
            case "lt_gr_c_avg":
                return asdict(CFVariableAttrs(standard_name="air_temperature", long_name="Air Temperature", units="degree_Celsius"))
            case "vh_3_s_max":
                return asdict(CFVariableAttrs(standard_name="wind_speed", long_name="Maximum Wind Velocity", units="m/s"))
            case "vh_mps_wvc_1_":
                return asdict(CFVariableAttrs(standard_name="wind_speed", long_name="Wind Velocity", units="m/s"))
            case "vh_mps_wvc_2_":
                return asdict(CFVariableAttrs(standard_name="wind_from_direction", long_name="Wind Direction", units="degrees"))
            case "lf_psnt_avg":
                return asdict(CFVariableAttrs(standard_name="relative_humidity", long_name="Relative Air Humidity", units="%"))
            case "gs_wpm2_avg":
                return asdict(CFVariableAttrs(standard_name="surface_downwelling_shortwave_flux_in_air", long_name="Solar Radiation", units="W/m2"))
            case "nb_mm":
                return asdict(CFVariableAttrs(standard_name="rainfall_amount", long_name="Rainfall", units="mm"))
            case "waterlevel_mm_avg":
                return asdict(VariableAttrs(short_name="water_level", long_name="Water Level", units="mm"))
            case "snowvalue_mm_avg":
                return asdict(CFVariableAttrs(standard_name="surface_snow_thickness", long_name="Snow Depth", units="mm"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError("Unknown variable code")
