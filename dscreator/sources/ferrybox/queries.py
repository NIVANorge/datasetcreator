import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional
from dscreator.sources.base import Point

from sqlalchemy import Engine
from sqlalchemy.sql import text


@dataclass
class TrackResult:
    values: List[Point]
    datetime: List[datetime]


def get_track(
        engine: Engine,
        track_uuid: str,
        start_time: datetime,
        end_time: datetime,
) -> TrackResult:
    """Query track
    The timeseries is limited to start_time<t<=end_time.
    """
    query = text(
        """
    SELECT
        time, ST_X(pos) as longitude, ST_Y(pos) as latitude
    FROM
        track
    WHERE
        track.uuid = :track_uuid
        AND track.time > :start_time
        AND track.time <= :end_time
    ORDER BY
        track.time ASC
    """
    ).bindparams(track_uuid=track_uuid, start_time=start_time, end_time=end_time)

    logging.info(f"Querying track for uuid {track_uuid}")

    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().all()
    return TrackResult(
        values=[Point(r["longitude"], r["longitude"]) for r in res_dict], datetime=[r["time"] for r in res_dict]
    )


@dataclass
class TimeseriesResult:
    uuid: str
    values: List[str | int | float]
    datetime: List[datetime]


def get_ts(
        engine: Engine,
        uuid: str,
        start_time: datetime,
        end_time: datetime,
) -> TimeseriesResult:
    """Query track
    The timeseries is limited to start_time<t<=end_time.
    """
    query = text(
        """
    SELECT
        time, value
    FROM
        ts
    WHERE
        ts.uuid = :uuid
        AND ts.time > :start_time
        AND ts.time <= :end_time
    ORDER BY
        ts.time ASC
    """
    ).bindparams(uuid=uuid, start_time=start_time, end_time=end_time)

    logging.info(f"Querying ts for uuid {uuid}")

    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().all()

    logging.info(f"res_dict {res_dict}")
    return TimeseriesResult(uuid=uuid, values=[a['value'] for a in res_dict], datetime=[a['time'] for a in res_dict])
