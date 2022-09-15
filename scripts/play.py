#%%
import psycopg2
import os
from dataexport.odm2.queries import timeseries, timeseries_metadata

from dataexport.cfarray.base import dataarraybytime, DEFAULT_ENCODING
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset

from functools import partial
from datetime import datetime, timedelta

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
        latitude=project_metadata.lat,
        longitude=project_metadata.lon,
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
    id=project_metadata.projectstationname,
    title="SIOS sensor buoy in Adventfjorden",
    summary=project_metadata.projectdescription,
    keywords=["Water-based Platforms>Buoys>Moored>BUOYS"],
    project=project_metadata.projectname,
)
#%%
ds
# %%
ds.to_netcdf("timeseries.nc", unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

# %%
sios_data = map(lambda vc: query_sios_by_time(variable_code=vc), ["Temp", "Turbidity"])
# %%
from dataexport.datasets.sios import dump as sios_dump

sios_data = sios_dump(conn, end_time - timedelta(days=2), end_time)
# %%
for res in sios_data:
    print(res.varible_code)
# %%
sios_data
# %%
