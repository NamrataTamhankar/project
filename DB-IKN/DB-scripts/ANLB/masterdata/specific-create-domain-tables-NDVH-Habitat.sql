\echo "Starting deployment of NDVH masterdata IMNA-2422 - Habitat Masterdata"

-- SCHEMA: masterdata

GRANT USAGE ON SCHEMA masterdata TO ndvh_geoweb;

/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_bronhouder
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_bronhouder
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_kwaliteit
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_kwaliteit
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_kwaliteit_t0
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_kwaliteit_t0
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_kwaliteit_tx
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_kwaliteit_tx
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_package_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_package_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_package_versie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_package_versie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_type_t0
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_type_t0
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_habitat_type_tx
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_habitat_type_tx
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_methodiek_document_versie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_methodiek_document_versie
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natura_2000_bijdrage
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_natura_2000_bijdrage
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natura_2000_karterings_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_natura_2000_karterings_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natura_2000_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_natura_2000_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_package_kwaliteit
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;
ALTER TABLE masterdata.dmn_package_kwaliteit
    OWNER to anlb;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder','PK_dmn_bronhouder',
'ALTER TABLE masterdata.dmn_bronhouder ADD CONSTRAINT PK_dmn_bronhouder
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bronhouder','UN_code_bronhouder',
'ALTER TABLE masterdata.dmn_bronhouder ADD CONSTRAINT UN_code_bronhouder UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit','PK_dmn_habitat_kwaliteit',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit ADD CONSTRAINT PK_dmn_habitat_kwaliteit
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit','UN_code_habitat_kwaliteit',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit ADD CONSTRAINT UN_code_habitat_kwaliteit UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit_t0','PK_dmn_habitat_kwaliteit_to',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit_t0 ADD CONSTRAINT PK_dmn_habitat_kwaliteit_to
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit_t0','UN_code_habitat_kwaliteit_to',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit_t0 ADD CONSTRAINT UN_code_habitat_kwaliteit_to UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit_tx','PK_dmn_habitat_kwaliteit_tx',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit_tx ADD CONSTRAINT PK_dmn_habitat_kwaliteit_tx
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_kwaliteit_tx','UN_code_habitat_kwaliteit_tx',
'ALTER TABLE masterdata.dmn_habitat_kwaliteit_tx ADD CONSTRAINT UN_code_habitat_kwaliteit_tx UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_package_type','PK_dmn_habitat_package_type',
'ALTER TABLE masterdata.dmn_habitat_package_type ADD CONSTRAINT PK_dmn_habitat_package_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_package_type','UN_code_habitat_package_type',
'ALTER TABLE masterdata.dmn_habitat_package_type ADD CONSTRAINT UN_code_habitat_package_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_package_versie','PK_dmn_habitat_package_versie',
'ALTER TABLE masterdata.dmn_habitat_package_versie ADD CONSTRAINT PK_dmn_habitat_package_versie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_package_versie','UN_code_habitat_package_versie',
'ALTER TABLE masterdata.dmn_habitat_package_versie ADD CONSTRAINT UN_code_habitat_package_versie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type','PK_dmn_habitat_type',
'ALTER TABLE masterdata.dmn_habitat_type ADD CONSTRAINT PK_dmn_habitat_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type','UN_code_habitat_type',
'ALTER TABLE masterdata.dmn_habitat_type ADD CONSTRAINT UN_code_habitat_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type_t0','PK_dmn_habitat_type_to',
'ALTER TABLE masterdata.dmn_habitat_type_t0 ADD CONSTRAINT PK_dmn_habitat_type_to
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type_t0','UN_code_habitat_type_to',
'ALTER TABLE masterdata.dmn_habitat_type_t0 ADD CONSTRAINT UN_code_habitat_type_to UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type_tx','PK_dmn_habitat_type_tx',
'ALTER TABLE masterdata.dmn_habitat_type_tx ADD CONSTRAINT PK_dmn_habitat_type_tx
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_habitat_type_tx','UN_code_habitat_type_tx',
'ALTER TABLE masterdata.dmn_habitat_type_tx ADD CONSTRAINT UN_code_habitat_type_tx UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_methodiek_document_versie','PK_dmn_methodiek_document_versie',
'ALTER TABLE masterdata.dmn_methodiek_document_versie ADD CONSTRAINT PK_dmn_methodiek_document_versie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_methodiek_document_versie','UN_code_methodiek_docuement_versie',
'ALTER TABLE masterdata.dmn_methodiek_document_versie ADD CONSTRAINT UN_code_methodiek_docuement_versie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_bijdrage','PK_dmn_natura_2000_bijdrage',
'ALTER TABLE masterdata.dmn_natura_2000_bijdrage ADD CONSTRAINT PK_dmn_natura_2000_bijdrage
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_bijdrage','UN_code_natura_2000_bijdrage',
'ALTER TABLE masterdata.dmn_natura_2000_bijdrage ADD CONSTRAINT UN_code_natura_2000_bijdrage UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_karterings_type','PK_dmn_natura_2000_karterings_type',
'ALTER TABLE masterdata.dmn_natura_2000_karterings_type ADD CONSTRAINT PK_dmn_natura_2000_karterings_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_karterings_type','UN_code_natura_2000_katerings_type',
'ALTER TABLE masterdata.dmn_natura_2000_karterings_type ADD CONSTRAINT UN_code_natura_2000_katerings_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_type','PK_dmn_natura_2000_type',
'ALTER TABLE masterdata.dmn_natura_2000_type ADD CONSTRAINT PK_dmn_natura_2000_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natura_2000_type','UN_code_natura_2000_type',
'ALTER TABLE masterdata.dmn_natura_2000_type ADD CONSTRAINT UN_code_natura_2000_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_package_kwaliteit','PK_dmn_package_kwaliteit',
'ALTER TABLE masterdata.dmn_package_kwaliteit ADD CONSTRAINT PK_dmn_package_kwaliteit
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_package_kwaliteit','UN_code_package_kwaliteit',
'ALTER TABLE masterdata.dmn_package_kwaliteit ADD CONSTRAINT UN_code_package_kwaliteit UNIQUE (code)
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE masterdata.dmn_bronhouder
	IS 'List of Organizations that claim responsibility for a set of Natura 2000 Areas.  Code should equal the name of the role in LDAP. Roles can be found in ou=groups,dc=cvd,dc=gboApps,dc=gbo,dc=nl'
