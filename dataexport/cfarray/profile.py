from dataclasses import asdict, dataclass
from datetime import datetime
from functools import partial
from typing import List

import xarray as xr

from dataexport.cfarray.attributes import DepthAttrs, LatitudeAttrs, LongitudeAttrs, TimeAttrs
from dataexport.cfarray.base import idarray
from dataexport.cfarray.dims import DEPTH, DIMLESS


@dataclass
class DepthCoords:
    depth: xr.Variable
    time: xr.Variable
    longitude: xr.Variable
    latitude: xr.Variable


def depthcoords(
    depth: List[float],
    time: datetime,
    longitude: float,
    latitude: float,
):
    return asdict(
        DepthCoords(
            depth=xr.Variable(DEPTH, depth, asdict(DepthAttrs())),
            time=xr.Variable(DIMLESS, time, asdict(TimeAttrs())),
            longitude=xr.Variable(DIMLESS, longitude, asdict(LongitudeAttrs())),
            latitude=xr.Variable(DIMLESS, latitude, asdict(LatitudeAttrs())),
        )
    )


def profiledataset(named_dataarrays: List[xr.DataArray], title: str, profile_name: str) -> xr.Dataset:

    feature_type = "profile"
    ds = xr.merge(named_dataarrays + [idarray(feature_type + "_name", profile_name, feature_type + "_id")])

    ds.attrs = {"title": title, "featureType": feature_type}
    return ds
