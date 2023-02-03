import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List, Optional

from dscreator import utils
from dscreator.datasets.base import TimeseriesDatasetBuilder
from dscreator.sources import base
from dscreator.storage import BaseHandler, get_storage_handler
from dscreator.utils import DatetimeInterval


@dataclass
class DataRunner:
    extractor: base.BaseExtractor
    dataset_builder: TimeseriesDatasetBuilder
    hourly_delta: int
    n_intervals: int
    custom_start_time: Optional[datetime] = None
    time_intervals: List[DatetimeInterval] = field(init=False)
    storage_handler: BaseHandler = field(init=False)

    def __post_init__(self):
        """Create timeintervals and storage handler for export

        The existence of a restart file in the storage location takes precedence and will override a
        custom start time.
        """
        self.storage_handler = get_storage_handler(
            project_name=self.dataset_builder.project_name, dataset_name=self.dataset_builder.dataset_name
        )
        restart_info = self.storage_handler.open_restart()

        if restart_info is not None:
            logging.info(f"Restarting from restart file at {restart_info.end_time}")
            start_time = restart_info.end_time
        elif self.custom_start_time is not None:
            start_time = self.custom_start_time
        else:
            start_time = self.extractor.first_timestamp()

        end_time = self.extractor.last_timestamp()
        time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=self.hourly_delta))
        last_index = len(time_intervals) if self.n_intervals < 1 else self.n_intervals

        self.time_intervals = time_intervals[0:last_index]

    def start(self):
        """Start the dataset export

        Create one file for each time interval and if there are data store a restart file
        """

        logging.info(f"Start dumping for {self.time_intervals[0].start_time} -> {self.time_intervals[-1].end_time}")

        restart_dataset = None

        for interval in self.time_intervals:
            logging.info(f"Dumping {interval.start_time} < time <= {interval.end_time}")
            ts = self.extractor.fetch_slice(start_time=interval.start_time, end_time=interval.end_time)
            ds = self.dataset_builder.create(ts)
            if ds.dims["time"] > 0:
                logging.info("Saving dataset slice")
                self.storage_handler.save_dataset(ds)
                restart_dataset = ds
            else:
                logging.info("Found no data for interval")

        if restart_dataset is not None:
            self.storage_handler.save_restart(restart_dataset)
