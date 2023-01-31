import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional

import psycopg2
from psycopg2.extras import RealDictCursor

from dataexport.sources.base import Point


def resultuuids_by_code(
    conn: psycopg2.extensions.connection, sampling_feature_code: str, variable_code: str
) -> List[str]:
    query = """
    SELECT
        r.resultuuid
    FROM
        ODM2.RESULTS r
        JOIN odm2.variables v ON v.variableid = r.variableid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid = sf.samplingfeatureid 
    WHERE
        sf.samplingfeaturecode = %s
        AND v.variablecode = %s
    """
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (sampling_feature_code, variable_code))
        res = cur.fetchone()
    return res["resultuuid"]


@dataclass
class TimeseriesResult:
    uuid: str
    values: List[str | int | float]
    datetime: List[datetime]


def timeseries_by_resultuuid(
    conn: psycopg2.extensions.connection,
    result_uuid: str,
    start_time: datetime,
    end_time: datetime,
) -> TimeseriesResult:
    """Query a timeserie for a given result uuid

    The timeseries is limited to start_time<t<=end_time.
    """
    query = """
    SELECT
        valuedatetime,
        datavalue
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
    WHERE
        r.resultuuid = %s
        AND tsrv.valuedatetime > %s
        AND tsrv.valuedatetime <= %s
    ORDER BY
        tsrv.valuedatetime ASC
    """
    logging.info(f"Querying timeseries for resultuuid {result_uuid}")

    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (result_uuid, start_time, end_time))
        res = cur.fetchall()
    return TimeseriesResult(
        result_uuid, values=[r["datavalue"] for r in res], datetime=[r["valuedatetime"] for r in res]
    )


@dataclass
class ProjectResult:
    projectname: str
    projectdescription: str
    projectstationname: str
    projectstationcode: str


def project_info(
    conn: psycopg2.extensions.connection,
    project_name: str,
    project_station_code: str,
) -> ProjectResult:
    query = """
    SELECT 
        p.projectname,
        p.projectdescription,
        pr.projectstationname,
        pr.projectstationcode,
    FROM odm2.projects p 
    JOIN ON p.projectid = pr.projectid
    WHERE 
        p.projectname = %s
        AND pr.projectstationcode = %s;
    """
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (project_name, project_station_code))
        res = cur.fetchone()
    return ProjectResult(**res)


def point_by_sampling_code(
    conn: psycopg2.extensions.connection,
    sampling_feature_code: str,
) -> Point:
    query = """
    SELECT 
        ST_X(sf.featuregeometry) as longitude,
        ST_Y(sf.featuregeometry) as latitude
    FROM odm2.samplingfeatures sf
    WHERE 
        sf.samplingfeaturecode = %s
    """
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (sampling_feature_code,))
        res = cur.fetchone()
    return Point(**res)


def timestamp_by_code(
    conn: psycopg2.extensions.connection,
    sampling_feature_code: str,
    variable_codes: List[str],
    is_asc: bool,
) -> Optional[datetime]:
    query = """
    SELECT
        valuedatetime
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.variables v ON v.variableid=r.variableid
    WHERE
        V.VARIABLECODE IN %s
        AND SF.SAMPLINGFEATURECODE = %s
    ORDER BY
        TSRV.VALUEDATETIME
    """
    query += "ASC" if is_asc else "DESC"
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (tuple(variable_codes), sampling_feature_code))
        res = cur.fetchone()
    return res["valuedatetime"] if res is not None else None
