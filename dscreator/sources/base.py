import abc
import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List


@dataclass
class Point:
    longitude: float
    latitude: float


@dataclass
class NamedArray:
    """A single named array"""

    variable_name: str
    values: List[str | int | float | None]


@dataclass
class NamedTimeArray(NamedArray):
    """A named time array

    An array of values with a corresponding list of timestamps
    """

    datetime_list: List[datetime]
    locations: List[Point]

    def __post_init__(self):
        assert len(self.datetime_list) == len(self.values)


@dataclass
class FeatureBase:
    array_list: List[NamedArray]
    def __add__(self, na_list):
        for na1 in self.array_list:
            for na2 in na_list:
                if na1.variable_name == na2.variable_name:
                    na1.values = na1.values + na2.values
        return self.array_list

@dataclass
class NamedTrajectory(FeatureBase):
    """Class to build a trajectory

    The goal is to create a single CF trajectory. To do this each array needs to be aligned
    to the location array, along the time dimension.
    """

    datetime_list: List[datetime]
    locations: List[Point]

    def __add__(self, nt):
        return self.datetime_list + nt.datetime_list, self.locations + nt.locations, self.array_list + nt.array_list

    def __post_init__(self):
        assert (
            len(self.locations) == len(self.array_list[0].values) == len(self.datetime_list)
        ), f"Arrays need to have same length: loc {len(self.locations)}, val {self.array_list[0].values} and dt {len(self.datetime_list)}"


@dataclass
class NamedTimeseries(FeatureBase):
    """Class to build a timeseries

    The goal is to create a single CF timeseries. For this each array needs to be aligned
    to the timearray.
    """

    array_list: List[NamedTimeArray]


@dataclass
class BaseExtractor(abc.ABC):
    @abc.abstractmethod
    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[FeatureBase]:
        pass

    @abc.abstractmethod
    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction"""
        pass

    @abc.abstractmethod
    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction"""
        pass
