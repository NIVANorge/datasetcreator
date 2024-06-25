import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List, Optional, Union

from dscreator import utils
from dscreator.datasets.base import TimeseriesDatasetBuilder, TrajectoryDatasetBuilder
from dscreator.sources import base
from dscreator.storage import BaseHandler, get_storage_handler
from dscreator.utils import DatetimeInterval


@dataclass
class DataRunner:
    extractor: base.BaseExtractor
    """The extractor to use for data retrieval for example TimeseriesExtractor or TrajectoryExtractor"""
    dataset_builder: Union[TimeseriesDatasetBuilder, TrajectoryDatasetBuilder]
    """The dataset builder to use for creating the dataset, for example TimeseriesDatasetBuilder or TrajectoryDatasetBuilder"""
    hourly_delta: int
    """The number of hours to use for each time interval"""
    n_intervals: int
    """The number of intervals to use, if 0 all intervals are used"""
    custom_start_time: Optional[datetime] = None
    """Optional a custom start time to use for the export"""
    end_time_delay: Optional[timedelta] = None
    """Set a delay for the end time of the export, useful for ensuring that all data is available before exporting"""
    time_intervals: List[DatetimeInterval] = field(init=False)
    storage_handler: BaseHandler = field(init=False)

    def __post_init__(self):
        """Create timeintervals and storage handler for export

        The existence of a restart file in the storage location takes precedence and will override a
        custom start time.
        """
        self.storage_handler = get_storage_handler(
            grouping=self.dataset_builder.grouping,
            dataset_name=self.dataset_builder.dataset_name,
            unlimited_dims=["time"],
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
        if self.end_time_delay is not None:
            end_time = end_time - self.end_time_delay

        time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=self.hourly_delta))
        last_index = len(time_intervals) if self.n_intervals < 1 else self.n_intervals

        self.time_intervals = time_intervals[0:last_index]

    def start(self):
        """Start the dataset export

        This method will extract data from the extractor and create datasets using the dataset builder.
        The datasets are then saved using the storage handler. If a restart file is found the export will start from
        the end time of the restart file. If a custom start time is given the export will start from that time.
        """

        logging.info(f"Start dumping for {self.time_intervals[0].start_time} -> {self.time_intervals[-1].end_time}")

        restart_dataset = None

        for interval in self.time_intervals:
            logging.info(f"Dumping {interval.start_time} < time <= {interval.end_time}")
            data_dict = self.extractor.fetch_slice(start_time=interval.start_time, end_time=interval.end_time)
            ds = self.dataset_builder.create(data_dict)
            if ds.sizes["time"] > 0:
                logging.info(f"Saving dataset slice {ds.time[0].values} --> {ds.time[-1].values}")
                self.storage_handler.save_dataset(ds)
                restart_dataset = ds
            else:
                logging.info("Found no data for interval")

        if restart_dataset is not None:
            self.storage_handler.save_restart(restart_dataset)
