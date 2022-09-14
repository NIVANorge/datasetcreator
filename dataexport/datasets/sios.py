import psycopg2
import os
from dataexport.odm2.queries import timeseries, timeseries_metadata

from dataexport.cfarray.base import dataarraybytime, DEFAULT_ENCODING
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.odm2.queries import TimeseriesResult

import xarray as xr
from functools import partial
from datetime import datetime, timedelta


def cfdataarrays(timeseries_result: TimeseriesResult, latitude, longitude) -> xr.DataArray:
    match timeseries_result.variable_code:
        case "Temp":
            return dataarraybytime(
                        data=timeseries_result.values,
                        name="temperature",
                        standard_name="sea_water_temperature",
                        long_name="Sea water temperature",
                        units="degree_Celsius",
                    ).assign_coords(
                        timeseriescoords(
                            time=timeseries_result.datetime,
                            latitude=latitude,
                            longitude=longitude,
                        )
                    )
        case _:
            print("No match")
