from dataclasses import dataclass, field
from datetime import datetime
from typing import List
from sqlalchemy import Engine
from functools import partial
from dscreator.sources.ferrybox.uuid_variable_code_mapper import MAPPER
from dscreator.sources.base import BaseExtractor, NamedTrajectory, Point
from dscreator.sources.ferrybox.queries import get_track, get_ts


@dataclass
class TrajectoryExtractor(BaseExtractor):
    engine: Engine
    platform_code: str
    variable_codes: List[str]
    start_time: datetime
    end_time: datetime
    _track: List[Point] = field(init=False)

    # _uuids: List[str] = field(init=False)

    def __post_init__(self):
        self._track = get_track(self.engine, MAPPER[self.platform_code]["track"],
                                self.start_time, self.end_time).values
        # self._uuids = [MAPPER[self.platform_code][vc] for vc in self.variable_codes]

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
        for vcode in self.variable_codes:
            res = query_ts(uuid=MAPPER[self.platform_code][vcode])
            named_trajectories.append(NamedTrajectory(vcode, self._track, res.values, res.datetime))
        return named_trajectories

    def first_timestamp(self) -> datetime:
        return datetime(2022, 12, 12, 16, 0, 0)

    def last_timestamp(self) -> datetime:
        return datetime(2022, 12, 12, 16, 30, 0)