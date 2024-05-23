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
            title="Ferrybox on MS Color Fantasy",
            title_no="FerryBox på MS Color Fantasy",
            summary="Ferry sailing from Oslo, Norway to Kiel, Germany. For more information see: https://www.colorline.no/oslo-kiel/fakta.",
            summary_no="Ferje fra Oslo, Norge til Kiel, Tyskland. For mer informasjon se: https://www.colorline.no/oslo-kiel/fakta.",
            keywords=",".join(
                [
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN TEMPERATURE > SEA SURFACE TEMPERATURE",
                    "GCMDSK:EARTH SCIENCE > OCEANS > SALINITY/DENSITY > OCEAN SALINITY > OCEAN SURFACE SALINITY",
                    "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN CHEMISTRY > OXYGEN",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "CFSTDN:CF Standard Names:https://cfconventions.org/Data/cf-standard-names/current/build/cf-standard-name-table.html",
                ]
            ),
            creator_email="norsoop@niva.no",
            featureType=ds.attrs["featureType"],
            # https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#related-information-types
            references="https://thredds.niva.no/thredds/fileServer/datasets/references/Method_description_and_quality_control_procedure_NorSOOP.pdf(Extended metadata)",
            ices_platform_code="58CO",
            platform_code="FA",
            platform_name="Color Fantasy",
            date_created=utils.iso_now(),
            project=",".join(
                [
                    "Norwegian Ships of Opportunity program (NorSOOP ID 269922)",
                    "Joint European Research Infrastructure of Coastal Observatories (JERICO-S3 ID 871153 JERICO-NEXT ID 654410)",
                    "Norwegian Environment Agency",
                    "Inner and Outer Oslofjord Fagrådet",
                ]
            ),
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
                attrs["ancillary_variables"] = "salinity_qc"
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
            case "cdom":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="concentration_of_colored_dissolved_organic_matter_in_sea_water_expressed_as_equivalent_mass_fraction_of_quinine_sulfate_dihydrate",
                        long_name="Colored Dissolved Organic Matter In Sea Water",
                        units="mg/m^3",
                    )
                )
                attrs["ancillary_variables"] = "cdom_qc"
                return attrs
            case "cdom_qc":
                return asdict(
                    FlagAttrs(long_name="Colored Dissolved Organic Matter In Sea Water Quality Flag"),
                )
            case "oxygen":
                attrs = asdict(
                    CFVariableAttrs(
                        standard_name="fractional_saturation_of_oxygen_in_sea_water",
                        long_name="Sea Water Oxygen Saturation",
                        units="%",
                    )
                )
                attrs["ancillary_variables"] = "oxygen_qc"
                return attrs
            case "oxygen_qc":
                return asdict(FlagAttrs(long_name="Sea Water Oxygen Saturation Quality Flag"))
            case _:
                logging.warning(f"Array definition not found for: {variable_name}")
                raise RuntimeError(f"Array definition not found for: {variable_name}")


@dataclass
class DailyFantasy(NorsoopFantasy):
    def dataset_attributes(self, ds: xr.Dataset) -> FerryboxDatasetAttrs:
        attrs = super().dataset_attributes(ds)
        attrs.title = "Ferrybox on MS Color Fantasy, daily data"
        attrs.title_no = "Ferje på MS Color Fantasy, daglige data"
        attrs.summary = "Daily updating dataset of ferrybox data for ferry sailing Oslo, Norway to Kiel, Germany. For more information see: https://www.colorline.no/oslo-kiel/fakta."
        attrs.summary_no = "Daglig updatert dataset fra ferrybox ombord ferje fra Oslo, Norge til Kiel, Tyskland. For mer informasjon se: https://www.colorline.no/oslo-kiel/fakta."
        attrs.keywords += "," + ",".join(
            [
                "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN CHEMISTRY > CHLOROPHYLL",
                "GCMDSK:EARTH SCIENCE > OCEANS > OCEAN CHEMISTRY > ORGANIC MATTER > COLORED DISSOLVED ORGANIC MATTER",
            ]
        )
        return attrs
