from dataclasses import asdict, dataclass
from datetime import datetime
from functools import partial
from typing import List

import xarray as xr

from dataexport.cfarray.attributes import DepthAttrs, LatitudeAttrs, LongitudeAttrs, TimeAttrs
from dataexport.cfarray.base import dataset
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


profiledataset = partial(dataset, "profile", "profile_name")
