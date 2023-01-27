from dataclasses import dataclass
from typing import List
from datetime import datetime


@dataclass
class __ExportSettings:
    uuid: str
    title: str
    project_name: str
    variable_codes: List[str]
    filename: str


@dataclass
class ProjectExport(__ExportSettings):
    project_station_code: str


@dataclass
class SamplingExport(__ExportSettings):
    station_name: str
    sampling_feature_code: str
    projectdescription: str
