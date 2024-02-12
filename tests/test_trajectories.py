from datetime import datetime

from dscreator.datasets import trajectories


def test_ferrybox_trajectory():
    trajectory = dict(
        latitude=[50.70, 50.71, 50.72],
        longitude=[10.70, 10.71, 10.72],
        salinity= [1, None, 3],
        temperature=[10, 11, 12],
        time=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
    )

    example_builder = trajectories.ferrybox.NorsoopFantasy(
        "uuid", "dataset_name", "trajectory_name", "project_name", True
    )

    ds = example_builder.create(trajectory)

    assert len(ds.salinity) == 3
    assert len(ds.longitude) == 3
    assert all(ds.longitude==[10.70, 10.71, 10.72])
    assert all(ds.temperature==[10, 11, 12])
    assert ds.dims["time"] == 3
    assert ds.attrs["featureType"] == "trajectory"
    assert ds.temperature.attrs["standard_name"] == "sea_water_temperature"
