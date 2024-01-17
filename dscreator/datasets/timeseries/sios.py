import logging
from dataclasses import dataclass
from datetime import datetime

import xarray as xr

from dscreator import utils
from dscreator.cfarray.attributes import CFVariableAttrs, DatasetAttrsDiscrete
from dscreator.cfarray.base import dataarraybytime
from dscreator.datasets.base import TimeseriesDatasetBuilder
from dscreator.sources.odm2.extractor import NamedTimeseries


@dataclass
class SiosBuilder(TimeseriesDatasetBuilder):
    def dataset_attributes(self, ds: xr.Dataset) -> DatasetAttrsDiscrete:
        """Add ACDD attributes to a xarray dataset

        Add attributes following the Attribute Convention for Data Discovery to a dataset, also see https://adc.met.no/node/96.
        A good keywords viewer is located here https://gcmd.earthdata.nasa.gov/KeywordViewer.
        For converting CF standard names erddap also contains a good converter for cf standard names.
        """
        return DatasetAttrsDiscrete(
            title="SIOS sensor buoy in Adventfjorden",
            summary="Summary",
            title_no="SIOS sensor bøye i Adventfjorden",
            summary_no="Oppsummering",
            keywords=",".join(
                [
                    "GCMDSK:Earth Science > Oceans > Ocean Chemistry > Chlorophyll",
                    "GCMDSK:Earth Science > Oceans > Salinity/Density > Conductivity",
                    "GCMDSK:Earth Science > Oceans > Salinity/Density > Salinity",
                    "GCMDSK:Earth Science > Oceans > Ocean Temperature > Water Temperature",
                    "GCMDPLA:Water-based Platforms > Buoys > Moored > BUOYS",
                    "GCMDLOC:OCEAN > ATLANTIC OCEAN > NORTH ATLANTIC OCEAN > SVALBARD AND JAN MAYEN",
                ]
            ),
            keywords_vocabulary=",".join(
                [
                    "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords",
                    "GCMDPLA:GCMD Platforms:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/platforms",
                    "GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations",
                ]
            ),
            iso_topic_category="oceans",
            featureType=ds.attrs["featureType"],
            date_created=utils.to_isoformat(datetime.now()),
            project=self.project_name,
            time_coverage_start=utils.to_isoformat(ds.time.min().values),
            time_coverage_end=utils.to_isoformat(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
            spatial_representation="point"
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
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_temperature", long_name="Sea Water Temperature", units="degree_Celsius"
                    ),
                )
            case "Turbidity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="turbidity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_turbidity", long_name="Sea Water Turbidity", units="NTU"
                    ),
                )
            case "Salinity":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="salinity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_salinity", long_name="Sea Water Salinity", units="1e-3"
                    ),
                )
            case "ChlaValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="chlorophylla",
                    attrs=CFVariableAttrs(
                        standard_name="mass_concentration_of_chlorophyll_a_in_sea_water",
                        long_name="Mass Concentration of Chlorophyll A in Sea Water",
                        units="µg/l",
                    ),
                )
            case "CondValue":
                array = dataarraybytime(
                    data=timeseries.values,
                    name="conductivity",
                    attrs=CFVariableAttrs(
                        standard_name="sea_water_electrical_conductivity",
                        long_name="Sea Water Conductivity",
                        units="S/m",
                    ),
                )
            case _:
                logging.warning(f"Array definition not found for: {timeseries.variable_code}")
                raise RuntimeError("Unknown variable code")
        return array
