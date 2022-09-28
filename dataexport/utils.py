import numpy as np
from datetime import datetime


def numpy_to_datetime(dt: np.datetime64) -> datetime:
    """convert ns numpy.datetime64 to datetime"""
    match dt.dtype:
        case 'datetime64[s]':
            factor = 1
        case 'datetime64[us]':
            factor = 1e6
        case 'datetime64[ns]':
            factor = 1e9
    return datetime.utcfromtimestamp(dt.astype(int) / factor)
