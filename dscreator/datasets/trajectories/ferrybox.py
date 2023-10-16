import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import CFVariableAttrs, FerryboxDatasetAttrs
from dscreator.cfarray.base import dataarraybytime
from dscreator.datasets.base import TrajectoryDatasetBuilder
from dscreator.sources.base import NamedTrajectory


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
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords"
                ]
            ),
            creator_email="norsoop@niva.no",
            featureType=ds.attrs["featureType"],
            references="http://path/Document_describing_calibration.pdf",
            ices_platform_code="58CO",
            platform_code="FA",
            platform_name="Color Fantasy",
            date_created=str(datetime.now()),
            project="NorSOOP RCN 269922; JERICO-RI (H2020 JERICO-S3 871153, JERICO-NEXT 654410), Norwegian Environment Agency, Inner and Outer Oslofjord Fagrådet",
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
            spatial_representation="trajectory",
        )

    def map_to_cfarray(self, timeseries: NamedTrajectory) -> xr.DataArray:
        """Match timeserie data to C&F

        Match timeseries data to the climate and forecast convention based on the given variable code.
        Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
        online unit list on https://ncics.org/portfolio/other-resources/udunits2/
        """
        match timeseries.variable_name:
            case "Temperature":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="temperature",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_temperature", long_name="Sea Water Temperature", units="degree_Celsius"
                    ),
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_turbidity", long_name="Sea Water Turbidity", units="FTU"
                    ),
                )
            case "Salinity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="salinity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_salinity", long_name="Sea Water Salinity", units="PSU"
                    ),
                )
            case "Chlorophyll":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="chlorophylla",
                    attrs=CFVariableAttrs(
                        standard_name="rt_calibrated_mass_concentration_of_chlorophyll_a_in_sea_water",
                        long_name="Mass Concentration of Chlorophyll A in Sea Water",
                        units="mg/m^3",
                    ),
                )
            case "Oxygen":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="oxygen",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_oxygen_saturation", long_name="Sea Water Oxygen Saturation", units="%"
                    ),
                )
            case "cDOM":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="cDOM",
                    attrs=CFVariableAttrs(standard_name="", long_name="", units="mg/m^3"),
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_name}")
                raise RuntimeError(f"Array definition not found for: {timeseries.variable_name}")

        return array
