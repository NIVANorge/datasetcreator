from dataclasses import asdict, dataclass
from datetime import datetime
from functools import partial
from typing import List

import xarray as xr

from dataexport.cfarray.attributes import LatitudeAttrs, LongitudeAttrs, TimeAttrs
from dataexport.cfarray.base import dataset
from dataexport.cfarray.dims import DIMLESS, TIME


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
