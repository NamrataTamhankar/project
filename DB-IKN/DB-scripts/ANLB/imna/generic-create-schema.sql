\echo "Starting deployment of imna - create schema"

-- SCHEMA: imna

-- DROP SCHEMA imna ;

CREATE SCHEMA IF NOT EXISTS imna
    AUTHORIZATION anlb;


GRANT USAGE ON SCHEMA imna TO anlb_sqlpad;

GRANT ALL ON SCHEMA imna TO anlb;

/* Create Sequences */

CREATE SEQUENCE IF NOT EXISTS imna.imna_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE imna.imna_seq
    OWNER TO anlb
;