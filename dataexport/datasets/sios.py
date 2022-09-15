from array import array
from datetime import datetime, timedelta
from functools import partial

import xarray as xr

from dataexport.cfarray.base import DEFAULT_ENCODING, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.odm2.queries import TimeseriesMetadataResult, TimeseriesResult


def cfdataarray(timeseries_result: TimeseriesResult, project_metadata: TimeseriesMetadataResult) -> xr.DataArray:
    match timeseries_result.variable_code:
        case "Temp":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="temperature",
                standard_name="sea_water_temperature",
                long_name="Sea water temperature",
                units="degree_Celsius",
            )
        case "Turbidity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="turbidity",
                standard_name="sea_water_turbidity",
                long_name="Sea water turbidity",
                units="NTU",
            )
        case "Salinity":
            array = dataarraybytime(
                data=timeseries_result.values,
                name="turbidity",
                standard_name="sea_water_turbidity",
                long_name="Sea water turbidity",
                units="NTU",
            )
        case _:
            raise RuntimeError("Unknown variable code")

    return array.assign_coords(
        timeseriescoords(
            time=timeseries_result.datetime,
            latitude=project_metadata.latitude,
            longitude=project_metadata.longitude,
        )
    )
