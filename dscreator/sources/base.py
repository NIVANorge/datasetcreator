import abc
from dataclasses import dataclass
from datetime import datetime
from typing import List
import pandas as pd


@dataclass
class Point:
    longitude: float
    latitude: float


@dataclass
class BaseExtractor(abc.ABC):
    """Base class for extractors"""

    @abc.abstractmethod
    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> pd.DataFrame:
        pass

    @abc.abstractmethod
    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction"""
        pass

    @abc.abstractmethod
    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction"""
        pass
