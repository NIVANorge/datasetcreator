import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from functools import partial
from typing import List

from sqlalchemy import Engine
import numpy as np

from dscreator.sources.base import BaseExtractor, Point
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
    ) -> dict[str, list]:
        """Create a Timeseries from ODM2

        Create a timeseries from ODM2 based on samlingfeaturecode and variable code.
        The timeseries is limited to start_time<t<=end_time. The result is a dictionary with the following keys:
        - time (list of datetime)
        - variable_names (list of float)
        - latitude (list of float) only one value mapped to a scalar
        - longitude (list of float) only one value mapped to a scalar
        """

        res = timeseries_by_resultuuid(
            engine=self.engine,
            result_uuids=self._resultuuids,
            variable_names=self.variable_codes,
            start_time=start_time,
            end_time=end_time,
        )
        data_dict = {v.lower(): [] for v in self.variable_codes}
        data_dict["time"] = []
        for value in res:
            for vname in data_dict:
                data_dict[vname].append(value[vname])

        data_dict["longitude"] = [self._point.longitude]
        data_dict["latitude"] = [self._point.latitude]

        return data_dict

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
