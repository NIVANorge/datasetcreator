from datetime import datetime

from dscreator.datasets import trajectories
from dscreator.sources.base import NamedTrajectory, Point, NamedArray


def test_ferrybox_trajectory():
    trajectory = NamedTrajectory(
        locations=[Point(10.71, 50.70), Point(10.70, 50.71), Point(10.70, 50.72)],
        array_list=[NamedArray("Salinity", [1, 2, 3])],
        datetime_list=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
    )

    example_builder = trajectories.ferrybox.FerryboxTrajBuilder(
        "uuid", "dataset_name", "trajectory_name", "project_name", True
    )

    ds = example_builder.create(trajectory)

    assert len(ds.salinity) == 3
    assert len(ds.longitude) == 3
    assert all([actual == expected for actual, expected in zip(ds.longitude, [10.71, 10.70, 10.70])])
