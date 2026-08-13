\echo "Starting deployment of masterdata - create schema"

-- SCHEMA: masterdata

-- DROP SCHEMA masterdata ;

CREATE SCHEMA IF NOT EXISTS masterdata
    AUTHORIZATION anlb;


GRANT USAGE ON SCHEMA masterdata TO anlb_sqlpad;

GRANT ALL ON SCHEMA masterdata TO anlb;

/* Create Sequences */

CREATE SEQUENCE IF NOT EXISTS masterdata.masterdata_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE masterdata.masterdata_seq
    OWNER TO anlb
;