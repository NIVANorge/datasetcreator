import logging
from dataclasses import dataclass, field
from datetime import datetime
from functools import partial
from typing import List

from psycopg2.extensions import connection

from dataexport.sources.odm2.queries import (
    PointResult,
    resultuuids_by_code,
    timeseries_by_resultuuid,
    point_by_sampling_code,
    timestamp_by_code,
)


@dataclass
class NamedTimeseries:
    variable_name: str
    location: PointResult
    values: List[str | int | float]
    datetime: List[datetime]


@dataclass
class TimeseriesExtractor:
    conn: connection
    sampling_feature_code: str
    variable_codes: str
    _point: PointResult = field(init=False)
    _resultuuids: List[str] = field(init=False)

    def __post_init__(self):
        self._point = point_by_sampling_code(self.conn, self.sampling_feature_code)
        self._resultuuids = [
            resultuuids_by_code(self.conn, self.sampling_feature_code, vc) for vc in self.variable_codes
        ]

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[NamedTimeseries]:
        """Create a Timeseries from ODM2

        Create a timeseries from ODM2 based on samlingfeaturecode and variable code
        limit to start and end time.
        """
        query_by_resultid = partial(
            timeseries_by_resultuuid,
            conn=self.conn,
            start_time=start_time,
            end_time=end_time,
        )

        named_timeseries = []
        for ruuid, vname in zip(self._resultuuids, self.variable_codes):
            res = query_by_resultid(result_uuid=ruuid)
            named_timeseries.append(NamedTimeseries(vname, self._point, res.values, res.datetime))

        return named_timeseries

    def first_timestamp(self, is_asc: bool) -> datetime:
        return timestamp_by_code(self.conn, self.sampling_feature_code, self.variable_codes, is_asc)

    def start_time(self) -> datetime:
        return self.first_timestamp(is_asc=True)

    def end_time(self) -> datetime:
        return self.first_timestamp(is_asc=False)
