/* GRANT USAGE ON SCHEMA */
GRANT USAGE ON SCHEMA masterdata TO besi_geoweb;
GRANT USAGE ON SCHEMA masterdata TO besi_readonly;


/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_beschermende_factor
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beschermende_factor
    OWNER to anlb;
	
GRANT SELECT ON TABLE masterdata.dmn_beschermende_factor TO besi_readonly;

CREATE TABLE IF NOT EXISTS masterdata.dmn_effect
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_effect
    OWNER to anlb;
	
GRANT SELECT ON TABLE masterdata.dmn_effect TO besi_readonly;

CREATE TABLE IF NOT EXISTS masterdata.dmn_scope
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_scope
    OWNER to anlb;

GRANT SELECT ON TABLE masterdata.dmn_scope TO besi_readonly;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beschermende_factor','PK_dmn_beschermende_factor',
'ALTER TABLE masterdata.dmn_beschermende_factor ADD CONSTRAINT PK_dmn_beschermende_factor
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beschermende_factor','UN_code_beschermende_factor',
'ALTER TABLE masterdata.dmn_beschermende_factor ADD CONSTRAINT UN_code_beschermende_factor UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_effect','PK_dmn_effect',
'ALTER TABLE masterdata.dmn_effect ADD CONSTRAINT PK_dmn_effect
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_effect','UN_code_effect',
'ALTER TABLE masterdata.dmn_effect ADD CONSTRAINT UN_code_effect UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_scope','PK_dmn_scope',
'ALTER TABLE masterdata.dmn_scope ADD CONSTRAINT PK_dmn_scope
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_scope','UN_code_scope',
'ALTER TABLE masterdata.dmn_scope ADD CONSTRAINT UN_code_scope UNIQUE (code)
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE masterdata.dmn_effect
	IS 'Defines the potential different negative effects on flora and fauna.'
;

COMMENT ON TABLE masterdata.dmn_scope
	IS 'Defines the scope of the workItem related to BESI Values could be: TG = Te Groot TK = Te Klein IS - In Scope'
;

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;


/* IMNA-9871 Besi new database user account */
GRANT SELECT ON masterdata.dmn_scope TO besi_geoweb;