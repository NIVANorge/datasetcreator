import xarray as xr
from typing import Dict

TIME_ENCODING =  {"dtype": "int32", "units": "seconds since 1970-01-01 00:00:00"}
COORD_ENCODING = {'zlib': False, '_FillValue': None}
INT_ENCODING = {"dtype": "int16", "scale_factor": 0.1,'_FillValue': -9999}

def default_encoding(ds: xr.Dataset) -> Dict:
    """Return default encoding
    
    C&F should not have fill value in coords and thredds does not like int64
    """
    enc = {}

    for c in ds.coords:
        enc[c] = dtype_to_encoding(str(ds[c].dtype))
        enc[c].update(COORD_ENCODING)

    for v in ds.data_vars:
        enc[v] = dtype_to_encoding(str(ds[v].dtype))
        if "flag_values" in ds[v].attrs:
            enc[v] = INT_ENCODING

    
    return enc

def dtype_to_encoding(dtype_str: str):
    match dtype_str:
        case "datetime64[ns]":
            return TIME_ENCODING
        case "int64":
            return INT_ENCODING
        case _:
            return {}