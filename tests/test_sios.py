from unittest import mock
from datetime import datetime

from dataexport.odm2.queries import TimeseriesResult, TimeseriesMetadataResult
from dataexport.datasets import sios

sample_timeseries = TimeseriesResult(
    variable_code="Temp",
    values=[4.264, 4.2233, 4.2086],
    datetime=[
        datetime(2022, 9, 30, 9, 45),
        datetime(2022, 9, 30, 10, 0),
        datetime(2022, 9, 30, 10, 15),
    ],
)
sample_project_metadata = TimeseriesMetadataResult(
    projectname="SIOS",
    projectdescription="Sensorbøye innerst i Adventfjorden",
    projectstationname="SIOS bøye",
    longitude=15.6231,
    latitude=78.2232,
)


@mock.patch("dataexport.datasets.sios.timeseries")
@mock.patch("dataexport.datasets.sios.timeseries_metadata")
def test_dump(m_timeseries_metadata, m_timeseries):

    m_timeseries.return_value = sample_timeseries
    m_timeseries_metadata.return_value = sample_project_metadata
    ds = sios.dump(mock.MagicMock(), sample_timeseries.datetime[0], sample_timeseries.datetime[-1])

    assert len(ds.temperature.values) == len(sample_timeseries.values)
    assert all(expected == actual for expected, actual in zip(sample_timeseries.values, ds.temperature.values))
