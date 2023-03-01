# Example plot with moving pandas
# Install extra dependecies with:
# `poetry install --with plotting

#%%
import xarray as xr
import movingpandas as mpd
import holoviews as hv

# setting bokeh as backend
hv.extension('bokeh')
from bokeh.plotting import show
# %% Or replace with you path to example trajectory
ds = xr.open_dataset("../catalog/datasets/norsoop/rt_ferrybox_FA/2022-12-12T160100Z_acdd_rt_ferrybox_fa.nc")
#%%
traj = mpd.Trajectory(
    df=ds.to_dataframe(), traj_id=str(ds.trajectory_name.values), t="time", x="longitude", y="latitude"
)
#%%
traj.df.head()
#%%
plot = traj.hvplot(c='salinity', title=ds.attrs["title"], line_width=2, frame_width=700, frame_height=500)

# %%
# this can be a bit slow
show(hv.render(plot))
# %%
