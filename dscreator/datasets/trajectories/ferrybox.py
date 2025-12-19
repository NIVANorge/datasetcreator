import logging
from dataclasses import dataclass, asdict

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import CFVariableAttrs, FerryboxDatasetAttrs, FlagAttrs
from dscreator.datasets.base import TrajectoryDatasetBuilder


@dataclass
class NorsoopFantasy(TrajectoryDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> FerryboxDatasetAttrs:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset.
        More information can be found here https://adc.met.no/node/96.
        A good viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer
        """
        return FerryboxDatasetAttrs(
            title="FerryBox on MS Color Fantasy",
            title_no="FerryBox på MS Color Fantasy",
            summary=(
                "The FerryBox system measures temperature, salinity, oxygen, chlorophyll and particle content at a depth of ~5m along the route of MS Color Fantasy Oslo-Kiel. This amounts to about one measurement every ~500 metres, for more information see https://www.niva.no/en/ferrybox. This dataset covers 5 years from 2017 to 2022.",
            ),
            summary_no=(
                "Ferrybox-systemet måler som standard hvert minutt temperatur, saltinnhold, oksygen, klorofyll-a fluorescens og turbiditet på ~5m meters dyp langs MS Color Fantasy sin faste rute Oslo-Kiel. Dette tilsvarer en måling ca hver 500 meter, for mer informasjon se https://www.niva.no/ferrybox. Dette datasettet dekker 5 år fra 2017 til 2022.",
            ),
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN TEMPERATURE > SEA SURFACE TEMPERATURE",
                    "GCMDSK:EARTH SCIENCE > OCEANS > SALINITY/DENSITY > OCEAN SALINITY > OCEAN SURFACE SALINITY",
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN CHEMISTRY > OXYGEN",
                    "GEMET:Oceanographic geographical features",
                    "NORTHEMES:Marine activities",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GEMET:INSPIRE Themes:http://inspire.ec.europa.eu/theme",
                    "NORTHEMES:GeoNorge Themes:https://register.geonorge.no/metadata-kodelister/nasjonal-temainndeling",
                ]
            ),
            depth="~5m",
            creator_email="norsoop@niva.no",
            featureType=ds.attrs["featureType"],
            # https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#related-information-types
            references="https://github.com/NIVANorge/dataset-extended-metadata/blob/main/README.md(Extended metadata)",
            ices_platform_code="58CO",
            platform_code="FA",
            platform_name="Color Fantasy",
            date_created=utils.iso_now(),
            project=",".join(
                [
                    "Norwegian Ships of Opportunity program (NorSOOP ID 269922)",
                    "Joint European Research Infrastructure of Coastal Observatories (JERICO)",
                    "Norwegian Environment Agency",
                    "Inner and Outer Oslofjord Fagrådet",
                ]
            ),
            iso_topic_category="oceans",
            collection="GEONOR, NMDC",
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=53.8,
            geospatial_lat_max=59.93,
            geospatial_lon_min=9.92,
            geospatial_lon_max=12.6,
            spatial_representation="trajectory",
        )

    def variable_attributes(self, variable_name: str):
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable_name code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """

        match variable_name:
            case "temperature":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="sea_water_temperature", long_name="Sea Water Temperature", units="degree_Celsius"
                    )
                )
                attrs["ancillary_variables"] = "temperature_qc"
                return attrs
            case "temperature_qc":
                return asdict(FlagAttrs(long_name="Sea Water Temperature Quality Flag"))

            case "turbidity":
                attrs = asdict(
                    CFVariableAttrs(standard_name="sea_water_turbidity", long_name="Sea Water Turbidity", units="FTU")
                )
                attrs["ancillary_variables"] = "turbidity_qc"
                return attrs
            case "turbidity_qc":
                return asdict(FlagAttrs(long_name="Sea Water Turbidity Quality Flag"))
            case "salinity":
                attrs = asdict(
                    CFVariableAttrs(standard_name="sea_water_salinity", long_name="Sea Water Salinity", units="PSU")
                )

                attrs["ancillary_variables"] = "salinity_qc"
                return attrs
            case "salinity_qc":
                return asdict(
                    FlagAttrs(long_name="Sea Water Salinity Quality Flag"),
                )
            case "chlorophyll":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="rt_calibrated_mass_concentration_of_chlorophyll_a_in_sea_water",
                        long_name="Mass Concentration of Chlorophyll A in Sea Water",
                        units="mg/m^3",
                    )
                )
                attrs["ancillary_variables"] = "chlorophyll_qc"
                return attrs
            case "chlorophyll_qc":
                return asdict(
                    FlagAttrs(long_name="Mass Concentration of Chlorophyll A in Sea Water Quality Flag"),
                )
            case "fdom":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="concentration_of_colored_dissolved_organic_matter_in_sea_water_expressed_as_equivalent_mass_fraction_of_quinine_sulfate_dihydrate",
                        long_name="Colored Dissolved Organic Matter In Sea Water",
                        units="mg/m^3",
                    )
                )
                attrs["ancillary_variables"] = "fdom_qc"
                return attrs
            case "fdom_qc":
                return asdict(
                    FlagAttrs(long_name="Colored Dissolved Organic Matter In Sea Water Quality Flag"),
                )
            case "oxygen_sat":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="fractional_saturation_of_oxygen_in_sea_water",
                        long_name="Sea Water Oxygen Saturation",
                        units="%",
                    )
                )
                attrs["ancillary_variables"] = "oxygen_sat_qc"
                return attrs
            case "oxygen_sat_qc":
                return asdict(FlagAttrs(long_name="Sea Water Oxygen Saturation Quality Flag"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError(f"Array definition not found for: {variable_name}")


@dataclass
class DailyFantasy(NorsoopFantasy):
    def dataset_attributes(self, ds: xr.Dataset) -> FerryboxDatasetAttrs:
        attrs = super().dataset_attributes(ds)
        attrs.title = "FerryBox on MS Color Fantasy, daily data"
        attrs.title_no = "FerryBox på MS Color Fantasy, daglige data"
        attrs.summary = (
            "The FerryBox system measures temperature, salinity, oxygen, chlorophyll and particle content at a depth of ~5m along the route of MS Color Fantasy Oslo-Kiel. This amounts to about one measurement every ~500 metres, for more information see https://www.niva.no/en/ferrybox. This dataset will normally be updated daily.",
        )
        attrs.summary_no = (
            "Ferrybox-systemet måler som standard hvert minutt temperatur, saltinnhold, oksygen, klorofyll-a fluorescens og turbiditet på ~5m meters dyp langs MS Color Fantasy sin faste rute Oslo-Kiel. Dette tilsvarer en måling ca hver 500 meter, for mer informasjon se https://www.niva.no/ferrybox. Dette datasettet vil normalt bli oppdatert daglig.",
        )
        attrs.keywords = (
            ",".join(
                [
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN OPTICS > CHLOROPHYLL",
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN OPTICS > TURBIDITY",
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN CHEMISTRY > ORGANIC MATTER > COLORED DISSOLVED ORGANIC MATTER",
                ]
            )
            + ","
            + attrs.keywords
        )
        attrs.project += "," + ",".join(["AquaINFRA"])
        return attrs


@dataclass
class RamsesFantasy(TrajectoryDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> FerryboxDatasetAttrs:
        return FerryboxDatasetAttrs(
            title="RAMSES on MS Color Fantasy",
            title_no="RAMSES på MS Color Fantasy",
            summary="Ocean surface reflectance derived from spectral imaging radiometer (RAMSES) measurements on board MS Color Fantasy sailing from Oslo, Norway to Kiel, Germany, also see https://www.niva.no/en/ferrybox",
            summary_no="Reflektans målinger fra spectral imaging radiometer (RAMSES) ombord MS Color Fantasy som går i rute Oslo - Kiel, se også: https://www.niva.no/ferrybox.",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN OPTICS > REFLECTANCE",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                ]
            ),
            depth="~5m",
            creator_email="miljoinformatikk@niva.no",
            featureType=ds.attrs["featureType"],
            # https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#related-information-types
            references="https://github.com/NIVANorge/dataset-extended-metadata/blob/main/README.md(Extended metadata)",
            ices_platform_code="58CO",
            platform_code="FA",
            platform_name="Color Fantasy",
            date_created=utils.iso_now(),
            project=",".join(
                [
                    "AquaINFRA",
                    "Norwegian Ships of Opportunity program (NorSOOP ID 269922)",
                    "Joint European Research Infrastructure of Coastal Observatories (JERICO)",
                    "Norwegian Environment Agency",
                    "Inner and Outer Oslofjord Fagrådet",
                ]
            ),
            iso_topic_category="oceans",
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=53.8,
            geospatial_lat_max=59.93,
            geospatial_lon_min=9.92,
            geospatial_lon_max=12.6,
            spatial_representation="trajectory",
        )

    def variable_attributes(self, variable_name: str):
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable_name code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """

        _, wl = variable_name.split("_")

        return asdict(
            CFVariableAttrs(
                standard_name="surface_ratio_of_upwelling_radiance_emerging_from_sea_water_to_downwelling_radiative_flux_in_air",
                long_name=f"Remote sensing reflectance at {wl} nm",
                units="sr^-1",
            )
        )
