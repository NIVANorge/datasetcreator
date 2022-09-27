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


DEFAULT_ENCODING = {"time": {"dtype": "int32", "units": "seconds since 1970-01-01 00:00:00"}}
