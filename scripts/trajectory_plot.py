# Example plot with moving pandas
# Install extra dependecies with:
# `poetry install

#%%
import xarray as xr
import movingpandas as mpd
import holoviews as hv
from datetime import timedelta
import matplotlib.pyplot as plt

# %% Or replace with you path to example trajectory
ds = xr.open_dataset("../catalog/datasets/norsoop/rt_ferrybox_FA/2022-12-12T160100Z_acdd_rt_ferrybox_fa.nc")
#%%
traj = mpd.Trajectory(
    df=ds.to_dataframe(), traj_id=str(ds.trajectory_name.values), t="time", x="longitude", y="latitude"
)
#%%
traj.df.head()
#%%
# This can be a bit slow
traj.hvplot(title=ds.attrs["title"], line_width=2, frame_width=700, frame_height=500)
# %%
split = mpd.ObservationGapSplitter(traj).split(gap=timedelta(minutes=60))
split
# %%
split.to_traj_gdf()
# %%
#assumes you have a 5 sub trajectories
fig, axes = plt.subplots(nrows=1, ncols=5)
for i, traj in enumerate(split.trajectories[0:5]):
    traj.plot(ax=axes[i], linewidth=5.0, capstyle="round", column="salinity", vmax=20)
