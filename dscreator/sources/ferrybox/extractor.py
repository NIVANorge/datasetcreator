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
        track_datetime = list(track.datetime)
        for vcode in self.variable_codes:
            res = query_ts(uuid=MAPPER[self.platform_code][vcode])
            if len(res.values) > 0:
                logging.info(f"fetching vcode {vcode}")
                values = [res.values[res.datetime.index(dt)] if dt in res.datetime else None for dt in track_datetime]
                named_timearrays.append(NamedTimeArray(vcode, values))
            else:
                logging.info(f"No values for {vcode} for time period ({start_time} : {end_time})")
                named_timearrays.append(NamedTimeArray(vcode, [None for x in range(len(track_datetime))]))
        # Get indices of all None values
        i_None = [[i for i, v in enumerate(ts.values) if v is None] for ts in named_timearrays]
        # If None appears for all measurements, it means there is no valid data
        i_noData = list(
            set([index for index in i_None[0] for j in range(1, len(named_timearrays)) if index in i_None[j]]))
        named_timearrays = [
            NamedTimeArray(nta.variable_name, [v for i, v in enumerate(nta.values) if i not in i_noData]) for nta in
            named_timearrays]
        track_values = [tv for i, tv in enumerate(track.values) if i not in i_noData]
        track_datetime = [tdt for i, tdt in enumerate(track_datetime) if i not in i_noData]
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
