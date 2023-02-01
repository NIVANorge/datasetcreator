import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from functools import partial
from typing import List

from sqlalchemy import Engine

from dataexport.sources.base import BaseExtractor, NamedTrajectory, Point


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
