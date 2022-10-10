import logging
import os
import sys
from datetime import datetime, timedelta

import typer
import xarray as xr
import psycopg2
import numpy as np

from dataexport.config import DATABASE_URL, THREDDS_DATASET_URL
from dataexport.datasets import sios
from dataexport.cfarray.base import DEFAULT_ENCODING
from dataexport import thredds
from dataexport.config import DATABASE_URL


app = typer.Typer()

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)


@app.command()
def sios_dump():
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf.
    """

    logging.info("Exporting SIOS dataset")

    dataset_name = "sios"

    start_time = thredds.end_time(dataset_name)
    end_time = datetime.now()

    conn = psycopg2.connect(DATABASE_URL)
    ds = sios.dump(conn, start_time, end_time)
    conn.close()

    first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s")
    filename = f"{first_timestamp}_{dataset_name}.nc"
    ds.to_netcdf(filename, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

    logging.info(f"Data {ds.time[0]} --> {ds.time[-1]} exported")


if __name__ == "__main__":
    app()
