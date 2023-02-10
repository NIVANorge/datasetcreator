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
       select time, ST_X(pos) as longitude, ST_Y(pos) as latitude
    FROM
        track
    WHERE
        track.uuid = :track_uuid
        AND track.valuedatetime > :start_time
        AND track.valuedatetime <= :end_time
        AND track.qc = 1
    ORDER BY
        track.time ASC
    """
    ).bindparams(result_uuid=track_uuid, start_time=start_time, end_time=end_time)

    logging.info(f"Querying track for uuid {track_uuid}")

    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().all()
    logging.info(f"res_dict {res_dict}")
    return TrackResult(
        values=[Point(r["longitude"], r["longitude"]) for r in res_dict], datetime=[r["time"] for r in res_dict]
    )


def get_ts(
        engine: Engine,
        uuid: str,
        start_time: datetime,
        end_time: datetime,
):
    pass
