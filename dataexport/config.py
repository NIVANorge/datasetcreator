from pydantic import BaseSettings

class Settings(BaseSettings):
    db_user: str
    db_host: str
    thredds_server: str

    class Config:
        case_sensitive = False
        env_file = ".env"

