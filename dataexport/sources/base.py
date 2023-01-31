import abc
from dataclasses import dataclass
from datetime import datetime
from typing import List


@dataclass
class Point:
    longitude: float
    latitude: float


@dataclass
class NamedTimeseries:
    variable_name: str
    locations: List[Point]
    values: List[str | int | float]
    datetime: List[datetime]


@dataclass
class BaseExtractor(abc.ABC):
    @abc.abstractmethod
    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[NamedTimeseries]:
        pass

    @abc.abstractmethod
    def start_time(self) -> datetime:
        pass

    @abc.abstractmethod
    def end_time(self) -> datetime:
        pass
