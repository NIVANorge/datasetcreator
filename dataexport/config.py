from typing import Annotated, Optional

from pydantic import BaseSettings, Field, validator


class Settings(BaseSettings):
    # postgresql:///odm2?host=timescale-db&port=5432&user=postgres&password=postgres
    database_url: str
    # gs://nivatest-1-senda
    storage_path: str = "./catalog"
    thredds_url: str
    @property
    def thredds_dataset_url(self):
        return f"{self.thredds_url}/thredds/dodsC/datasets"
    class Config:
        case_sensitive = False
        env_file = ".env"

SETTINGS = Settings()
