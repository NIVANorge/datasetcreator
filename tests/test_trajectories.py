from dataexport.sources.base import NamedTrajectory, Point
from dataexport.datasets.trajectories import ExampleTrajBuilder
from datetime import datetime


def test_example_trajectory():

    trajectory = NamedTrajectory(
        "Temp",
        locations=[Point(10.70, 50.70), Point(10.70, 50.71), Point(10.70, 50.72)],
        values=[1, 2, 3],
        datetime_list=[datetime(1999, 10, 4), datetime(1999, 10, 5), datetime(1999, 10, 6)],
    )

    example_builder = ExampleTrajBuilder(
        "uuid", "title", "summary", "dataset_name", "trajectory_name", "project_name", True
    )

    ds = example_builder.create([trajectory])

    assert ds.attrs["title"] == "title" 
    assert len(ds.temperature) == 3
