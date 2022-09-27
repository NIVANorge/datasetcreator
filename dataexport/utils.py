import numpy as np
from datetime import datetime


def numpy_to_datetime(dt: np.datetime64) -> datetime:
    """convert ns numpy.datetime64 to datetime"""
    return datetime.utcfromtimestamp(dt.astype(int) / 1e9)
