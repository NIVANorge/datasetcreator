import abc
from dataclasses import dataclass
from datetime import datetime
from typing import List


@dataclass
class Point:
    longitude: float
    latitude: float


@dataclass
class NamedTimeArray:
    variable_name: str
    locations: List[Point]
    values: List[str | int | float]
    datetime: List[datetime]


@dataclass
class NamedTimeseries(NamedTimeArray):
    def __post_init__(self):
        assert len(self.locations) == 1, "Missing location"
        assert len(self.values) == len(self.datetime), "Arrays need to have same length"


@dataclass
class NamedTrajectory(NamedTimeArray):
    def __post_init__(self):
        assert len(self.locations) == len(self.values) == len(self.datetime), "Arrays need to have same length"


@dataclass
class BaseExtractor(abc.ABC):
    @abc.abstractmethod
    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[NamedTimeArray]:
        pass

    @abc.abstractmethod
    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction"""
        pass

    @abc.abstractmethod
    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction"""
        pass
