from dataclasses import asdict, dataclass
from datetime import datetime
from typing import List

import xarray as xr

from dscreator.cfarray.attributes import LatitudeAttrs, LongitudeAttrs, TimeAttrs
from dscreator.cfarray.base import idarray
from dscreator.cfarray.dims import TIME


@dataclass
class TrajectoryCoord:
    time: xr.Variable
    longitude: xr.Variable
    latitude: xr.Variable


def trajectorycoords(
    time: List[datetime],
    longitude: List[float],
    latitude: List[float],
):
    return asdict(
        TrajectoryCoord(
            time=xr.Variable(TIME, time, asdict(TimeAttrs())),
            longitude=xr.Variable(TIME, longitude, asdict(LongitudeAttrs())),
            latitude=xr.Variable(TIME, latitude, asdict(LatitudeAttrs())),
        )
    )


def trajectorydataset(named_dataarrays: List[xr.DataArray], trajectory_name: str) -> xr.Dataset:
    """Trajectory dataset"""
    feature_type = "trajectory"
    ds = xr.merge(named_dataarrays + [idarray(feature_type + "_name", trajectory_name, feature_type + "_id")])

    ds.attrs = {"featureType": feature_type}
    return ds