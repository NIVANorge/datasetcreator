import logging
from dataclasses import dataclass, field
from datetime import datetime, timedelta
from typing import List
import pandas as pd

from sqlalchemy import Engine, Sequence, RowMapping

from dscreator.sources.base import BaseExtractor
from dscreator.sources.ferrybox import queries


@dataclass
class TrajectoryExtractor(BaseExtractor):
    """Create a ferybox trajectory extractor

    platform_variable_key: A key in the MAPPER dict
    """

    engine: Engine
    variable_codes: List[str]
    variable_uuid_map: dict[str, str]
    qc_flags: List[int]
    with_qc: bool = True
    qc_variables: List[str] = field(init=False)

    def __post_init__(self):
        self.variable_uuid_map = {
            k: v for k, v in self.variable_uuid_map.items() if k in self.variable_codes + ["track"]
        }
        if self.with_qc:
            self.qc_variables = [f"{v}_qc" for v in self.variable_codes]
        else:
            self.qc_variables = []

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> dict[str, list]:
        """Create a data dictonary trajectory from tsb

        The the data dictonary is limited to start_time<t<=end_time. The result is a dictionary with the following keys:
        - time (list of datetime)
        - variable_names (list of float)
        - latitude (list of float)
        - longitude (list of float)

        The all list should have the same length and time should be increasing. Missing value returned as 9 for qc
        """

        data_list = queries.get_ts(
            self.engine,
            track_uuid=self.variable_uuid_map["track"],
            uuids=list(self.variable_uuid_map.values()),
            start_time=start_time,
            end_time=end_time,
            qc_flags=self.qc_flags,
        )

        return self._format_data(data_list)

    def _format_data(self, data_list: List[RowMapping]) -> dict[str, list]:
        """Format data from get_ts to a data dictionary"""

        data_dict = {v: [] for v in ["time", "latitude", "longitude"] + self.variable_codes + self.qc_variables}
        value_template = {v: (None, 9) for v in self.variable_uuid_map.values()}

        if not data_list:
            return data_dict

        previous_point = current_point = data_list.pop(0)
        value_template[str(previous_point.uuid)] = (previous_point.value, previous_point.qc)

        while data_list:
            current_point = data_list.pop(0)
            point_uuid = str(current_point.uuid)
            if current_point.time > previous_point.time:
                self._push_point(data_dict, previous_point, value_template)
                previous_point = current_point
            value_template[point_uuid] = (current_point.value, current_point.qc)
        self._push_point(data_dict, current_point, value_template)

        return data_dict

    def _push_point(self, data_dict: dict, current_point: dict, value_template: dict):
        """Push point into data_dict and reset value_template"""

        data_dict["time"].append(current_point.time)
        data_dict["latitude"].append(current_point.latitude)
        data_dict["longitude"].append(current_point.longitude)

        for var_name in self.variable_codes:
            point_uuid = self.variable_uuid_map[var_name]
            data_dict[var_name].append(value_template[point_uuid][0])

        for var_name in self.qc_variables:
            point_uuid = self.variable_uuid_map[var_name.split("_qc")[0]]
            data_dict[var_name].append(value_template[point_uuid][1])

        for k in value_template.keys():
            value_template[k] = (None, 9)

    def _timestamp(self, is_asc: bool) -> datetime:
        return queries.get_time_by_uuids(
            self.engine, [self.variable_uuid_map[vcode] for vcode in self.variable_codes], is_asc
        )

    def first_timestamp(self) -> datetime:
        """The first timestamp for extraction
        Padded with 10 sec
        """
        return self._timestamp(is_asc=True) - timedelta(seconds=10)

    def last_timestamp(self) -> datetime:
        """The last timestamp for extraction
        Padded with 10 sec
        """
        return self._timestamp(is_asc=False) + timedelta(seconds=10)


@dataclass
class SpectraExtractor(TrajectoryExtractor):
    def __post_init__(self):
        vum = dict(self.variable_uuid_map)
        name_shortcuts = []
        for vcode in self.variable_codes:
            name, wl = vcode.split("_")
            name_shortcuts.append(name)
            if name in self.variable_uuid_map:
                vum[vcode] = f"{self.variable_uuid_map[name]}_{wl}"

        self.variable_uuid_map = {k: v for k, v in vum.items() if k not in name_shortcuts}
        super().__post_init__()

    def fetch_slice(
        self,
        start_time: datetime,
        end_time: datetime,
    ) -> dict[str, list]:
        """Create a data dictonary trajectory from tsb

        The the data dictonary is limited to start_time<t<=end_time. The result is a dictionary with the following keys:
        - time (list of datetime)
        - variable_names (list of float)
        - latitude (list of float)
        - longitude (list of float)

        The all list should have the same length and time should be increasing. Missing value returned as 9 for qc
        """
        # Extract rrs UUID and other UUIDs from variable_uuid_map
        rrs_codes = [vcode for vcode in self.variable_codes if vcode.startswith("rrs_")]
        not_rrs_codes = [vcode for vcode in self.variable_codes if not vcode.startswith("rrs_")]

        if not rrs_codes:
            return {v: [] for v in ["time", "latitude", "longitude"] + self.variable_codes + self.qc_variables}

        # Get unique UUIDs (without wavelength suffix) and wavelengths
        rrs_uuid_wl = [self.variable_uuid_map[vcode].split("_") for vcode in rrs_codes]
        rrs_uuid = rrs_uuid_wl[0][0]  # All rrs variables share same UUID
        wave_lengths = list(set(wl for _, wl in rrs_uuid_wl))

        other_uuids = []
        if not_rrs_codes:
            other_uuid_wl = [self.variable_uuid_map[vcode].split("_") for vcode in not_rrs_codes]
            other_uuids = list(set(uuid for uuid, _ in other_uuid_wl))

        data_list = queries.get_spectra_with_rrs_qc_filter(
            self.engine,
            track_uuid=self.variable_uuid_map["track"],
            rrs_uuid=rrs_uuid,
            other_uuids=other_uuids,
            wave_lengths=[int(wl) for wl in wave_lengths],
            start_time=start_time,
            end_time=end_time,
        )

        return self._format_data(data_list)

    def _timestamp(self, is_asc: bool) -> datetime:
        uuids, wls = zip(*(self.variable_uuid_map[vcode].split("_") for vcode in self.variable_codes))
        return queries.get_spectra_time_by_uuids(self.engine, uuids, wls, is_asc)
