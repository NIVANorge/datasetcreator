#%%
from datetime import datetime, timedelta

from sqlalchemy import create_engine

from dscreator.cfarray.base import DEFAULT_ENCODING, dataarraybytime
from dscreator.cfarray.time_series import timeseriescoords, timeseriesdataset
from dscreator.config import SETTINGS
from dscreator.sources.odm2.extractor import TimeseriesExtractor

#%%
engine = create_engine(SETTINGS.database_url)
#%%
start_time = datetime(2022, 9, 23)
extractor = TimeseriesExtractor(engine, "MSOURCE1", ["Turbidity", "LevelValue"])
turbidity_res, level_res = extractor.fetch_slice(start_time, start_time + timedelta(days=1))
#%%
turbidity_array = dataarraybytime(
    data=turbidity_res.values,
    name="Turbidity",
    standard_name="rainbed_turbidity",
    long_name="Rainbed turbidity",
    units="NTU",
).assign_coords(
    timeseriescoords(
        time=turbidity_res.datetime_list,
        latitude=turbidity_res.locations[0].latitude,
        longitude=turbidity_res.locations[0].longitude,
    )
)
#%%
level_array = dataarraybytime(
    data=level_res.values,
    name="level",
    standard_name="rainbed_level",
    long_name="Rainbed Level",
    units="m",
).assign_coords(
    timeseriescoords(
        time=level_res.datetime_list,
        latitude=level_res.locations[0].latitude,
        longitude=level_res.locations[0].longitude,
    )
)

# %%
turbidity_array.plot.line("o")
# %%
ds = timeseriesdataset(
    named_dataarrays=[level_array, turbidity_array],
    station_name="oslo",
)
#%%
ds
# %%
ds.to_netcdf("timeseries.nc", unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

# %%
