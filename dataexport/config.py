from pydantic import BaseSettings

class Settings(BaseSettings):
    db_user: str
    db_host: str
    thredds_url: str

    class Config:
        case_sensitive = False
        env_file = ".env"

