from dataclasses import dataclass
from datetime import datetime
from typing import List, Literal


@dataclass
class VariableAttrs:
    standard_name: str
    long_name: str
    units: str


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
class DatasetAttrs:
    title: str
    date_created: datetime
    keywords: List[str]
    time_coverage_start: str
    time_coverage_end: str
    geospatial_lat_min: float
    geospatial_lat_max: float
    geospatial_lon_min: float
    geospatial_lon_max: float
    featureType: str
    project: str
    keywords_vocabulary: str = "GCM:GCMD Keywords"
    data_owner: str = "Norwegian Institute for Water Research"
    summary: str = ""
    geospatial_vertical_positive: str = "down"
    processing_level: str = "Missing data has been filled with fillValue."
    Conventions: str = "CF-1.6, ACDD-1.3"
    netcdf_version: str = "4"
    publisher_name: str = "NIVA"
    publisher_email: str = "post[..]niva.no"
    publisher_url: str = "niva.no"
    licence: str = 'Freely distributed. Must credit the source of data, e.g. "Data fra Norsk Institut for Vannforskning", "Based on data from the Norwegian Institute for Water Research". Data and products are licensed under Norwegian license for public data (NLOD) and Creative Commons Attribution 3.0 Norway.'
    history: str = "Initial data"
