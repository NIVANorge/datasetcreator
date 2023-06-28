import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List

from sqlalchemy import Engine, Sequence, RowMapping

from dscreator.sources.base import BaseExtractor, NamedArray, NamedTrajectory, Point
from dscreator.sources.ferrybox.queries import get_time_by_uuids, get_ts
from dscreator.sources.ferrybox.uuid_variable_code_mapper import MAPPER


@dataclass
class TrajectoryExtractor(BaseExtractor):
    engine: Engine
    platform_code: str
    variable_codes: List[str]
    variable_uuid_map: dict[str, str] = field(init=False)

    def __post_init__(self):
        self.variable_uuid_map = MAPPER[self.platform_code]

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> NamedTrajectory:
        """Create a Timeseries from tsb

        The timeseries is limited to start_time<t<=end_time.
        """

        named_trajectory = NamedTrajectory([NamedArray(vcode, []) for vcode in self.variable_codes], [], [])

        data_list = get_ts(
            self.engine,
            track_uuid=self.variable_uuid_map["track"],
            uuids=list(self.variable_uuid_map.values()),
            start_time=start_time,
            end_time=end_time,
        )

        return self._pack_data(data_list, named_trajectory) if data_list else named_trajectory

    def _pack_data(self, data_list: Sequence[RowMapping], named_trajectory: NamedTrajectory) -> NamedTrajectory:
        """Pack data into a named trajectory

        Assumes data_list is sorted ascending on time."""

        value_template = {v: None for v in self.variable_uuid_map.values()}
        previous_point = current_point = data_list.pop(0)
        value_template[str(previous_point.uuid)] = previous_point.value

        while data_list:
            current_point = data_list.pop(0)
            point_uuid = str(current_point.uuid)
            if current_point.time > previous_point.time:
                self._push_point(previous_point, value_template, named_trajectory)
                previous_point = current_point
            value_template[point_uuid] = current_point.value
        self._push_point(current_point, value_template, named_trajectory)

        return named_trajectory

    def _push_point(self, current_point: dict, value_template: dict, named_trajectory: NamedTrajectory):
        """Push point into a named trajectory
        
        value_template contains the values for each uuid, for missing data it is set to None.
        """

        named_trajectory.datetime_list.append(current_point.time)
        named_trajectory.locations.append(Point(current_point.longitude, current_point.latitude))

        for array in named_trajectory.array_list:
            point_uuid = self.variable_uuid_map[array.variable_name]
            array.values.append(value_template[point_uuid])
            value_template[point_uuid] = None

    def _timestamp(self, is_asc: bool) -> datetime:
        return get_time_by_uuids(
            self.engine, [MAPPER[self.platform_code][vcode] for vcode in self.variable_codes], is_asc
        )

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
