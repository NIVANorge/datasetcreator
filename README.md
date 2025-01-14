# Datasetcreator

A program to create Climate and Forecast datasets with xarray.

## Local Development

To get started, run:

```bash
poetry install
```

Then, for local development, set the variable:

```.env
DATABASE_URL=postgresql:///{DATABASE}?host={HOST}&port=5432&user={USERNAME}
```

in your `.env` file or pass the password in the database URL. You can also export the password outside the `.env` file using:

```bash
export  ODM2_CONNECTION_STR=$(gcloud auth print-access-token)
```

Also, see [config.py](./dscreator/config.py), note that for ferrybox you can set the password in the `TSB_CONNECTION_STR` variable in your `.env` file. 

### Testing

A local static database for tests can be found [here](./tests/data/README.md). Run the tests with:

```bash
poetry run pytest .
```

To skip Docker tests, use:

```bash
poetry run pytest -m "not docker" .
```

## Creating Datasets

The different entry points can be listed with:

```bash
poetry run dscreator --help
```

By default, data will be saved to the `./catalog` folder. This can be changed using the environment variable `STORAGE_PATH`. The program uses a restart file from the given storage location to create new slices in time.

### Examples

```bash
poetry run dscreator sios --stop-after-n-files 2
# or
poetry run dscreator msource-inlet --stop-after-n-files 1 --acdd yes
# or
poetry run dscreator msource-outlet --max-time-slice 240 --stop-after-n-files 2 --acdd ncml
```

### Adding New Datasets

For dynamic datasets, add an `app` to [main.py](./dscreator/main.py) that contains:

- An `extractor`, subclassed from `BaseExtractor` in [sources/base.py](./dscreator/sources/base.py). See [TimeseriesExtractor](./dscreator/sources/odm2/extractor.py).
- A dataset builder, subclassed from the appropriate class in [datasets/base.py](./dscreator/datasets/base.py). See [MSourceInletBuilder](./dscreator/datasets/timeseries/msource.py).

It is also possible to use a notebook, as done for [exceedence_limits.ipynb](notebooks/exceedence_limits.ipynb).

## Viewing Datasets

A local `thredds` server that reads the files can be started using Docker:

```bash
docker compose up
```

and accessed at http://localhost/thredds/catalog/catalog.html.

### Configuring a catalog

The local catalog config file can be found in [catalog.xml](./catalog/catalog.xml). Documentation for working with this configuration file can be found [here](https://docs.unidata.ucar.edu/tds/current/userguide/basic_config_catalog.html). The ncml [documentation](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/basic_ncml_tutorial.html) is also useful.

## Working with netCDF

For most tasks, [xarray](https://docs.xarray.dev/en/stable/) is a good choice. The command-line tool [ncdump](https://www.unidata.ucar.edu/software/netcdf/workshops/2011/utilities/Ncdump.html) is also useful for small tasks.
 