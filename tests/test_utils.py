from datetime import datetime
import numpy as np

from dataexport import utils


def test_numpy_to_datetime():
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "s")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "us")) == datetime(2019, 8, 26)
    assert utils.numpy_to_datetime(np.datetime64("2019-08-26T00:00:00.00", "ns")) == datetime(2019, 8, 26)
