from typing import Literal

TDEPTH = Literal["depth"]
TTIME = Literal["time"]
TLATITUDE = Literal["latitude"]
TLONGITUDE = Literal["longitude"]
TTRAJECTORY = Literal["trajectory"]
TOBS = Literal["OBS"]
TSTATION = Literal["station"]
TDIMLESS = tuple

DEPTH: TDEPTH = "depth"
TIME: TTIME = "time"
LATITUDE: TLATITUDE = "latitude"
LONGITUDE: TLONGITUDE = "longitude"
TRAJECTORY: TTRAJECTORY = "trajectory"
OBS: TOBS = "OBS"
STATION: TSTATION = "station"
DIMLESS: TDIMLESS = ()
