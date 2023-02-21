import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List
from sqlalchemy import Engine
from functools import partial
from dscreator.sources.ferrybox.uuid_variable_code_mapper import MAPPER
from dscreator.sources.base import BaseExtractor, NamedTrajectory, Point, NamedTimeArray
from dscreator.sources.ferrybox.queries import get_track, get_ts, get_time_by_uuids


@dataclass
class TrajectoryExtractor(BaseExtractor):
    engine: Engine
    platform_code: str
    variable_codes: List[str]

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> NamedTrajectory:
        """Create a Timeseries from tsb
        The timeseries is limited to start_time<t<=end_time.
        """
        query_ts = partial(get_ts, engine=self.engine, start_time=start_time, end_time=end_time)

        named_timearrays = []
        track = get_track(self.engine, MAPPER[self.platform_code]["track"], start_time, end_time)
        track_datetime = track.datetime
        for vcode in self.variable_codes:
            res = query_ts(uuid=MAPPER[self.platform_code][vcode])
            if len(res.values) > 0:
                logging.info(f"fetching vcode {vcode}")
                values = [res.values[res.datetime.index(dt)] if dt in res.datetime else None for dt in track_datetime]
                named_timearrays.append(NamedTimeArray(vcode, values))
            else:
                logging.info(f"No values for {vcode} for time period ({start_time} : {end_time})")
                named_timearrays.append(NamedTimeArray(vcode, [None for x in range(len(track_datetime))]))
        # values = [ts.values for ts in named_timearrays]
        track_values = track.values

        return NamedTrajectory(array_list=named_timearrays, datetime_list=track_datetime, locations=track_values)

    def _timestamp(self, is_asc: bool) -> datetime:
        return get_time_by_uuids(
            self.engine, [MAPPER[self.platform_code][vcode] for vcode in self.variable_codes], is_asc
        )

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction
        Padded with 10 sec
        """
        # return self._timestamp(is_asc=True) - timedelta(seconds=1)
        return datetime(2022, 12, 12, 16, 0, 0)

    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction
        Padded with 10 sec
        """
        return self._timestamp(is_asc=False) + timedelta(seconds=1)
