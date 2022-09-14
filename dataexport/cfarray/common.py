from dataclasses import dataclass, asdict

import numpy as np
import xarray as xr
from dataexport.cfarray.dims import DIMLESS


@dataclass
class WGS1984Attrs:
    grid_mapping_name: str = "latitude_longitude"
    longitude_of_prime_meridian: str = 0.0
    semi_major_axis: str = 6378137.0
    inverse_flattening: str = 298.257223563


def wgs1984() -> xr.DataArray:
    return xr.DataArray(name="crs", data=0, dims=DIMLESS, attrs=asdict(WGS1984Attrs()))
