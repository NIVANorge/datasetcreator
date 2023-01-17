from dataclasses import dataclass
from typing import List
from datetime import datetime


@dataclass
class __ExportSettings:
    title: str
    project_name: str
    variable_codes: List[str]
    filename: str


@dataclass
class ProjectExport(__ExportSettings):
    project_station_code: str


@dataclass
class SamplingExport(__ExportSettings):
    sampling_feature_code: str
