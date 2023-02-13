import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List
from sqlalchemy import Engine
from functools import partial
from dscreator.sources.ferrybox.uuid_variable_code_mapper import MAPPER
from dscreator.sources.base import BaseExtractor, NamedTrajectory, Point
from dscreator.sources.ferrybox.queries import get_track, get_ts, get_time_by_uuids


@dataclass
class TrajectoryExtractor(BaseExtractor):
    engine: Engine
    platform_code: str
    variable_codes: List[str]
    _track: List[Point] = field(init=False)

    def fetch_slice(
            self,
            start_time: datetime,
            end_time: datetime,
    ) -> List[NamedTrajectory]:
        """Create a Timeseries from tsb
        The timeseries is limited to start_time<t<=end_time.
        """
        query_ts = partial(get_ts, engine=self.engine, start_time=start_time, end_time=end_time)

        named_trajectories = []
        track = get_track(self.engine, MAPPER[self.platform_code]["track"], start_time, end_time).values
        self._track = track
        for vcode in self.variable_codes:
            res = query_ts(uuid=MAPPER[self.platform_code][vcode])
            if len(res.values) > 0:
                named_trajectories.append(NamedTrajectory(vcode, self._track, res.values, res.datetime))
            else:
                logging.info(f"No values for {vcode} for time period ({start_time} : {end_time})")
                # named_trajectories.append(NamedTrajectory(vcode, self._track, [None for i in range(res.datetime)],
                #                                           res.datetime))
        return named_trajectories

    def _timestamp(self, is_asc: bool) -> datetime:
        return get_time_by_uuids(self.engine, [MAPPER[self.platform_code][vcode] for vcode in self.variable_codes],
                                 is_asc)

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction
        Padded with 10 sec
        """
        #return self._timestamp(is_asc=True) - timedelta(seconds=1)
        return datetime(2022, 12, 12, 16, 0, 0)


    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction
        Padded with 10 sec
        """
        return self._timestamp(is_asc=False) + timedelta(seconds=1)
