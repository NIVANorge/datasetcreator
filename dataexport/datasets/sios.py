import logging
from dataclasses import asdict
from datetime import datetime
from functools import partial

import numpy as np
import xarray as xr
from psycopg2.extensions import connection

from dataexport.cfarray.base import DatasetAttrs, dataarraybytime
from dataexport.cfarray.time_series import timeseriesdataset, timeseriescoords
from dataexport.export_types import ProjectExport
from dataexport.odm2.queries import (
    PointProjectResult,
    TimeseriesResult,
    timeseries_by_project,
    point_by_project,
)


def dump(
    conn: connection, settings: ProjectExport, start_time: datetime, end_time: datetime, is_acdd: bool = False
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    project_info = point_by_project(
        conn, project_name=settings.project_name, project_station_code=settings.project_station_code
    )
    ds = dataset(conn, settings, project_info, start_time, end_time)

    return acdd(settings.title, ds, project_info) if is_acdd else ds


def dataset(
    conn: connection,
    settings: ProjectExport,
    project_info: PointProjectResult,
    start_time: datetime,
    end_time: datetime,
) -> xr.Dataset:
    """Export sios data from odm2 to xarray dataset

    Map odm2 data into climate & forecast convention and return a xarray dataset.
    """

    query_by_time = partial(
        timeseries_by_project,
        conn=conn,
        project_name=project_info.projectname,
        project_station_code=project_info.projectstationcode,
        start_time=start_time,
        end_time=end_time,
    )

    query_results = map(lambda vc: query_by_time(variable_code=vc), settings.variable_codes)

    time_arrays = map(lambda qr: cftimearray(qr, project_info.latitude, project_info.longitude), query_results)

    ds = timeseriesdataset(
        named_dataarrays=list(time_arrays), title=settings.title, station_name=project_info.projectstationname
    )
    logging.info("Created xarray dataset")

    return ds


def acdd(title: str, ds: xr.Dataset, project_info: PointProjectResult):
    """Add ACDD attributes to a xarray dataset

    Add attributes following the Attribute Convention for Data Discovery to a dataset
    """
    logging.info(f"Adding ACDD attributes")
    ds.attrs.update(
        asdict(
            DatasetAttrs(
                title=title,
                summary=project_info.projectdescription,
                keywords=[
                    "Water-based Platforms > Buoys > Moored > BUOYS",
                    "EARTH SCIENCE > Oceans > Salinity/Density > Salinity",
                ],
                featureType=ds.attrs["featureType"],
                date_created=str(datetime.now()),
                project=project_info.projectname,
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
