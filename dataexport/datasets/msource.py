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
    named_timeseries: List[NamedTimeseries],
    station_name: str,
    point_info: PointResult,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    time_arrays = map(lambda ts: cftimearray(ts, point_info.latitude, point_info.longitude), named_timeseries)

    ds = timeseriesdataset(named_dataarrays=list(time_arrays), station_name=station_name)
    ds.attrs["id"] = uuid

    logging.info("Created xarray dataset")

    return ds


def add_acdd(ds: xr.Dataset, projectname):
    """Add ACDD attributes to a xarray dataset

    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title="Test MSource/DigiVeivann Inlet",
                summary="Test MSource/DigiVeivann Inlet",
                keywords=[
                    "Land-based Platforms",
                    "EARTH SCIENCE > LAND SURFACE",
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
                standard_name="rainbed_temperature",
                long_name="Rainbed Water Temperature",
                units="degree_Celsius",
            )
        case "LevelValue":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="levelvalue",
                standard_name="rainbed_level",
                long_name="Rainbed Water Level",
                units="m",
            )
        case "Turbidity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="turbidity",
                standard_name="rainbed_turbidity",
                long_name="Rainbed Water Turbidity",
                units="m",
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
