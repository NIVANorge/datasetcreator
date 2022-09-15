import typer
import psycopg2
import os

from dataexport.odm2.queries import timeseries, timeseries_metadata
from dataexport.cfarray.base import dataarraybytime, DEFAULT_ENCODING
from dataexport.cfarray.time_series import timeseriescoords, timeseriesdataset
from dataexport.datasets import sios
from functools import partial
from datetime import datetime, timedelta

app = typer.Typer()

DATABASE_URL = f'postgresql:///odm2?host=localhost&port=5432&user={os.environ["DB_USER"]}'


@app.command()
def sios_export():
    """Export sios data from odm2 to netcdf

    Map odm2 data into climate & forecast convention
    and store the data as netcdf
    """
    conn = psycopg2.connect(DATABASE_URL)
    start_time = datetime.now() - timedelta(days=2)
    end_time = datetime.now()
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
            "OxygenCon",
            "OxygenSat",
            "RawBackScattering",
            "fDOM",
        ],
    )

    project_metadata = timeseries_metadata(conn, project_name=project_name, project_station_code=project_station_code)

    dataarrays = map(lambda qr: sios.cfdataarray(qr, project_metadata), query_results)


if __name__ == "__main__":
    app()
