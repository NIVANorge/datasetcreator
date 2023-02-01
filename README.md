# Dataexport

A small program to create Climate and forecast datasets with xarray and save to various formats.

## Local development

See [config.py](./dataexport/config.py) for enviroment variables and add them to the `.env` file.
If using your own gcloud account you can export the credentials with this command

```bash
export PGPASSWORD=$(gcloud auth print-access-token)
```

The different datasets can be created by running the export commands, for example

```bash
poetry run dataexport sios --start-from-scratch --stop-after-n-files 2
# or
poetry run dataexport msource-inlet --start-from-scratch --stop-after-n-files 1 --acdd
# or
poetry run dataexport msource-outlet --start-from-scratch --stop-after-n-files 2 --acdd
```

by default if the `.env` variable `STORAGE_PATH` is not set this will export locally to the `./catalog` folder.

A local `thredds` server that reads these files can be started using docker

```base
docker compose up
```

and server is available on http://localhost/thredds/catalog/catalog.html
