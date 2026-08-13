\echo "Starting deployment of NDVH synbiosys - IMNA-5898 Creation"

/* Create Schema */

CREATE SCHEMA IF NOT EXISTS synbiosys
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA synbiosys TO anlb;

GRANT USAGE ON SCHEMA synbiosys TO anlb_sqlpad
;

/* Create Sequences */

CREATE SEQUENCE IF NOT EXISTS synbiosys.synbiosys_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE synbiosys.synbiosys_seq
    OWNER TO anlb
;

/* Create Tables */

CREATE TABLE IF NOT EXISTS synbiosys.vegetatie_type_schema
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('synbiosys_seq'::text)::regclass),
	uri varchar(255) NOT NULL,
	omschrijving text NULL
)
;
ALTER TABLE synbiosys.vegetatie_type_schema
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS synbiosys.vegetatie_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('synbiosys_seq'::text)::regclass),
	uri varchar(255) NOT NULL,
	syntaxon_code varchar(100) NOT NULL,
	wet_naam varchar(255) NULL,
	ned_naam varchar(255) NULL,
	parent_id bigint NULL,
	vegetatie_type_schema_id bigint NOT NULL
)
;
ALTER TABLE synbiosys.vegetatie_type
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type_schema','PK_vegetatie_type_schema',
'ALTER TABLE synbiosys.vegetatie_type_schema ADD CONSTRAINT PK_vegetatie_type_schema
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type_schema','UN_vegetatie_type_schema_uri',
'ALTER TABLE synbiosys.vegetatie_type_schema ADD CONSTRAINT UN_vegetatie_type_schema_uri UNIQUE (uri)
;');

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type','PK_vegetatie_type',
'ALTER TABLE synbiosys.vegetatie_type ADD CONSTRAINT PK_vegetatie_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type','UN_vegetatie_type_uri',
'ALTER TABLE synbiosys.vegetatie_type ADD CONSTRAINT UN_vegetatie_type_uri UNIQUE (uri)
;');

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type','UN_vegetatie_type_schema_id_type_id',
'ALTER TABLE synbiosys.vegetatie_type ADD CONSTRAINT UN_vegetatie_type_schema_id_type_id UNIQUE (vegetatie_type_schema_id,id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_vegetatie_type ON synbiosys.vegetatie_type (parent_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_vegetatie_type_schema ON synbiosys.vegetatie_type (vegetatie_type_schema_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type','FK_vegetatie_type_vegetatie_type',
'ALTER TABLE synbiosys.vegetatie_type ADD CONSTRAINT FK_vegetatie_type_vegetatie_type
	FOREIGN KEY (parent_id) REFERENCES synbiosys.vegetatie_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('synbiosys','vegetatie_type','FK_vegetatie_type_vegetatie_type_schema',
'ALTER TABLE synbiosys.vegetatie_type ADD CONSTRAINT FK_vegetatie_type_vegetatie_type_schema
	FOREIGN KEY (vegetatie_type_schema_id) REFERENCES synbiosys.vegetatie_type_schema (id) ON DELETE No Action ON UPDATE No Action
;');

GRANT SELECT ON ALL TABLES IN SCHEMA synbiosys TO anlb_sqlpad
;