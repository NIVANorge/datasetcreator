import logging
from dataclasses import asdict
from datetime import datetime
from typing import List

import xarray as xr
from psycopg2.extensions import connection

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.sources.odm2.queries import (
    PointResult,
)
from dataexport.sources.odm2.builder import NamedTimeseries


def create(
    uuid: str,
    timeseries: List[NamedTimeseries],
    station_name: str,
    point_info: PointResult,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    time_arrays = map(lambda ts: cftimearray(ts, point_info.latitude, point_info.longitude), timeseries)

    ds = timeseriesdataset(named_dataarrays=list(time_arrays), station_name=station_name)
    ds.attrs["id"] = uuid

    logging.info("Created xarray dataset")

    return ds


def add_acdd(ds: xr.Dataset, title: str, summary, projectname: str):
    """Add ACDD attributes to a xarray dataset

    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title=title,
                summary=summary,
                keywords=[
                    "Water-based Platforms > Buoys > Moored > BUOYS",
                    "EARTH SCIENCE > Oceans > Salinity/Density > Salinity",
                ],
                featureType=ds.attrs["featureType"],
                date_created=str(datetime.now()),
                project=projectname,
                time_coverage_start=str(ds.time.min().values),
                time_coverage_end=str(ds.time.max().values),
                geospatial_lat_min=float(ds.latitude.min()),
                geospatial_lat_max=float(ds.latitude.max()),
                geospatial_lon_min=float(ds.longitude.min()),
                geospatial_lon_max=float(ds.longitude.max()),
            )
        )
    )
    return ds


def cftimearray(timeseries_result: NamedTimeseries, latitude: float, longitude: float) -> xr.DataArray:
    """Match timeserie data to C&F

    Match timeseries data to the climate and forecast convention based on the given variable code.
    Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
    online unit list on https://ncics.org/portfolio/other-resources/udunits2/
    """
    match timeseries_result.variable_name:
        case "Temp":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="temperature",
                standard_name="sea_water_temperature",
                long_name="Sea Water Temperature",
                units="degree_Celsius",
            )
        case "Turbidity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="turbidity",
                standard_name="sea_water_turbidity",
                long_name="Sea Water Turbidity",
                units="NTU",
            )
        case "Salinity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="salinity",
                standard_name="sea_water_salinity",
                long_name="Sea Water Salinity",
                units="1e-3",
            )
        case "ChlaValue":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="chlorophylla",
                standard_name="mass_concentration_of_chlorophyll_a_in_sea_water",
                long_name="Mass Concentration of Chlorophyll A in Sea Water",
                units="µg/l",
            )
        case "CondValue":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="conductivity",
                standard_name="sea_water_electrical_conductivity",
                long_name="Sea Water Conductivity",
                units="S/m",
            )
        case _:
            logging.warning(f"Array definition not found for: {timeseries_result.variable_code}")
            # raise RuntimeError("Unknown variable code")

    return array.assign_coords(
        timeseriescoords(
            time=timeseries_result.datetime,
            latitude=latitude,
            longitude=longitude,
        )
    )
