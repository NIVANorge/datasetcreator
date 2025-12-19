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


def get_spectra(
    engine: Engine,
    track_uuid: str,
    uuids: list[str],
    wave_lengths: List[int],
    start_time: datetime,
    end_time: datetime,
    qc_flags: List[str] = [-1, 0, 1],
) -> Sequence[RowMapping]:
    """Query spectra along track

    The timeseries is limited to start_time<t<=end_time and joined with track on minute level.
    """
    query = text(
        """
    SELECT
        spectra.time, 
        spectra.uuid || '_' || spectra.wl as uuid,
        AVG(ST_X(track.pos)) as longitude, 
        AVG(ST_Y(track.pos)) as latitude,
        AVG(spectra.value) as value,
        MIN(spectra.qc) as qc
    FROM track
    JOIN spectra
    ON date_trunc('minute', track.time) = date_trunc('minute', spectra.time)
    WHERE
        track.uuid = :track_uuid
        AND track.time > :start_time
        AND track.time <= :end_time
        AND spectra.uuid IN :uuids
        AND spectra.wl IN :wave_lengths
        AND spectra.qc IN :qc_flags
    GROUP BY spectra.time, spectra.uuid, spectra.wl
    ORDER BY
        spectra.time ASC
    """
    ).bindparams(
        track_uuid=track_uuid,
        uuids=tuple(uuids),
        wave_lengths=tuple(wave_lengths),
        start_time=start_time,
        end_time=end_time,
        qc_flags=tuple(qc_flags),
    )


def get_spectra_with_rrs_qc_filter(
    engine: Engine,
    track_uuid: str,
    rrs_uuid: str,
    other_uuids: list[str],
    wave_lengths: List[int],
    start_time: datetime,
    end_time: datetime,
) -> Sequence[RowMapping]:
    """Query spectra where rrs has qc=1, returning both rrs and radiancelu/ld/ed

    More efficient than separate queries - does filtering in SQL rather than Python.
    Returns radiancelu, radianceld, and irradianceed only for time+wavelength pairs
    where corresponding rrs has qc=1.
    """
    query = text(
        """
    WITH rrs_valid AS (
        -- Get all (time, wavelength) pairs where rrs has qc=1
        SELECT DISTINCT spectra.time, spectra.wl
        FROM spectra
        JOIN track ON date_trunc('minute', track.time) = date_trunc('minute', spectra.time)
        WHERE track.uuid = :track_uuid
          AND track.time > :start_time
          AND track.time <= :end_time
          AND spectra.uuid = :rrs_uuid
          AND spectra.wl IN :wave_lengths
          AND spectra.qc = 1
    )
    SELECT
        spectra.time,
        spectra.uuid || '_' || spectra.wl as uuid,
        AVG(ST_X(track.pos)) as longitude,
        AVG(ST_Y(track.pos)) as latitude,
        AVG(spectra.value) as value,
        MIN(spectra.qc) as qc
    FROM track
    JOIN spectra ON date_trunc('minute', track.time) = date_trunc('minute', spectra.time)
    JOIN rrs_valid ON spectra.time = rrs_valid.time AND spectra.wl = rrs_valid.wl
    WHERE track.uuid = :track_uuid
      AND track.time > :start_time
      AND track.time <= :end_time
      AND spectra.uuid IN :all_uuids
      AND spectra.wl IN :wave_lengths
    GROUP BY spectra.time, spectra.uuid, spectra.wl
    ORDER BY spectra.time ASC
    """
    ).bindparams(
        track_uuid=track_uuid,
        rrs_uuid=rrs_uuid,
        all_uuids=tuple([rrs_uuid] + other_uuids),
        wave_lengths=tuple(wave_lengths),
        start_time=start_time,
        end_time=end_time,
    )

    with engine.connect() as conn:
        return conn.execute(query).mappings().all()


def get_spectra_time_by_uuids(
    engine: Engine,
    uuids: List[str],
    wave_lengths: List[int],
    is_asc: bool,
) -> Optional[datetime]:
    query_str = """
    SELECT
        time
    FROM
        spectra
    WHERE
        spectra.uuid IN :uuids
        AND spectra.wl IN :wave_lengths
    ORDER BY
        time
    """
    query_str += "ASC LIMIT 1" if is_asc else "DESC LIMIT 1"
    query = text(query_str).bindparams(uuids=tuple(uuids), wave_lengths=tuple(wave_lengths))
    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    return res_dict["time"]
