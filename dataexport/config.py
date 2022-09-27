from pydantic import BaseSettings


class Settings(BaseSettings):
    db_user: str
    db_host: str
    thredds_url: str

    class Config:
        case_sensitive = False
        env_file = ".env"


SETTINGS = Settings()
THREDDS_DATASET_URL = f"{SETTINGS.thredds_url}/thredds/dodsC/datasets"
DATABASE_URL = f"postgresql:///odm2?host=localhost&port=5432&user={SETTINGS.db_user}"
