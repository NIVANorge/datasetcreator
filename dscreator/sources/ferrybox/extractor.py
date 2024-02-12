import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List
import pandas as pd

from sqlalchemy import Engine, Sequence, RowMapping

from dscreator.sources.base import BaseExtractor
from dscreator.sources.ferrybox.queries import get_time_by_uuids, get_ts


@dataclass
class TrajectoryExtractor(BaseExtractor):
    """Create a ferybox trajectory extractor

    platform_variable_key: A key in the MAPPER dict
    """

    engine: Engine
    variable_codes: List[str]
    variable_uuid_map: dict[str, str]
    qc_flags: List[int]
    qc_variables: List[str] = field(init=False)

    def __post_init__(self):
        self.qc_variables = [f"{v}_qc" for v in self.variable_codes]

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> dict[str, list]:
        """Create a Timeseries from tsb

        The timeseries is limited to start_time<t<=end_time.
        """

        data_list = get_ts(
            self.engine,
            track_uuid=self.variable_uuid_map["track"],
            uuids=list(self.variable_uuid_map.values()),
            start_time=start_time,
            end_time=end_time,
            qc_flags=self.qc_flags,
        )

        return self._to_dict(data_list)

    def _to_dict(self, data_list: Sequence[RowMapping]) -> dict[str, list]:
        """Convert data_list to a dictionary of lists

        Assumes data_list is sorted ascending on time.
        The dict will contain the following keys:
            - time
            - latitude
            - longitude
            - variable_codes
            - qc_variables
        """

        data_dict = {v: [] for v in ["time", "latitude", "longitude"] + self.variable_codes + self.qc_variables}
        value_template = {v: (None, None) for v in self.variable_uuid_map.values()}

        previous_point = current_point = data_list.pop(0)
        value_template[str(previous_point.uuid)] = (previous_point.value, previous_point.qc)

        while data_list:
            current_point = data_list.pop(0)
            point_uuid = str(current_point.uuid)
            if current_point.time > previous_point.time:
                self._push_point(data_dict, previous_point, value_template)
                previous_point = current_point
            value_template[point_uuid] = (current_point.value, current_point.qc)
        self._push_point(data_dict, current_point, value_template)

        return data_dict

    def _push_point(self, data_dict: dict, current_point: dict, value_template: dict):
        """Push point into data_dict and reset value_template"""

        data_dict["time"].append(current_point.time)
        data_dict["latitude"].append(current_point.latitude)
        data_dict["longitude"].append(current_point.longitude)

        for var_name in self.variable_codes:
            point_uuid = self.variable_uuid_map[var_name]
            data_dict[var_name].append(value_template[point_uuid][0])

        for var_name in self.qc_variables:
            point_uuid = self.variable_uuid_map[var_name.split("_qc")[0]]
            data_dict[var_name].append(value_template[point_uuid][1])

        for k in value_template.keys():
            value_template[k] = (None, None)

    def _timestamp(self, is_asc: bool) -> datetime:
        return get_time_by_uuids(self.engine, [self.variable_uuid_map[vcode] for vcode in self.variable_codes], is_asc)

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction
        Padded with 10 sec
        """
        # return self._timestamp(is_asc=True) - timedelta(seconds=1)
        return datetime(2022, 12, 12, 16, 0)

    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction
        Padded with 10 sec
        """
        return self._timestamp(is_asc=False) + timedelta(seconds=1)
