import logging
from dataclasses import dataclass
from datetime import datetime
from typing import List

from dscreator.sources.base import BaseExtractor, NamedTrajectory


@dataclass
class TrajectoryExtractor(BaseExtractor):
    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> List[NamedTrajectory]:
        pass

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction"""
        pass

    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction"""
        pass
