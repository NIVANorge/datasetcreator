import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional, Union

from sqlalchemy import Engine, Sequence, RowMapping
from sqlalchemy.sql import text

from dscreator.sources.base import Point


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

    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().all()
    return TrackResult(
        values=[Point(r["longitude"], r["latitude"]) for r in res_dict], datetime=[r["time"] for r in res_dict]
    )


def get_ts(
    engine: Engine,
    track_uuid: str,
    uuids: List[str],
    start_time: datetime,
    end_time: datetime,
    qc_flags: List[str] = [-1,0,1]
) -> Sequence[RowMapping]:
    """Query track
    The timeseries is limited to start_time<t<=end_time.
    """
    query = text(
        """
    SELECT
        track.time, 
        ST_X(track.pos) as longitude, 
        ST_Y(track.pos) as latitude,
        ts.uuid, 
        ts.value,
        ts.qc
    FROM track
    INNER JOIN ts 
    ON track.time = ts.time
    WHERE
        track.uuid = :track_uuid
        AND track.time > :start_time
        AND track.time <= :end_time
        AND ts.uuid in :uuids
        AND ts.qc in :qc_flags
    ORDER BY
        track.time ASC
    """
    ).bindparams(track_uuid=track_uuid, uuids=tuple(uuids), start_time=start_time, end_time=end_time, qc_flags=tuple(qc_flags))

    with engine.connect() as conn:
        return conn.execute(query).mappings().all()


def get_time_by_uuids(
    engine: Engine,
    uuids: List[str],
    is_asc: bool,
) -> Optional[datetime]:
    query_str = """
    SELECT
        time
    FROM
        ts
    WHERE
        ts.uuid IN :uuids
    ORDER BY
        time
    """
    query_str += "ASC LIMIT 1" if is_asc else "DESC LIMIT 1"
    query = text(query_str).bindparams(uuids=tuple(uuids))
    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    return res_dict["time"]
