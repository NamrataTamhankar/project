CREATE TABLE IF NOT EXISTS masterdata.dmn_beleid_naam
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.dmn_beleid_naam
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beleid_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.dmn_beleid_type
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_bron_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.dmn_bron_type
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_bronhouder
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.dmn_bronhouder
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_classificatie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.dmn_classificatie
    OWNER to ikn;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_classificatie','PK_dmn_classificatie',
'ALTER TABLE masterdata.dmn_classificatie ADD CONSTRAINT PK_dmn_classificatie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_classificatie','un_code_classificatie',
'ALTER TABLE masterdata.dmn_classificatie ADD CONSTRAINT un_code_classificatie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder','PK_dmn_bronhouder',
'ALTER TABLE masterdata.dmn_bronhouder ADD CONSTRAINT PK_dmn_bronhouder
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder','un_code_bronhouder',
'ALTER TABLE masterdata.dmn_bronhouder ADD CONSTRAINT un_code_bronhouder UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bron_type','PK_dmn_bron_type',
'ALTER TABLE masterdata.dmn_bron_type ADD CONSTRAINT PK_dmn_bron_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bron_type','un_code_bron_type',
'ALTER TABLE masterdata.dmn_bron_type ADD CONSTRAINT un_code_bron_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beleid_type','PK_dmn_beleid_type',
'ALTER TABLE masterdata.dmn_beleid_type ADD CONSTRAINT PK_dmn_beleid_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beleid_type','un_code_beleid_type',
'ALTER TABLE masterdata.dmn_beleid_type ADD CONSTRAINT un_code_beleid_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beleid_naam','PK_dmn_beleid_naam',
'ALTER TABLE masterdata.dmn_beleid_naam ADD CONSTRAINT PK_dmn_beleid_naam
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beleid_naam','un_code_beleid_naam',
'ALTER TABLE masterdata.dmn_beleid_naam ADD CONSTRAINT un_code_beleid_naam UNIQUE (code)
;');

COMMENT ON TABLE masterdata.dmn_beleid_naam
	IS 'Domain specifying the regulation that applies to the nature area'
;

COMMENT ON TABLE masterdata.dmn_beleid_type
	IS 'Domain specifying the type of regulation (so an aggregate of the regulation e.g. beleid) of the nature area'
;

COMMENT ON TABLE masterdata.dmn_bron_type
	IS 'Domain specifying the source of the data. Possible values can be:  	1. WFS 	2. FGDB 	3. Other'
;

COMMENT ON TABLE masterdata.dmn_bronhouder
	IS 'Domain specifying the unique organisations responslible for a certain set of the data in IKN'
;

COMMENT ON TABLE masterdata.dmn_classificatie
	IS 'Domain specifying a sub classification of the nature area that can be used in the symology of map layer for the nature area'
;