import abc
from dataclasses import dataclass
from datetime import datetime
from typing import List
import logging


@dataclass
class Point:
    longitude: float
    latitude: float


@dataclass
class NamedTimeArray:
    variable_name: str
    values: List[str | int | float | None]


@dataclass
class NamedTrajectory:
    array_list: List[NamedTimeArray]
    datetime_list: List[datetime]
    locations: List[Point]

    def __post_init__(self):
        assert (
            len(self.locations) == len(self.array_list[0].values) == len(self.datetime_list)
        ), f"Arrays need to have same length: loc {len(self.locations)}, val {self.array_list[0].values} and dt {len(self.datetime_list)}"


@dataclass
class NamedTimeseries(NamedTimeArray):
    locations: List[Point]
    datetime_list: List[datetime]

    def __post_init__(self):
        assert len(self.locations) == 1, "Missing location"
        assert len(self.values) == len(self.datetime_list), f"Arrays need to have same length"


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
