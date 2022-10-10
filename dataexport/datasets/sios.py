from dataclasses import asdict
import logging
from datetime import datetime, timedelta
from functools import partial
from psycopg2.extensions import connection

import numpy as np
import xarray as xr

from dataexport.cfarray.time_series import timeseriesdataset
from dataexport.datasets import maps
from dataexport.cfarray.base import DatasetAttrs
from dataexport.odm2.queries import timeseries, timeseries_metadata, TimeseriesMetadataResult

TITLE = "SIOS sensor buoy in Adventfjorden"
PROJECT_NAME = "SIOS"
PROJECT_STATION_CODE = "20"


def dump(conn: connection, start_time: datetime, end_time: datetime, is_acdd: bool=False) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    project_metadata = timeseries_metadata(conn, project_name=PROJECT_NAME, project_station_code=PROJECT_STATION_CODE)
    ds = dataset(conn, start_time, end_time, project_metadata)

    return acdd(ds, project_metadata) if is_acdd else ds


def dataset(conn: connection, start_time: datetime, end_time: datetime, project_metadata: TimeseriesMetadataResult) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    query_by_time = partial(
        timeseries,
        conn=conn,
        project_name=project_metadata.projectname,
        project_station_code=project_metadata.projectstationcode,
        start_time=start_time,
        end_time=end_time,
    )

    query_results = map(
        lambda vc: query_by_time(variable_code=vc),
        [
            "Temp",
            "Turbidity",
            "Salinity",
            "ChlaValue",
            "CondValue",
            # "OxygenCon",
            # "OxygenSat",
            # "RawBackScattering",
            # "fDOM",
        ],
    )

    time_arrays = map(lambda qr: maps.cftimearray(qr, project_metadata.latitude, project_metadata.longitude), query_results)

    ds = timeseriesdataset(
        named_dataarrays=list(time_arrays), title=TITLE, station_name=project_metadata.projectstationname
    )
    logging.info("Created xarray dataset")

    return ds

def acdd(ds: xr.Dataset, project_metadata):
    """ Add ACDD attributes to a xarray dataset
    
    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title=TITLE,
                summary=project_metadata.projectdescription,
                keywords=[
                    "Water-based Platforms > Buoys > Moored > BUOYS",
                    "EARTH SCIENCE > Oceans > Salinity/Density > Salinity",
                ],
                project=project_metadata.projectname,
            )
        )
    )
