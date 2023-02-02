# Dataexport

A small program to create Climate and forecast datasets with xarray and save to various formats.

## Local development

See [config.py](./dataexport/config.py) for enviroment variables and add them to the `.env` file.
If not passing the password in the database URI you can also use

```bash
export PGPASSWORD="MY ACCESS TOKEN"
```

The different datasets can be created by running the export commands, for example

## Creating datasets

The different entrypoints can be listed with `poetry run dataexport --help`, for example

```bash
poetry run dataexport sios --start-from-scratch --stop-after-n-files 2
# or
poetry run dataexport msource-inlet --start-from-scratch --stop-after-n-files 1 --acdd
# or
poetry run dataexport msource-outlet --start-from-scratch --stop-after-n-files 2 --acdd
```

by default data will be saved to the `./catalog` folder, setting the enviroment variable `STORAGE_PATH` changes this.

## Viewing datasets

A local `thredds` server that reads these files can be started using docker

```base
docker compose up
```

and accesses on http://localhost/thredds/catalog/catalog.html. 

## Configuring datasets

The local catalog config file can be found in [catalog.xml](./catalog/catalog.xml). Documentation for working with this configuration file can be found [here](https://docs.unidata.ucar.edu/tds/current/userguide/basic_config_catalog.html). The [ncml](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/basic_ncml_tutorial.html) documentation can also be useful.
