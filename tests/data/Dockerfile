From postgis/postgis:12-3.3

COPY odm2.sql /docker-entrypoint-initdb.d/
COPY tsb.sql /docker-entrypoint-initdb.d/

COPY ts.csv /docker-entrypoint-initdb.d/
COPY flag.csv /docker-entrypoint-initdb.d/
COPY track.csv /docker-entrypoint-initdb.d/
COPY spectra.csv /docker-entrypoint-initdb.d/
COPY spectra_track.csv /docker-entrypoint-initdb.d/