import logging
from dataclasses import asdict
from datetime import datetime
from functools import partial
from itertools import product

import numpy as np
import xarray as xr
from psycopg2.extensions import connection

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.cfarray.time_series import timeseriesdataset, timeseriescoords
from dataexport.odm2.queries import TimeseriesMetadataResult, TimeseriesSamplingResult, timeseries_by_sampling_code
from dataexport.export_types import SamplingExport


def dump(
    conn: connection, settings: SamplingExport, start_time: datetime, end_time: datetime, is_acdd: bool = False
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    metadata = TimeseriesMetadataResult(
        settings.project_name, "Description", "msource_outlet", "msource_outlet", 59.911491, 10.757933
    )

    ds = dataset(conn, settings, metadata, start_time, end_time)

    return acdd(settings.title, ds, metadata.projectdescription, settings.project_name) if is_acdd else ds


def dataset(
    conn: connection,
    settings: SamplingExport,
    project_metadata: TimeseriesMetadataResult,
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
        lambda v: query_by_time(variable_code=v, sampling_feature_code=settings.sampling_feature_code),
        settings.variable_codes,
    )

    time_arrays = map(lambda qr: cftimearray(qr, project_metadata.latitude, project_metadata.longitude), query_results)

    ds = timeseriesdataset(
        named_dataarrays=list(time_arrays), title=settings.title, station_name=project_metadata.projectstationname
    )
    logging.info("Created xarray dataset")

    return ds


def acdd(title: str, ds: xr.Dataset, projectdescription: str, projectname):
    """Add ACDD attributes to a xarray dataset

    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title=title,
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
                standard_name="rainsource_level1",
                long_name="Rainbed Level",
                units="m",
            )
        case "Turbidity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="turbidity",
                standard_name="turbidity",
                long_name="Turbidity",
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
