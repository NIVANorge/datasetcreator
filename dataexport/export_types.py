from dataclasses import dataclass
from datetime import datetime
from typing import List


@dataclass
class __ExportSettings:
    uuid: str
    title: str
    project_name: str
    variable_codes: List[str]
    dataset_name: str


@dataclass
class ProjectExport(__ExportSettings):
    project_station_code: str


@dataclass
class SamplingExport(__ExportSettings):
    station_name: str
    sampling_feature_code: str
    projectdescription: str
