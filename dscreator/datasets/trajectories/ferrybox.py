import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dscreator.cfarray.base import dataarraybytime
from dscreator.cfarray.attributes import FerryboxDatasetAttrs, CFVariableAttrs
from dscreator.datasets.base import TrajectoryDatasetBuilder
from dscreator.sources.base import NamedTrajectory


@dataclass
class FerryboxTrajBuilder(TrajectoryDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> FerryboxDatasetAttrs:

        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset.
        More information can be found here https://adc.met.no/node/96.
        A good viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer
        """
        return FerryboxDatasetAttrs(
            title="Dataset with core measurements",
            summary="summary",
            keywords=",".join([]),
            keywords_vocabulary=",".join([]),
            featureType=ds.attrs["featureType"],
            metadata_link="http://path/Document_describing_calibration.pdf",
            ices_platform_code="LMSD",
            platform_code="FA",
            platform_name="COLOR FANTASY",
            date_created=str(datetime.now()),
            project=self.project_name,
            time_coverage_start=str(ds.time.min().values),
            time_coverage_end=str(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
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
                    name="sea_water_temperature",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_temperature", long_name="sea_water_temperature", units="degree_Celsius"
                    ),
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="sea_water_turbidity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_turbidity", long_name="sea_water_turbidity", units="degree_Celsius"
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
