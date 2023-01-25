#%%
from datetime import datetime, timedelta
from functools import partial

import psycopg2

from dataexport.cfarray.base import DEFAULT_ENCODING, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.config import DATABASE_URL
from dataexport.sources.odm2.queries import timeseries_by_project, timeseries_by_sampling_code, point_by_project

#%%
conn = psycopg2.connect(DATABASE_URL)
#%%
end_time = datetime(2022, 10, 1)
query_sios_by_time = partial(
    timeseries_by_project,
    conn=conn,
    project_name="SIOS",
    project_station_code="20",
    start_time=end_time - timedelta(days=2),
    end_time=end_time,
)
#%%
query_msource_by_time = partial(
    timeseries_by_sampling_code,
    conn=conn,
    sampling_feature_code="MSOURCE2",
    start_time=end_time - timedelta(days=2),
    end_time=end_time,
)

#%%
temperature_res = query_sios_by_time(variable_code="Temp")
turbidity_res = query_sios_by_time(variable_code="Turbidity")
#%%
project_metadata = point_by_project(conn, project_name="SIOS", project_station_code="20")
#%%
temperature_array = dataarraybytime(
    data=temperature_res.values,
    name="temperature",
    standard_name="sea_water_temperature",
    long_name="Sea water temperature",
    units="degree_Celsius",
).assign_coords(
    timeseriescoords(
        time=temperature_res.datetime,
        latitude=project_metadata.latitude,
        longitude=project_metadata.longitude,
    )
)
#%%
turbidity_array = dataarraybytime(
    data=turbidity_res.values,
    name="turbidity",
    standard_name="sea_water_turbidity",
    long_name="Sea water turbidity",
    units="NTU",
).assign_coords(
    timeseriescoords(
        time=turbidity_res.datetime,
        latitude=project_metadata.latitude,
        longitude=project_metadata.longitude,
    )
)

# %%
turbidity_array.plot.line("o")
# %%
ds = timeseriesdataset(
    named_dataarrays=[temperature_array, turbidity_array],
    title="SIOS sensor buoy in Adventfjorden",
    station_name="Adventfjorden",
)
#%%
ds
# %%
ds.to_netcdf("timeseries.nc", unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

# %%
sios_data = map(lambda vc: query_sios_by_time(variable_code=vc), ["Temp", "Turbidity"])
# %%
ds
# %%
