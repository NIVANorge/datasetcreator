import xarray as xr
from datetime import datetime
from dscreator.encoding import default_encoding


def test_default_encoding():
    ds = xr.Dataset(
        data_vars=dict(
            fvalues=(["time"], [4.5, 7.5]),
            ivalue=(["time"], [1, 2]),
        ),
        coords=dict(
            time=[datetime(2021, 1, 1), datetime(2021, 1, 2)],
        ),
    )
    enc = default_encoding(ds)

    assert enc["time"]["dtype"] == "int32"
    assert enc["time"]["units"] == "seconds since 1970-01-01 00:00:00"
    assert enc["ivalue"]["dtype"] == "int16"
