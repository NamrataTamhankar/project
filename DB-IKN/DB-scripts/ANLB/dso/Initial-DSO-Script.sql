\echo "Starting deployment of dso schema for DSO automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS dso
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA dso TO anlb;

--GRANT USAGE ON SCHEMA dso TO ;
GRANT USAGE ON SCHEMA dso TO anlb_sqlpad;
GRANT USAGE ON SCHEMA dso TO besi_readonly;
GRANT USAGE ON SCHEMA dso TO besi_geoweb;

/* Create Sequences */

CREATE SEQUENCE IF NOT EXISTS dso.dso_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE dso.dso_seq
    OWNER TO anlb
;


/* Create Tables */

CREATE TABLE IF NOT EXISTS dso.trefwoord
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('dso_seq'::text)::regclass),    -- Internal id of the keyword
	trefwoord varchar(255) NOT NULL    -- Keyword associated with a workItem
)
;

ALTER TABLE dso.trefwoord
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS dso.werkzaamheid
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('dso_seq'::text)::regclass),    -- Internal id of the workItem
	urn varchar(255) NOT NULL,    -- Unique Id of the workItem
	omschrijving text NULL,    -- Descriptive text of the workItem
	functionele_structuur_ref varchar(1024) NULL,    -- Link to a webpage with de explanation of the workItem
	link varchar(1024) NULL,    -- URL pointing to this workItem in the DSO api
	scope_id bigint NULL,    -- Link the scope that defines the scope of the workItem related to BESI
	valide_van timestamp NOT NULL   DEFAULT NOW(),    -- start validity of the workItem in relationship with BESI
	valide_tot timestamp NULL    -- endt validity of the workItem in relationship with BESI
)
;

ALTER TABLE dso.werkzaamheid
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS dso.werkzaamheid_trefwoord
(
	werkzaamheid_id bigint NOT NULL,    -- reference to the workItem using the internal id
	trefwoord_id bigint NOT NULL    -- reference to the keyword using the internal id
)
;

ALTER TABLE dso.werkzaamheid_trefwoord
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('dso','trefwoord','PK_trefwoord',
'ALTER TABLE dso.trefwoord ADD CONSTRAINT PK_trefwoord
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('dso','trefwoord','UN_trefwoord_trefwoord',
'ALTER TABLE dso.trefwoord ADD CONSTRAINT UN_trefwoord_trefwoord UNIQUE (trefwoord)
;');

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid','PK_werkzaamheid',
'ALTER TABLE dso.werkzaamheid ADD CONSTRAINT PK_werkzaamheid
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid','UN_werkzaamheid_urn',
'ALTER TABLE dso.werkzaamheid ADD CONSTRAINT UN_werkzaamheid_urn UNIQUE (urn)
;');

CREATE INDEX IF NOT EXISTS IXFK_werkzaamheid_dmn_scope ON dso.werkzaamheid (scope_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid_trefwoord','PK_werkzaamheid_trefwoord',
'ALTER TABLE dso.werkzaamheid_trefwoord ADD CONSTRAINT PK_werkzaamheid_trefwoord
	PRIMARY KEY (werkzaamheid_id,trefwoord_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_werkzaamheid_trefwoord_trefwoord ON dso.werkzaamheid_trefwoord (trefwoord_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_werkzaamheid_trefwoord_werkzaamheid ON dso.werkzaamheid_trefwoord (werkzaamheid_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid','FK_werkzaamheid_dmn_scope',
'ALTER TABLE dso.werkzaamheid ADD CONSTRAINT FK_werkzaamheid_dmn_scope
	FOREIGN KEY (scope_id) REFERENCES masterdata.dmn_scope (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid_trefwoord','FK_werkzaamheid_trefwoord_trefwoord',
'ALTER TABLE dso.werkzaamheid_trefwoord ADD CONSTRAINT FK_werkzaamheid_trefwoord_trefwoord
	FOREIGN KEY (trefwoord_id) REFERENCES dso.trefwoord (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('dso','werkzaamheid_trefwoord','FK_werkzaamheid_trefwoord_werkzaamheid',
'ALTER TABLE dso.werkzaamheid_trefwoord ADD CONSTRAINT FK_werkzaamheid_trefwoord_werkzaamheid
	FOREIGN KEY (werkzaamheid_id) REFERENCES dso.werkzaamheid (id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE dso.trefwoord
	IS 'Contains the keywords associated with a WorkItem. This can be used to search on Workitems.'
;

COMMENT ON COLUMN dso.trefwoord.id
	IS 'Internal id of the keyword'
;

COMMENT ON COLUMN dso.trefwoord.trefwoord
	IS 'Keyword associated with a workItem'
;

COMMENT ON TABLE dso.werkzaamheid
	IS 'Contains the various workItems (werkzaamheden) as defined by the DSO.'
;

COMMENT ON COLUMN dso.werkzaamheid.id
	IS 'Internal id of the workItem'
;

COMMENT ON COLUMN dso.werkzaamheid.urn
	IS 'Unique Id of the workItem'
;

COMMENT ON COLUMN dso.werkzaamheid.omschrijving
	IS 'Descriptive text of the workItem'
;

COMMENT ON COLUMN dso.werkzaamheid.functionele_structuur_ref
	IS 'Link to a webpage with de explanation of the workItem'
;

COMMENT ON COLUMN dso.werkzaamheid.link
	IS 'URL pointing to this workItem in the DSO api'
;

COMMENT ON COLUMN dso.werkzaamheid.scope_id
	IS 'Link the scope that defines the scope of the workItem related to BESI'
;

COMMENT ON COLUMN dso.werkzaamheid.valide_van
	IS 'start validity of the workItem in relationship with BESI'
;

COMMENT ON COLUMN dso.werkzaamheid.valide_tot
	IS 'endt validity of the workItem in relationship with BESI'
;

COMMENT ON TABLE dso.werkzaamheid_trefwoord
	IS 'Defines which keywords are linked to a workItem'
;

COMMENT ON COLUMN dso.werkzaamheid_trefwoord.werkzaamheid_id
	IS 'reference to the workItem using the internal id'
;

COMMENT ON COLUMN dso.werkzaamheid_trefwoord.trefwoord_id
	IS 'reference to the keyword using the internal id'
;


/* IMNA-9871 Besi new database user account */
GRANT SELECT ON dso.werkzaamheid TO besi_geoweb;
GRANT SELECT ON dso.werkzaamheid_trefwoord TO besi_geoweb;
GRANT SELECT ON dso.trefwoord TO besi_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA dso TO anlb_sqlpad;
GRANT SELECT ON ALL TABLES IN SCHEMA dso TO besi_readonly;