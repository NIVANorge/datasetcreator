from typing import Annotated, Optional

from pydantic import BaseSettings, Field, validator


class Settings(BaseSettings):
    db_name: str
    db_user: str
    db_host: str
    db_port: int = 5432
    thredds_url: str
    storage_path: Annotated[
        str, Field(description="A local storage path, or a gcs storage path", example="gs://nivatest-1-senda")
    ] = "./catalog"
    db_password: Optional[str]
    database_url: Optional[str]

    @property 
    def database_url(self):
        database_url = f"postgresql:///{self.db_name}?host={self.db_host}&port={self.db_port}&user={self.db_user}"
        if self.db_password is not None:
            database_url+=f"&password={self.db_password}"
        return database_url

    @property
    def thredds_dataset_url(self):
        return f"{self.thredds_url}/thredds/dodsC/datasets"
    class Config:
        case_sensitive = False
        env_file = ".env"

SETTINGS = Settings()
