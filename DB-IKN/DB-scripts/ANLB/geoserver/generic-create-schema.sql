\echo "Starting deployment of GeoServer - create schema"

-- SCHEMA: geoserver

-- DROP SCHEMA geoserver ;

CREATE SCHEMA IF NOT EXISTS geoserver
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA geoserver TO anlb;

GRANT USAGE ON SCHEMA geoserver TO anlb_sqlpad;
