import logging
import os
import sys
from datetime import datetime, timedelta

import typer
import xarray as xr
import numpy as np

from dataexport.config import DATABASE_URL, THREDDS_DATASET_URL
from dataexport.datasets import sios
from dataexport.cfarray.base import DEFAULT_ENCODING
from dataexport import utils


app = typer.Typer()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)


@app.command()
def sios_update_thredds():
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf
    """

    logging.info("Exporting SIOS dataset")

    dataset_name = "sios"

    start_time = xr.open_dataset(f"{THREDDS_DATASET_URL}/{dataset_name}.nc").time.values[-1]
    start_time = utils.numpy_to_datetime(start_time)
    end_time = datetime.now()

    ds = sios.dump(start_time, end_time)

    first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s")
    filename = f"{first_timestamp}_{dataset_name}.nc"
    ds.to_netcdf(filename, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)


if __name__ == "__main__":
    app()
