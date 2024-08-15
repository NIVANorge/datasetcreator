from dataclasses import dataclass, field
from datetime import datetime
from typing import List, Literal


@dataclass
class VariableAttrsBase:
    """CF variable attributes"""

    long_name: str
    units: str


@dataclass
class CFVariableAttrs(VariableAttrsBase):
    """CF variable attributes

    This can be used if there is a CF standard name for the variable
    """

    standard_name: str
    long_name: str
    units: str


@dataclass
class VariableAttrs(VariableAttrsBase):
    short_name: str


@dataclass
class FlagAttrs:
    """CF Flag attributes"""

    long_name: str
    standard_name: str = "status_flag"
    flag_meanings: str = (
        "no_qc_performed good_data probably_good_data bad_data_that_are_potentially_correctable bad_data value_changed value_below_detection nominal_value interpolated_value missing_value"
    )
    valid_max: int = 9
    valid_min: int = 0
    flag_values: List[int] = field(init=False)

    def __post_init__(self):
        self.valid_max: 9
        self.valid_min: 0
        self.flag_values: List[int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


@dataclass
class AltitudeAttrs:
    standard_name: str = "height"
    long_name: str = "vertical distance above the surface"
    units: str = "m"
    positive: str = "up"
    axis: str = "Z"


@dataclass
class LatitudeAttrs:
    standard_name: str = "latitude"
    long_name: str = "latitude"
    units: str = "degree_north"
    valid_min: float = -90.0
    valid_max: float = 90.0
    axis: str = "Y"
    coordinate_reference_frame: str = "urn:ogc:def:crs:EPSG::4326"


@dataclass
class LongitudeAttrs:
    standard_name: str = "longitude"
    long_name: str = "longitude"
    units: str = "degree_east"
    valid_min: float = -180.0
    valid_max: float = 180.0
    axis: str = "X"
    coordinate_reference_frame: str = "urn:ogc:def:crs:EPSG::4326"


@dataclass
class TimeAttrs:
    """Specs for the Time axis."""

    standard_name: str = "time"
    long_name: str = "Time of measurement"
    axis: str = "T"
    # units is filled by xarray, based on time interval


@dataclass
class DepthAttrs:
    """Specs for the Z axis."""

    standard_name: str = "depth"
    long_name: str = "Depth of measurement"
    positive: str = "down"
    units: str = "m"
    axis: str = "Z"
    reference: str = "sea_level"
    coordinate_reference_frame: str = "urn:ogc:def:crs:EPSG::CRF 5831"


@dataclass
class DatasetAttrsBase:
    title: str
    summary: str
    title_no: str
    summary_no: str
    date_created: datetime
    keywords: str
    keywords_vocabulary: str
    time_coverage_start: str
    time_coverage_end: str
    geospatial_lat_min: float
    geospatial_lat_max: float
    geospatial_lon_min: float
    geospatial_lon_max: float
    # https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#spatial_representation
    spatial_representation: str
    project: str


@dataclass
class DatasetAttrsDiscreteBase(DatasetAttrsBase):
    featureType: str


@dataclass
class DatasetAttrsDefaults:
    naming_authority: str = "no.niva"
    creator_type: str = "institution"
    creator_institution: str = "Norwegian Institute for Water Research"
    institution: str = "Norwegian Institute for Water Research (NIVA)"
    creator_email: str = "miljoinformatikk@niva.no"
    creator_url: str = "https://niva.no"
    creator_name: str = "Norwegian Institute for Water Research"
    data_owner: str = "Norwegian Institute for Water Research"
    # One of https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#operational-status
    processing_level: str = "Not available"
    Conventions: str = "CF-1.7, ACDD-1.3"
    netcdf_version: str = "4"
    publisher_name: str = "Norwegian Institute for Water Research"
    publisher_institution: str = "Norwegian Institute for Water Research"
    publisher_email: str = "miljoinformatikk@niva.no"
    publisher_url: str = "https://niva.no"
    # From https://spdx.org/licenses/
    license: str = "http://spdx.org/licenses/CC-BY-4.0(CC-BY-4.0)"
    # See https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#iso-topic-categories
    iso_topic_category: str = "Not available"
    history: str = "Built with dscreator"


@dataclass
class DatasetAttrsDiscrete(DatasetAttrsDefaults, DatasetAttrsDiscreteBase):
    pass


@dataclass
class DatasetAttrsGrid(DatasetAttrsDefaults, DatasetAttrsBase):
    pass


@dataclass
class FerryboxDatasetAttrsBase(DatasetAttrsDiscreteBase):
    ices_platform_code: str
    platform_code: str
    platform_name: str
    references: str
    depth: str


@dataclass
class FerryboxDatasetAttrs(DatasetAttrsDefaults, FerryboxDatasetAttrsBase):
    processing_level: str = "Operational"
    # https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#activity-type
    source: str = "FerryBox"
