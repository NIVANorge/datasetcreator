import logging
from datetime import datetime, timedelta
from typing import List, Optional

from dataexport import thredds, utils
from dataexport.datasets.base import TimeseriesDatasetBuilder
from dataexport.sources import base
from dataexport.utils import DatetimeInterval


def create_time_intervals(
    extractor: base.BaseExtractor,
    dataset_name: str,
    start_from_thredds: bool,
    hourly_delta: int,
    n_intervals: int,
    custom_start_time: Optional[datetime] = None,
) -> List[DatetimeInterval]:
    """Create timeintervals for a dataset

    If starting from scratch the start time provided by the extractor is used, unless a custom start time
    is passed. If the flag start_from_thredds is set, the export will continue from the last timestamp for the dataset
    on the thredds server.
    """

    if start_from_thredds:
        start_time = thredds.end_time(dataset_name)
    elif custom_start_time is not None:
        start_time = custom_start_time
    else:
        start_time = extractor.first_timestamp()

    end_time = extractor.last_timestamp()
    time_intervals = utils.datetime_intervals(start_time, end_time, timedelta(hours=hourly_delta))
    last_index = len(time_intervals) if n_intervals < 1 else n_intervals

    return time_intervals[0:last_index]


def export(
    extractor: base.BaseExtractor,
    dataset_builder: TimeseriesDatasetBuilder,
    time_intervals: List[DatetimeInterval],
):
    """Export the dataset

    Create one file for each time interval
    """

    logging.info(f"Start dumping for {time_intervals[0].start_time} -> {time_intervals[-1].end_time}")

    for interval in time_intervals:
        logging.info(f"Dumping {interval.start_time} < time <= {interval.end_time}")
        ts = extractor.fetch_slice(start_time=interval.start_time, end_time=interval.end_time)
        ds = dataset_builder.create(ts)
        if ds.dims["time"] > 0:
            utils.save_dataset(ds, dataset_builder.project_name, filename=dataset_builder.dataset_name)
        else:
            logging.info("Found no data for interval")
