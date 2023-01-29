import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional, Tuple

import psycopg2
from psycopg2.extras import RealDictCursor


@dataclass
class TimeseriesResult:
    variable_code: str
    values: List[str | int | float]
    datetime: List[datetime]


def timeseries_by_project(
    conn: psycopg2.extensions.connection,
    variable_code: str,
    project_name: str,
    project_station_code: str,
    start_time: datetime,
    end_time: datetime,
) -> TimeseriesResult:
    query = """
    SELECT
        valuedatetime,
        datavalue
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.variables v ON v.variableid=r.variableid
        JOIN odm2.projectstations pr ON pr.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.projects p ON p.projectid=pr.projectid
    WHERE
        V.VARIABLECODE= %s
        AND P.PROJECTNAME = %s
        AND PR.PROJECTSTATIONCODE = %s
        AND TSRV.VALUEDATETIME > %s
        AND TSRV.VALUEDATETIME <= %s
    ORDER BY
        TSRV.VALUEDATETIME ASC
    """
    logging.info(f"Querying timeseries for variable code {variable_code} on project {project_name}")

    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (variable_code, project_name, project_station_code, start_time, end_time))
        res = cur.fetchall()
    return TimeseriesResult(
        variable_code, values=[r["datavalue"] for r in res], datetime=[r["valuedatetime"] for r in res]
    )


@dataclass
class TimeseriesSamplingResult(TimeseriesResult):
    sampling_feature_code: str


def timeseries_by_sampling_code(
    conn: psycopg2.extensions.connection,
    variable_code: str,
    sampling_feature_code: str,
    start_time: datetime,
    end_time: datetime,
) -> TimeseriesSamplingResult:
    query = """
    SELECT
        valuedatetime,
        datavalue
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.variables v ON v.variableid=r.variableid
    WHERE
        V.VARIABLECODE= %s
        AND SF.SAMPLINGFEATURECODE = %s
        AND TSRV.VALUEDATETIME > %s
        AND TSRV.VALUEDATETIME <= %s
    ORDER BY
        TSRV.VALUEDATETIME ASC
    """
    logging.info(
        f"Querying timeseries for variable code {variable_code} on sampling feature code {sampling_feature_code}"
    )

    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (variable_code, sampling_feature_code, start_time, end_time))
        res = cur.fetchall()
    return TimeseriesSamplingResult(
        variable_code,
        values=[r["datavalue"] for r in res],
        datetime=[r["valuedatetime"] for r in res],
        sampling_feature_code=sampling_feature_code,
    )


@dataclass
class PointResult:
    samplingfeaturecode: str
    longitude: float
    latitude: float


@dataclass
class PointProjectResult(PointResult):
    projectname: str
    projectdescription: str
    projectstationname: str
    projectstationcode: str


def point_by_project(
    conn: psycopg2.extensions.connection,
    project_name: str,
    project_station_code: str,
) -> PointProjectResult:
    query = """
    SELECT 
        p.projectname,
        p.projectdescription,
        pr.projectstationname,
        pr.projectstationcode,
        sf.samplingfeaturecode,
        ST_X(featuregeometry) as longitude,
        ST_Y(featuregeometry) as latitude
    FROM odm2.samplingfeatures sf
        JOIN odm2.projectstations pr ON pr.samplingfeatureid = sf.samplingfeatureid
        JOIN odm2.projects P ON p.projectid = pr.projectid
    WHERE 
        p.projectname = %s
        AND pr.projectstationcode = %s;
    """
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (project_name, project_station_code))
        res = cur.fetchone()
    return PointProjectResult(**res)


def point_by_sampling_code(
    conn: psycopg2.extensions.connection,
    sampling_feature_code: str,
) -> PointResult:
    query = """
    SELECT 
        sf.samplingfeaturecode,
        ST_X(sf.featuregeometry) as longitude,
        ST_Y(sf.featuregeometry) as latitude
    FROM odm2.samplingfeatures sf
    WHERE 
        sf.samplingfeaturecode = %s
    """
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (sampling_feature_code,))
        res = cur.fetchone()
    return PointResult(**res)


def timestamp_by_project(
    conn: psycopg2.extensions.connection,
    variable_codes: List[str],
    project_name: str,
    project_station_code: str,
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
        JOIN odm2.projectstations pr ON pr.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.projects p ON p.projectid=pr.projectid
    WHERE
        V.VARIABLECODE IN %s
        AND P.PROJECTNAME = %s
        AND PR.PROJECTSTATIONCODE = %s
    ORDER BY
        TSRV.VALUEDATETIME
    """
    query += "ASC" if is_asc else "DESC"
    with conn, conn.cursor(cursor_factory=RealDictCursor) as cur:
        cur.execute(query, (tuple(variable_codes), project_name, project_station_code))
        res = cur.fetchone()
    return res["valuedatetime"] if res is not None else None


def timestamp_by_sampling_code(
    conn: psycopg2.extensions.connection,
    variable_codes: List[str],
    sampling_feature_code: str,
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
