\echo "Starting deployment of NDVH masterdata IMNA-5837 - Vegatatie Masterdata"

-- SCHEMA: masterdata

GRANT USAGE ON SCHEMA masterdata TO ndvh_geoweb;

/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_bronhouder_vegetatie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_bronhouder_vegetatie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_protocol
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_protocol
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_strata
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_strata
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_vegetatie_hoogte_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_vegetatie_hoogte_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_vegetatie_laag_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_vegetatie_laag_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_vegetatie_taxa
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code varchar(255) NOT NULL,
	description varchar(255) NULL,
	valid_from timestamp NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_vegetatie_taxa
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder_vegetatie','PK_dmn_bronhouder_vegetatie',
'ALTER TABLE masterdata.dmn_bronhouder_vegetatie ADD CONSTRAINT PK_dmn_bronhouder_vegetatie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder_vegetatie','UN_code_bronhouder_vegetatie',
'ALTER TABLE masterdata.dmn_bronhouder_vegetatie ADD CONSTRAINT UN_code_bronhouder_vegetatie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_protocol','PK_dmn_protocol',
'ALTER TABLE masterdata.dmn_protocol ADD CONSTRAINT PK_dmn_protocol
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_protocol','UN_code_protocol',
'ALTER TABLE masterdata.dmn_protocol ADD CONSTRAINT UN_code_protocol UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_strata','PK_dmn_strata',
'ALTER TABLE masterdata.dmn_strata ADD CONSTRAINT PK_dmn_strata
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_strata','UN_code_strata',
'ALTER TABLE masterdata.dmn_strata ADD CONSTRAINT UN_code_strata UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_vegetatie_hoogte_type','PK_dmn_vegetatie_hoogte_type',
'ALTER TABLE masterdata.dmn_vegetatie_hoogte_type ADD CONSTRAINT PK_dmn_vegetatie_hoogte_type
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS UN_code_vegetatie_hoogte_type ON masterdata.dmn_vegetatie_hoogte_type (code ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_vegetatie_laag_type','PK_dmn_vegetatie_laag_type',
'ALTER TABLE masterdata.dmn_vegetatie_laag_type ADD CONSTRAINT PK_dmn_vegetatie_laag_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_vegetatie_laag_type','UN_code_vegetatie_laag_type',
'ALTER TABLE masterdata.dmn_vegetatie_laag_type ADD CONSTRAINT UN_code_vegetatie_laag_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_vegetatie_taxa','PK_dmn_vegetatie_taxa',
'ALTER TABLE masterdata.dmn_vegetatie_taxa ADD CONSTRAINT PK_dmn_vegetatie_taxa
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_vegetatie_taxa','UN_code_vegetatie_taxa',
'ALTER TABLE masterdata.dmn_vegetatie_taxa ADD CONSTRAINT UN_code_vegetatie_taxa UNIQUE (code)
;');

GRANT SELECT ON masterdata.provinces TO ndvh_geoweb;
GRANT SELECT ON masterdata.dmn_bronhouder_vegetatie TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;