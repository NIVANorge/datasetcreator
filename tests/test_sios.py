from datetime import datetime
from unittest import mock

from dataexport.datasets import sios
from dataexport.export_types import ProjectExport
from dataexport.sources.odm2.queries import PointProjectResult, TimeseriesResult

sample_timeseries = TimeseriesResult(
    variable_code="Temp",
    values=[4.264, 4.2233, 4.2086],
    datetime=[
        datetime(2022, 9, 30, 9, 45),
        datetime(2022, 9, 30, 10, 0),
        datetime(2022, 9, 30, 10, 15),
    ],
)
sample_project_metadata = PointProjectResult(
    projectname="SIOS",
    projectdescription="Sensorbøye innerst i Adventfjorden",
    projectstationname="SIOS bøye",
    projectstationcode="20",
    samplingfeaturecode="code",
    longitude=15.6231,
    latitude=78.2232,
)


@mock.patch("dataexport.datasets.sios.timeseries_by_project")
@mock.patch("dataexport.datasets.sios.point_by_project")
def test_create(m_timeseries_metadata, m_timeseries):

    export_info = ProjectExport(
        uuid="id",
        title="title2",
        project_name="project_name",
        variable_codes=["Temp"],
        dataset_name="datasetname",
        project_station_code="pcode",
    )
    m_timeseries.return_value = sample_timeseries
    m_timeseries_metadata.return_value = sample_project_metadata
    ds = sios.create(mock.MagicMock(), export_info, sample_timeseries.datetime[0], sample_timeseries.datetime[-1])

    assert ds.attrs["featureType"] == "timeseries"
    assert len(ds.temperature.values) == len(sample_timeseries.values)
    assert all(expected == actual for expected, actual in zip(sample_timeseries.values, ds.temperature.values))
