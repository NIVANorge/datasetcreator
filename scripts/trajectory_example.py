# Creating trajectories
# This example creates a single trajectory as described in C&F
# see https://cfconventions.org/Data/cf-conventions/cf-conventions-1.10/cf-conventions.html#_single_trajectory
# %%
from datetime import datetime

from dscreator.cfarray.attributes import CFVariableAttrs
from dscreator.cfarray.base import dataarraybytime
from dscreator.encoding import TIME_ENCODING
from dscreator.cfarray.trajectory import trajectorycoords, trajectorydataset

# %% Creating just a xarray dataset

longitudes = [10.70, 10.60, 10.50, 10.40]
latitudes = [50.70, 50.60, 50.50, 50.40]
time = list(
    map(
        datetime.fromisoformat,
        [
            "1970-06-01T00:00:00",
            "1970-06-01T10:00:00",
            "1980-06-01T10:00:00",
            "1990-06-01T10:00:00",
        ],
    )
)


# %%
temperature = dataarraybytime(
    name="temperature",
    data=[2, 4, 5, 7],
    attrs=CFVariableAttrs(
        standard_name="sea_water_temperature",
        long_name="sea_water_temperature",
        units="degree_Celsius",
    ),
).assign_coords(
    trajectorycoords(
        time=time,
        latitude=latitudes,
        longitude=longitudes,
    )
)
# %%
turbidity = dataarraybytime(
    name="turbidity",
    data=[None, 1, 5, 7],
    attrs=CFVariableAttrs(standard_name="sea_water_turbidity", long_name="sea_water_turbidity", units="degree_Celsius"),
).assign_coords(
    trajectorycoords(
        time=time,
        latitude=latitudes,
        longitude=longitudes,
    )
)
# %%
ds = trajectorydataset([temperature, turbidity], "trajectory-test")

# %%

ds.temperature.plot()

# %%
ds.to_netcdf("example_trajectory.nc", encoding={ "time": TIME_ENCODING })
# run `ncdump example_trajectory.nc` on commandline to view text repr also

# %%

# Example TrajectoryExtractor
# also see tests/test_trajectories.py
# %%
from datetime import datetime

from dscreator.datasets import trajectories
from dscreator.sources.base import NamedTrajectory, Point

# %%
# Example input to the trajectory builder
trajectory = NamedTrajectory(
    "Temp",
    locations=[Point(10.71, 50.70), Point(10.70, 50.71), Point(10.70, 50.72)],
    values=[1, 2, 3],
    datetime_list=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
)

example_builder = trajectories.example.ExampleTrajBuilder(
    "uuid", "dataset_name", "trajectory_name", "project_name", True
)

# %%
ds = example_builder.create([trajectory])
# %%

print(ds.attrs)
