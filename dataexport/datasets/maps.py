import logging
from array import array
from datetime import datetime, timedelta
from functools import partial

import xarray as xr

from dataexport.cfarray.base import DEFAULT_ENCODING, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.odm2.queries import TimeseriesMetadataResult, TimeseriesResult


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
