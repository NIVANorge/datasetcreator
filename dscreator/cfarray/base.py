from dataclasses import asdict
from datetime import datetime
from functools import partial
from typing import Any, List, Literal, Optional, Tuple, Union

import xarray as xr

from dscreator.cfarray.attributes import VariableAttrsBase
from dscreator.cfarray.common import wgs1984
from dscreator.cfarray.dims import DEPTH, DIMLESS, TIME


def dataarray(dims: Union[Tuple, str], data: List[Any], name: str, attrs: VariableAttrsBase) -> xr.DataArray:
    return xr.DataArray(
        name=name,
        dims=dims,
        data=data,
        attrs=asdict(attrs),
    )


dataarraybytime = partial(dataarray, dims=TIME)

dataarraybydepth = partial(dataarray, dims=DEPTH)


def idarray(name: str, id: str, cf_role: str):
    attrs = {
        "cf_role": cf_role,
    }
    return xr.DataArray(id, dims=DIMLESS, name=name, attrs=attrs)


TIME_ENCODING = {"time": {"dtype": "int32", "units": "seconds since 1970-01-01 00:00:00"}}
