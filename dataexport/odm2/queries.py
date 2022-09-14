from datetime import datetime
from typing import List, NamedTuple

import psycopg2
from psycopg2.extras import NamedTupleCursor
from dataclasses import dataclass


@dataclass
class TimeseriesResult:
    variable_code: str
    values: List[str | int | float]
    datetime: List[datetime]


def timeseries(
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
    with conn, conn.cursor(cursor_factory=NamedTupleCursor) as cur:
        cur.execute(query, (variable_code, project_name, project_station_code, start_time, end_time))
        res = cur.fetchall()
    return TimeseriesResult(variable_code, values=[r.datavalue for r in res], datetime=[r.valuedatetime for r in res])


def timeseries_metadata(
    conn: psycopg2.extensions.connection,
    project_name: str,
    project_station_code: str,
) -> NamedTuple:
    query = """
    SELECT 
        p.projectname,
        p.projectdescription,
        pr.projectstationname,
        ST_X(featuregeometry) as lon,
        ST_Y(featuregeometry) as lat
    FROM odm2.samplingfeatures sf
        JOIN odm2.projectstations pr ON pr.samplingfeatureid = sf.samplingfeatureid
        JOIN odm2.projects P ON p.projectid = pr.projectid
    WHERE 
        p.projectname = %s
        AND pr.projectstationcode = %s;
    """
    with conn, conn.cursor(cursor_factory=NamedTupleCursor) as cur:
        cur.execute(query, (project_name, project_station_code))
        res = cur.fetchone()
    return res