;

COMMENT ON TABLE masterdata.dmn_habitat_kwaliteit
	IS 'G = Goed M = Matig NB = Onbekend'
;

COMMENT ON TABLE masterdata.dmn_habitat_kwaliteit_t0
	IS 'G = Goed M = Matig NB = Onbekend'
;

COMMENT ON TABLE masterdata.dmn_habitat_kwaliteit_tx
	IS 'G = Goed M = Matig'
;

COMMENT ON TABLE masterdata.dmn_habitat_package_type
	IS 'H = Habitat L = Leefgebied'
;

COMMENT ON TABLE masterdata.dmn_habitat_package_versie
	IS 'Waardes  T0	Situatie rond aanwijzings besluit T1	12 jaar na aanwijzing T2	24 jaar na aanwijzing'
;

COMMENT ON TABLE masterdata.dmn_natura_2000_bijdrage
	IS 'Betekenis van het gebied, naar oppervlakte van het habitattype: oppervlakte in het onderhavige gebied uitgedrukt als percentage van de landelijke oppervlakte:   	-     A4: >75%; 	-     A3: 50-75%; 	-     A2: 30-50%; 	-     A1: 15-30%; 	-     B2: 6-15%; 	-     B1: 2-6%; 	-     C: <2%'
;

COMMENT ON TABLE masterdata.dmn_natura_2000_karterings_type
	IS 'L =  Leefgebiedtype, vegetatietypen gedeeltelijk kwalificerend H = Habitattype conform habitatrichtlijn ZGH = Zoekgebied voor een habitattype conform habitatrichtlijn ZGL =  Zoekgebied voor leefgebiedtype, vegetatietypen gedeeltelijk kwalificerend Lg = Leefgebied voor soorten ZGLg = Zoekgebied voor een leefgebied voor soorten'
;

COMMENT ON TABLE masterdata.dmn_natura_2000_type
	IS 'HR = Habitat Richtlijn VR = Vogel Richtlijn VR+HR = Vogel en Habitat Richtlijn HR Groeve = Habitat Groeve'
;

COMMENT ON TABLE masterdata.dmn_package_kwaliteit
	IS 'G = Goed,  N = Niet beoordeeld  O = Onvoldoende'
;

GRANT SELECT ON masterdata.provinces TO ndvh_geoweb;
GRANT SELECT ON masterdata.dmn_habitat_package_versie TO ndvh_geoweb;
GRANT SELECT ON masterdata.dmn_habitat_type_t0 TO ndvh_geoweb;
GRANT SELECT ON masterdata.dmn_habitat_type_tx TO ndvh_geoweb;
GRANT SELECT ON masterdata.dmn_bronhouder TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;

