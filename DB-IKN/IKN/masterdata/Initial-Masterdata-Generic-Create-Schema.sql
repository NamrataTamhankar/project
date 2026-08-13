\echo "Starting deployment of Masterdata Generic Create Schema for IKN automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS masterdata
    AUTHORIZATION ikn;

GRANT ALL ON SCHEMA masterdata TO ikn;

GRANT USAGE ON SCHEMA masterdata TO ikn_readonly;
GRANT USAGE ON SCHEMA masterdata TO ikn_geoweb;

/* Create Sequence if not exists */
CREATE SEQUENCE IF NOT EXISTS masterdata.masterdata_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE masterdata.masterdata_seq
    OWNER TO ikn;