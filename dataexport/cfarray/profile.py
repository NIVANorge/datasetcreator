from datetime import datetime
import xarray as xr

from dataexport.cfarray.attributes import (
    LatitudeAttrs,
    LongitudeAttrs,
    DepthAttrs,
    TimeAttrs,
)
from typing import List
from dataclasses import asdict, dataclass
from functools import partial
from dataexport.cfarray.dims import DEPTH, DIMLESS
from dataexport.cfarray.base import dataset

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
