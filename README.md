# Dataexport

A small program to create Climate and forecast datasets with xarray and save to various formats, currently netcdf.

## Local development

See [config.py](./dataexport/config.py) for enviroment variables and add them to the `.env` file.
If not passing the password in the database URI you can also use

```bash
export PGPASSWORD="MY ACCESS TOKEN"
```

## Creating datasets

The different entrypoints can be listed with `poetry run dataexport --help`. By default data will be saved to the `./catalog` folder, setting the enviroment variable `STORAGE_PATH` changes this. The program will restart from the last point in time using a restart file from the give storage location.

### Examples

```bash
poetry run dataexport sios --stop-after-n-files 2
# or
poetry run dataexport msource-inlet --stop-after-n-files 1 --acdd
# or
poetry run dataexport msource-outlet --max-time-slice 240 --stop-after-n-files 2 --acdd
```



## Viewing datasets

A local `thredds` server that reads the files can be started using docker

```base
docker compose up
```

and accesses on http://localhost/thredds/catalog/catalog.html. 

### Configuring the view

The local catalog config file can be found in [catalog.xml](./catalog/catalog.xml). Documentation for working with this configuration file can be found [here](https://docs.unidata.ucar.edu/tds/current/userguide/basic_config_catalog.html). The [ncml](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/basic_ncml_tutorial.html) documentation can also be useful.
