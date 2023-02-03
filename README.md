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

### Adding New Datasets

Add an `app` to [main.py](./dataexport/main.py), that contains:

- An `extractor` subclassed from `BaseExtractor` in [sources/base.py](./dataexport/sources/base.py). For example see [TimeseriesExtractor](./dataexport/sources/odm2/extractor.py)
- A dataset builder subclassed from the appropriate class in [datasets/base.py](./dataexport/datasets/base.py). For example see [MSourceInletBuilder](./dataexport/datasets/timeseries/msource.py)



## Viewing datasets

A local `thredds` server that reads the files can be started using docker

```base
docker compose up
```

and accesses on http://localhost/thredds/catalog/catalog.html. 

### Configuring the view

The local catalog config file can be found in [catalog.xml](./catalog/catalog.xml). Documentation for working with this configuration file can be found [here](https://docs.unidata.ucar.edu/tds/current/userguide/basic_config_catalog.html). The ncml [documentation](https://docs.unidata.ucar.edu/netcdf-java/current/userguide/basic_ncml_tutorial.html) can also be useful.


## Working with netCDF

For most things [xarray](https://docs.xarray.dev/en/stable/) is a good choice. The command-line tool [ncdump](https://www.unidata.ucar.edu/software/netcdf/workshops/2011/utilities/Ncdump.html) is also quite nice for small things.