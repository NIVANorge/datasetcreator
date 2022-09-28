#%%
import os
from datetime import datetime, timedelta
from functools import partial

import psycopg2

from dataexport.cfarray.base import DEFAULT_ENCODING, dataarraybytime
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.odm2.queries import timeseries, timeseries_metadata

#%%
DATABASE_URL = f'postgresql:///odm2?host=localhost&port=5432&user={os.environ["DB_USER"]}'
conn = psycopg2.connect(DATABASE_URL)
#%%
end_time = datetime.now()
query_sios_by_time = partial(
    timeseries,
    conn=conn,
    project_name="SIOS",
    project_station_code="20",
    start_time=end_time - timedelta(days=2),
    end_time=end_time,
)
#%%
temperature_res = query_sios_by_time(variable_code="Temp")
turbidity_res = query_sios_by_time(variable_code="Turbidity")
#%%
project_metadata = timeseries_metadata(conn, project_name="SIOS", project_station_code="20")
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
# %%
ds.to_netcdf("timeseries.nc", unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

# %%
sios_data = map(lambda vc: query_sios_by_time(variable_code=vc), ["Temp", "Turbidity"])
# %%
ds
# %%
