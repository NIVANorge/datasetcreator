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
    summary: str
    date_created: datetime
    keywords: str
    time_coverage_start: str
    time_coverage_end: str
    geospatial_lat_min: float
    geospatial_lat_max: float
    geospatial_lon_min: float
    geospatial_lon_max: float
    featureType: str
    project: str
    naming_authority: str = "no.niva"
    creator_type: str = "institution"
    creator_institution: str = "Norwegian Institute for Water Research"
    creator_email: str = "miljoinformatikk@niva.no"
    creator_url: str = "https://niva.no"
    data_owner: str = "Norwegian Institute for Water Research"
    keywords_vocabulary: str = "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords, GCMDLOC:GCMD Locations:https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/locations"
    processing_level: str = "Missing data has been filled with fillValue."
    Conventions: str = "CF-1.7, ACDD-1.3"
    netcdf_version: str = "4"
    publisher_name: str = "Norwegian Institute for Water Research"
    publisher_email: str = "miljoinformatikk@niva.no"
    publisher_url: str = "https://niva.no"
    licence: str = "CC-BY-4.0"
    history: str = "Initial data"
