# Dataset Creator

A program to create Climate and Forecast datasets with xarray.

## Local development

To get started run

```bash
poetry install
```

then for local development set the varible

```.env
DATABASE_URL=postgresql:///{DATABASE}?host={HOST}&port=5432&user={USERNAME}
```

in your `.env` file or pass the password in the database URL, you can also export the password outside the `.env` file with

```bash
export PGPASSWORD="MY ACCESS TOKEN"
```

also see [config.py](./dscreator/config.py)

### Testing

A local static database for tests can be found [here](./tests/data/README.md). Run the tests with

```bash
poetry run pytest .
```

To skip docker tests use

```bash
poetry run pytest -m "not docker" .
```

## Creating datasets

The different entrypoints can be listed with `poetry run dscreator --help`. By default data will be saved to the `./catalog` folder, this is changed using the enviroment variable `STORAGE_PATH`. The program uses a restart file from the give storage location to create new slices in time.

### Examples

```bash
poetry run dscreator sios --stop-after-n-files 2
# or
poetry run dscreator msource-inlet --stop-after-n-files 1 --acdd
# or
poetry run dscreator msource-outlet --max-time-slice 240 --stop-after-n-files 2 --acdd
```

### Adding New Datasets

For dynamic datasets add an `app` to [main.py](./dscreator/main.py), that contains:

- An `extractor`, subclassed from `BaseExtractor` in [sources/base.py](./dscreator/sources/base.py), see [TimeseriesExtractor](./dscreator/sources/odm2/extractor.py)
- A dataset builder, subclassed from the appropriate class in [datasets/base.py](./dscreator/datasets/base.py), see [MSourceInletBuilder](./dscreator/datasets/timeseries/msource.py)

It is also possible to use a notebook, as done for [exceedence_limits.ipynb](notebooks/exceedence_limits.ipynb).

## Viewing datasets

A local `thredds` server that reads the files can be started using docker

```base
docker compose up
```

and accessed on http://localhost/thredds/catalog/catalog.html.

### Configuring the view

The local catalog config file can be found in [catalog.xml](./catalog/catalog.xml). Documentation for working with this configuration file can be found [here](https://docs.unidata.ucar.edu/tds/current/userguide/basic_config_catalog.html). The ncml [documentation](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/basic_ncml_tutorial.html) is also useful.

## Working with netCDF

For most things [xarray](https://docs.xarray.dev/en/stable/) is a good choice. The command-line tool [ncdump](https://www.unidata.ucar.edu/software/netcdf/workshops/2011/utilities/Ncdump.html) is also quite nice for small things.

### Ferrybox datasets

Update DATABASE_URL .env with tsb credentials on nivatest-1 cluster. Use host=localhost and
port-forward to access timescaledb: kubectl port-forward timescale-0 8505:5432.
Create test dataset for Color Fantasy:

```bash
poetry run dscreator rt-ferrybox-fa --stop-after-n-files 1 --acdd
```
