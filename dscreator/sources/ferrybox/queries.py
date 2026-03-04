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
    qc_flags: List[str] = [-1, 0, 1],
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
    ).bindparams(
        track_uuid=track_uuid, uuids=tuple(uuids), start_time=start_time, end_time=end_time, qc_flags=tuple(qc_flags)
    )

    with engine.connect() as conn:
        return conn.execute(query).mappings().all()


def get_time_by_uuids(
    engine: Engine,
    uuids: List[str],
    is_asc: bool,
) -> Optional[datetime]:
    import logging
    logging.info(f"Querying database for {'first' if is_asc else 'last'} timestamp with {len(uuids)} UUIDs")
    logging.info(f"UUIDs: {uuids[:2]}... (showing first 2)")
    
    # First, check if ANY data exists for these UUIDs to avoid expensive query on empty dataset
    check_query = text("SELECT 1 FROM ts WHERE ts.uuid IN :uuids LIMIT 1").bindparams(uuids=tuple(uuids))
    logging.info("Checking if any data exists for these UUIDs...")
    with engine.connect().execution_options(timeout=30) as conn:
        result = conn.execute(check_query)
        has_data = result.fetchone() is not None
        
    if not has_data:
        logging.error(f"No data found in database for any of the {len(uuids)} UUIDs")
        logging.error("This dataset may not have been loaded yet, or the UUIDs may be incorrect")
        raise ValueError(f"No data found in database for UUIDs: {uuids}")
    
    logging.info("Data exists, proceeding with timestamp query...")
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
    logging.info("Executing timestamp query...")
    with engine.connect().execution_options(timeout=60) as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    logging.info(f"Got timestamp: {res_dict['time']}")
    return res_dict["time"]
