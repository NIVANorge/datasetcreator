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
class AltitudeAttrs:
    standard_name: str = "height"
    long_name: str = "vertical distance above the surface"
    units: str = "m"
    positive: str = "up"
    axis: str = "Z"


@dataclass
class LatitudeAttrs:
    standard_name: str = "latitude"
    units: str = "degree_north"
    valid_min: float = -90.0
    valid_max: float = 90.0
    axis: str = "Y"
    grid_mapping: str = "crs"
    coordinate_reference_frame: str = "urn:ogc:def:crs:EPSG::4326"


@dataclass
class LongitudeAttrs:
    standard_name: str = "longitude"
    units: str = "degree_east"
    valid_min: float = -180.0
    valid_max: float = 180.0
    axis: str = "X"
    grid_mapping: str = "crs"
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
    date_created: datetime
    keywords: str
    keywords_vocabulary: str
    time_coverage_start: str
    time_coverage_end: str
    geospatial_lat_min: float
    geospatial_lat_max: float
    geospatial_lon_min: float
    geospatial_lon_max: float
    featureType: str
    project: str


@dataclass
class DatasetAttrsDefaults:
    naming_authority: str = "no.niva"
    creator_type: str = "institution"
    creator_institution: str = "Norwegian Institute for Water Research"
    institution: str = "Norwegian Institute for Water Research"
    institution_short_name: str = "NIVA"
    creator_email: str = "miljoinformatikk@niva.no"
    creator_url: str = "https://niva.no"
    data_owner: str = "Norwegian Institute for Water Research"
    processing_level: str = "Missing data has been filled with fillValue."
    Conventions: str = "CF-1.7, ACDD-1.3"
    netcdf_version: str = "4"
    publisher_name: str = "Norwegian Institute for Water Research"
    publisher_email: str = "miljoinformatikk@niva.no"
    publisher_url: str = "https://niva.no"
    # From https://spdx.org/licenses/
    license: str = "http://spdx.org/licenses/CC-BY-4.0"
    # See https://htmlpreview.github.io/?https://github.com/metno/mmd/blob/master/doc/mmd-specification.html#iso-topic-categories
    iso_topic_category: str = "Not available"
    history: str = "Built with dscreator"


@dataclass
class DatasetAttrs(DatasetAttrsDefaults, DatasetAttrsBase):
    pass


@dataclass
class NorDatasetAttrsBase(DatasetAttrsBase):
    title_no: str
    summary_no: str


@dataclass
class NorDatasetAttrs(DatasetAttrsDefaults, NorDatasetAttrsBase):
    pass

@dataclass
class FerryboxDatasetAttrsBase(DatasetAttrsBase):
    ices_platform_code: str
    platform_code: str
    platform_name: str
    metadata_link: str = "http://path/Document_describing_calibration.pdf"


@dataclass
class FerryboxDatasetAttrs(DatasetAttrsDefaults, FerryboxDatasetAttrsBase):
    processing_level: str = "Automated Quality Control applied"
    source: str = "Ferryboxes"
    license: str = (
        "These data are public and free of charge. User assumes all risk for use of data. "
        "User must display citation in any publication or product using data. "
        "User must contact NIVA prior to any commercial use of data. "
    )
