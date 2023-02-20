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
    locations: List[Point]
    gps_time: List[datetime]
    values: List[str | int | float]
    datetime_list: List[datetime]


@dataclass
class NamedTimeseries(NamedTimeArray):
    def __post_init__(self):
        assert len(self.locations) == 1, "Missing location"
        assert len(self.values) == len(self.datetime_list), f"Arrays need to have same length"


@dataclass
class NamedTrajectory(NamedTimeArray):
    def __post_init__(self):
        values = [self.values[self.datetime_list.index(dt)] if dt in self.datetime_list else None for dt in self.gps_time ]
        self.values = values
        logging.info(f"values {values}")
        assert (
            len(self.locations) == len(self.values) == len(self.gps_time)
        ), f"Arrays need to have same length: loc {len(self.locations)}, val {len(self.values)} and dt {len(self.gps_time)}"


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
