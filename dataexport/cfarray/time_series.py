from typing import List

from datetime import datetime

import xarray as xr

from dataexport.cfarray.attributes import (
    LatitudeAttrs,
    LongitudeAttrs,
    TimeAttrs,
)
from dataclasses import asdict, dataclass
from dataexport.cfarray.dims import TIME, DIMLESS
from functools import partial
from dataexport.cfarray.base import dataset


@dataclass
class TimeSeriesCoord:
    time: xr.Variable
    longitude: xr.Variable
    latitude: xr.Variable


def timeseriescoords(
    time: List[datetime],
    longitude: float,
    latitude: float,
):
    return asdict(
        TimeSeriesCoord(
            time=xr.Variable(TIME, time, asdict(TimeAttrs())),
            longitude=xr.Variable(DIMLESS, longitude, asdict(LongitudeAttrs())),
            latitude=xr.Variable(DIMLESS, latitude, asdict(LatitudeAttrs())),
        )
    )


timeseriesdataset = partial(dataset, feature_type="timeseries", id_name="station_name")
