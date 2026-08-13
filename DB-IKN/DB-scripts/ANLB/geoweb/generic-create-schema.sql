\echo "Starting deployment of GeoWeb - create schema"

-- SCHEMA: geoweb

-- DROP SCHEMA geoweb ;

CREATE SCHEMA IF NOT EXISTS geoweb
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA geoweb TO anlb;

GRANT USAGE ON SCHEMA geoweb TO anlb_sqlpad;
;