import logging
from dataclasses import asdict
from datetime import datetime
from functools import partial
from itertools import product
from typing import List

import xarray as xr
from psycopg2.extensions import connection

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.export_types import SamplingExport
from dataexport.sources.odm2.queries import (
    PointResult,
    TimeseriesSamplingResult,
    point_by_sampling_code,
    timeseries_by_sampling_code,
)


def create(
    conn: connection,
    uuid: str,
    sampling_feature_code: str,
    variable_codes: List[str],
    station_name: str,
    start_time: datetime,
    end_time: datetime,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    point_info = point_by_sampling_code(conn, sampling_feature_code)
    ds = dataset(conn, variable_codes, station_name, point_info, start_time, end_time)
    ds.attrs["id"] = uuid

    return ds


def dataset(
    conn: connection,
    variable_codes: List[str],
    station_name: str,
    point_info: PointResult,
    start_time: datetime,
    end_time: datetime,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    query_by_time = partial(
        timeseries_by_sampling_code,
        conn=conn,
        start_time=start_time,
        end_time=end_time,
    )

    query_results = map(
        lambda v: query_by_time(variable_code=v, sampling_feature_code=point_info.samplingfeaturecode),
        variable_codes,
    )

    time_arrays = map(lambda qr: cftimearray(qr, point_info.latitude, point_info.longitude), query_results)

    ds = timeseriesdataset(named_dataarrays=list(time_arrays), station_name=station_name)
    logging.info("Created xarray dataset")

    return ds


def add_acdd(ds: xr.Dataset, title: str, summary: str, projectname):
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


def cftimearray(timeseries_result: TimeseriesSamplingResult, latitude: float, longitude: float) -> xr.DataArray:
    """Match timeserie data to C&F

    Match timeseries data to the climate and forecast convention based on the given variable code.
    Standard names are found at http://vocab.nerc.ac.uk/collection/P07/current/
    online unit list on https://ncics.org/portfolio/other-resources/udunits2/
    """
    match timeseries_result.variable_code:
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
