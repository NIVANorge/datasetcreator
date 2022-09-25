import logging
import os
import sys
from datetime import datetime, timedelta
from functools import partial

import numpy as np
import psycopg2
import typer

from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.cfarray.base import DEFAULT_ENCODING
from dataexport.datasets import sios
from dataexport.odm2.queries import timeseries, timeseries_metadata
from config import Settings

app = typer.Typer()

DATABASE_URL = f'postgresql:///odm2?host=localhost&port=5432&user={Settings.db_user}'

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stdout)],
)


@app.command()
def sios_export():
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf
    """

    logging.info("Exporting SIOS dataset")

    conn = psycopg2.connect(DATABASE_URL)
    start_time = datetime.now() - timedelta(days=6)
    end_time = datetime.now() - timedelta(days=4)
    project_name = "SIOS"
    project_station_code = "20"

    query_by_time = partial(
        timeseries,
        conn=conn,
        project_name=project_name,
        project_station_code=project_station_code,
        start_time=start_time,
        end_time=end_time,
    )

    query_results = map(
        lambda vc: query_by_time(variable_code=vc),
        [
            "Temp",
            "Turbidity",
            "Salinity",
            "ChlaValue",
            "CondValue",
            #"OxygenCon",
            #"OxygenSat",
            #"RawBackScattering",
            #"fDOM",
        ],
    )

    project_metadata = timeseries_metadata(conn, project_name=project_name, project_station_code=project_station_code)

    dataarrays = map(lambda qr: sios.cfdataarray(qr, project_metadata), query_results)

    ds = timeseriesdataset(
        named_dataarrays=list(dataarrays),
        id=project_metadata.projectstationname,
        title="SIOS sensor buoy in Adventfjorden",
        summary=project_metadata.projectdescription,
        keywords=[
            "Water-based Platforms > Buoys > Moored > BUOYS",
            "EARTH SCIENCE > Oceans > Salinity/Density > Salinity",
        ],
        project=project_metadata.projectname,
    )

    first_timestamp = np.datetime_as_string(ds.time[0], timezone="UTC", unit="s")
    filename = f"{first_timestamp}_{project_name}.nc"
    ds.to_netcdf(filename, unlimited_dims=["time"], encoding=DEFAULT_ENCODING)

    logging.info("Finished")


if __name__ == "__main__":
    app()
