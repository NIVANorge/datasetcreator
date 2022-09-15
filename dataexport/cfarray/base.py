from dataclasses import asdict
from datetime import datetime
from functools import partial
from typing import Any, List, Literal, Tuple, Union

import xarray as xr

from dataexport.cfarray.attributes import DatasetAttrs, VariableAttrs
from dataexport.cfarray.common import wgs1984
from dataexport.cfarray.dims import DEPTH, DIMLESS, TIME


def dataarray(
    dims: Union[Tuple, str],
    data: List[Any],
    name: str,
    standard_name: str,
    long_name: str,
    units: str,
) -> xr.DataArray:
    return xr.DataArray(
        name=name,
        dims=dims,
        data=data,
        attrs=asdict(
            VariableAttrs(
                standard_name=standard_name,
                long_name=long_name,
                units=units,
            )
        ),
    )


dataarraybytime = partial(dataarray, dims=TIME)

dataarraybydepth = partial(dataarray, dims=DEPTH)


def idarray(name: str, id: str, cf_role: str):
    attrs = {
        "cf_role": cf_role,
    }
    return xr.DataArray(id, dims=DIMLESS, name=name, attrs=attrs)


def dataset(
    feature_type: Literal["timeseries", "trajectory", "profile"],
    id_name: str,
    named_dataarrays: List[xr.DataArray],
    id: str,
    title: str,
    summary: str,
    project: str,
    keywords: List[str],
):
    ds = xr.merge(named_dataarrays + [idarray(id_name, id, feature_type + "_id")])

    ds.attrs = asdict(
        DatasetAttrs(
            title=title,
            summary=summary,
            date_created=str(datetime.now()),
            keywords=keywords,
            project=project,
            time_coverage_start=str(ds.time.min().values),
            time_coverage_end=str(ds.time.max().values),
            geospatial_lat_min=float(ds.latitude.min()),
            geospatial_lat_max=float(ds.latitude.max()),
            geospatial_lon_min=float(ds.longitude.min()),
            geospatial_lon_max=float(ds.longitude.max()),
            featureType=feature_type,
        )
    )
    return ds


DEFAULT_ENCODING = {"time": {"dtype": "int32", "units": "seconds since 1970-01-01 00:00:00"}}
