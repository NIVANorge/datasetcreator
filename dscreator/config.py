from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # postgresql:///odm2?host=timescale-db&port=5432&user=postgres&password=postgres
    odm2_connection_str: str = ""
    tsb_connection_str: str = ""
    # gs://nivatest-1-senda
    storage_path: str = "./catalog"

    class Config:
        case_sensitive = False
        env_file = ".env"


SETTINGS = Settings()
