import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional

from sqlalchemy import Engine
from sqlalchemy.sql import text

from dataexport.sources.base import Point


def resultuuids_by_code(engine: Engine, sampling_feature_code: str, variable_code: str) -> str:
    query = text(
        """
    SELECT
        r.resultuuid
    FROM
        ODM2.RESULTS r
        JOIN odm2.variables v ON v.variableid = r.variableid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid = sf.samplingfeatureid 
    WHERE
        sf.samplingfeaturecode = :sampling_feature_code
        AND v.variablecode = :variable_code
    """
    ).bindparams(sampling_feature_code=sampling_feature_code, variable_code=variable_code)
    with engine.connect() as conn:
        res = conn.execute(query).fetchone()
    return str(res[0])


@dataclass
class TimeseriesResult:
    uuid: str
    values: List[str | int | float]
    datetime: List[datetime]


def timeseries_by_resultuuid(
    engine: Engine,
    result_uuid: str,
    start_time: datetime,
    end_time: datetime,
) -> TimeseriesResult:
    """Query a timeserie for a given result uuid

    The timeseries is limited to start_time<t<=end_time.
    """
    query = text(
        """
    SELECT
        valuedatetime,
        datavalue
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
    WHERE
        r.resultuuid = :result_uuid
        AND tsrv.valuedatetime > :start_time
        AND tsrv.valuedatetime <= :end_time
    ORDER BY
        tsrv.valuedatetime ASC
    """
    ).bindparams(result_uuid=result_uuid, start_time=start_time, end_time=end_time)

    logging.info(f"Querying timeseries for resultuuid {result_uuid}")

    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().all()
    return TimeseriesResult(
        result_uuid, values=[r["datavalue"] for r in res_dict], datetime=[r["valuedatetime"] for r in res_dict]
    )


@dataclass
class ProjectResult:
    projectname: str
    projectdescription: str
    projectstationname: str
    projectstationcode: str


def project_info(
    engine: Engine,
    project_name: str,
    project_station_code: str,
) -> ProjectResult:
    query = text(
        """
    SELECT 
        p.projectname,
        p.projectdescription,
        ps.projectstationname,
        ps.projectstationcode
    FROM odm2.projects p 
        JOIN odm2.projectstations ps ON ps.projectid = p.projectid
    WHERE 
        p.projectname = :project_name
        AND ps.projectstationcode = :project_station_code;
    """
    ).bindparams(project_name=project_name, project_station_code=project_station_code)
    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    return ProjectResult(**res_dict)


def point_by_sampling_code(
    engine: Engine,
    sampling_feature_code: str,
) -> Point:
    query = text(
        """
    SELECT 
        ST_X(sf.featuregeometry) as longitude,
        ST_Y(sf.featuregeometry) as latitude
    FROM odm2.samplingfeatures sf
    WHERE 
        sf.samplingfeaturecode = :sampling_feature_code
    """
    ).bindparams(sampling_feature_code=sampling_feature_code)
    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    return Point(**res_dict)


def timestamp_by_code(
    engine: Engine,
    sampling_feature_code: str,
    variable_codes: List[str],
    is_asc: bool,
) -> Optional[datetime]:
    query_str = """
    SELECT
        valuedatetime
    FROM
        odm2.timeseriesresultvalues tsrv
        JOIN odm2.results r ON r.resultid = tsrv.resultid
        JOIN odm2.featureactions f ON f.featureactionid = r.featureactionid
        JOIN odm2.samplingfeatures sf ON f.samplingfeatureid=sf.samplingfeatureid 
        JOIN odm2.variables v ON v.variableid=r.variableid
    WHERE
        V.VARIABLECODE IN :variable_codes
        AND SF.SAMPLINGFEATURECODE = :sampling_feature_code
    ORDER BY
        TSRV.VALUEDATETIME
    """
    query_str += "ASC LIMIT 1" if is_asc else "DESC LIMIT 1"
    query = text(query_str).bindparams(
        variable_codes=tuple(variable_codes), sampling_feature_code=sampling_feature_code
    )
    with engine.connect() as conn:
        res = conn.execute(query)
        res_dict = res.mappings().one()
    return res_dict["valuedatetime"]
