import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from functools import partial
from typing import List

from sqlalchemy import Engine

from dscreator.sources.base import BaseExtractor, NamedTimeseries, Point, NamedTimeArray
from dscreator.sources.odm2.queries import (
    point_by_sampling_code,
    resultuuids_by_code,
    timeseries_by_resultuuid,
    timestamp_by_code,
)


@dataclass
class TimeseriesExtractor(BaseExtractor):
    engine: Engine
    sampling_feature_code: str
    variable_codes: str
    _point: Point = field(init=False)
    _resultuuids: List[str] = field(init=False)

    def __post_init__(self):
        self._point = point_by_sampling_code(self.engine, self.sampling_feature_code)
        self._resultuuids = [
            resultuuids_by_code(self.engine, self.sampling_feature_code, vc) for vc in self.variable_codes
        ]

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[NamedTimeseries]:
        """Create a Timeseries from ODM2

        Create a timeseries from ODM2 based on samlingfeaturecode and variable code.
        The timeseries is limited to start_time<t<=end_time.
        """
        query_by_resultid = partial(
            timeseries_by_resultuuid,
            engine=self.engine,
            start_time=start_time,
            end_time=end_time,
        )

        named_timeseries = []
        for ruuid, vname in zip(self._resultuuids, self.variable_codes):
            res = query_by_resultid(result_uuid=ruuid)
            named_timeseries.append(
                NamedTimeArray(vname, res.values, datetime_list=res.datetime, locations=[self._point])
            )

        return NamedTimeseries(array_list=named_timeseries)

    def _timestamp(self, is_asc: bool) -> datetime:
        return timestamp_by_code(self.engine, self.sampling_feature_code, self.variable_codes, is_asc)

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction

        Padded with 1 minute
        """
        return self._timestamp(is_asc=True) - timedelta(minutes=1)

    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction

        Padded with 1 minute.
        """
        return self._timestamp(is_asc=False) + timedelta(minutes=1)
