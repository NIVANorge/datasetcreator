from pydantic import BaseSettings
from typing import Annotated
from pydantic import Field


class Settings(BaseSettings):
    db_user: str
    db_host: str
    db_port: int = 5432
    thredds_url: str
    storage_path: Annotated[
        str, Field(description="A local storage path, or a gcs storage path", example="gs://nivatest-1-senda/datasets")
    ] = "./catalog"

    class Config:
        case_sensitive = False
        env_file = ".env"


SETTINGS = Settings()
THREDDS_DATASET_URL = f"{SETTINGS.thredds_url}/thredds/dodsC/datasets"
DATABASE_URL = f"postgresql:///odm2?host={SETTINGS.db_host}&port={SETTINGS.db_port}&user={SETTINGS.db_user}"
