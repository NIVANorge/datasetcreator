import logging
from dataclasses import dataclass
from datetime import datetime
from functools import partial
from typing import List

from psycopg2.extensions import connection

from dataexport.sources.odm2.queries import (
    TimeseriesResult,
    ResultVariableMap,
    point_by_sampling_code,
    resultuuids_by_code,
    timeseries_by_resultuuid,
)


def resultuuids(conn: connection, sampling_feature_code: str, variable_codes: List[str]) -> List[str]:
    return [resultuuids_by_code(conn, sampling_feature_code, vc) for vc in variable_codes]


@dataclass
class NamedTimeseries:
    variable_name: str
    values: List[str | int | float]
    datetime: List[datetime]


def timeseries(
    conn: connection,
    result_variable_list: List[ResultVariableMap],
    start_time: datetime,
    end_time: datetime,
) -> List[NamedTimeseries]:
    """Create a Timeseries from ODM2

    Create a timeseries from ODM2 based on samlingfeaturecode and variable code
    limit to start and end time.
    """
    query_by_resultid = partial(
        timeseries_by_resultuuid,
        conn=conn,
        start_time=start_time,
        end_time=end_time,
    )

    named_timeseries = []
    for rv in result_variable_list:
        res = query_by_resultid(result_uuid=rv.resultuuid)
        named_timeseries.append(NamedTimeseries(rv.variablecode, res.values, res.datetime))

    return named_timeseries
