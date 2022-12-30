import logging
from dataclasses import asdict
from datetime import datetime
from functools import partial

import numpy as np
import xarray as xr
from psycopg2.extensions import connection

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.cfarray.time_series import timeseriesdataset, timeseriescoords
from dataexport.odm2.queries import TimeseriesMetadataResult, TimeseriesResult, timeseries_by_sampling_code

TITLE = "MSource/DigiVeivann"
PROJECT_NAME = "Multisource"
VARIABLE_CODES = [
    "Temp",
    "LevelValue",
    "Turbidity",
]
SAMPLING_FEATURE_CODES = ["MSOURCE1", "MSOURCE2"]


def dump(conn: connection, start_time: datetime, end_time: datetime, is_acdd: bool = False) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    metadata = TimeseriesMetadataResult(
        PROJECT_NAME, "Description", "msource_inlet", "msource_inlet", 59.911491, 10.757933
    )

    ds = dataset(conn, start_time, end_time, metadata)
 
    return acdd(ds, metadata.projectdescription, PROJECT_NAME) if is_acdd else ds


def dataset(
    conn: connection,
    start_time: datetime,
    end_time: datetime,
    project_metadata: TimeseriesMetadataResult,
    sampling_feature_code: str,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    query_by_time = partial(
        timeseries_by_sampling_code,
        conn=conn,
        sampling_feature_code=sampling_feature_code,
        start_time=start_time,
        end_time=end_time,
    )

    query_results = map(lambda vc: query_by_time(variable_code=vc), VARIABLE_CODES)

    time_arrays = map(lambda qr: cftimearray(qr, project_metadata.latitude, project_metadata.longitude), query_results)

    ds = timeseriesdataset(
        named_dataarrays=list(time_arrays), title=TITLE, station_name=project_metadata.projectstationname
    )
    logging.info("Created xarray dataset")

    return ds


def acdd(ds: xr.Dataset, projectdescription: str, projectname):
    """Add ACDD attributes to a xarray dataset

    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title=TITLE,
                summary=projectdescription,
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


def cftimearray(timeseries_result: TimeseriesResult, latitude: float, longitude: float) -> xr.DataArray:
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
                standard_name="sea_water_temperature",
                long_name="Sea Water Temperature",
                units="degree_Celsius",
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
