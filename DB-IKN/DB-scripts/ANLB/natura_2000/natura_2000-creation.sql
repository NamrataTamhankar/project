\echo "Starting deployment of NDVH masterdata IMNA-2350 - Creation"

-- SCHEMA: natura_2000

-- DROP SCHEMA natura_2000 ;

CREATE SCHEMA IF NOT EXISTS natura_2000
    AUTHORIZATION anlb;


GRANT USAGE ON SCHEMA natura_2000 TO anlb_sqlpad;
GRANT USAGE ON SCHEMA natura_2000 TO ndvh_geoweb;

GRANT ALL ON SCHEMA natura_2000 TO anlb;

/* Create Sequences */

CREATE SEQUENCE IF NOT EXISTS natura_2000.n2000_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE natura_2000.n2000_seq
    OWNER TO anlb
;

/* Create Tables */

CREATE TABLE IF NOT EXISTS natura_2000.natura_2000
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	nummer integer NOT NULL,    -- unique number of the nature 2000 area
	naam char(100) NULL,    -- official name 
	beheerplan_datum date NULL,
	beheerplan_url varchar(1024) NULL,
	overbelasting_stikstof boolean NOT NULL,
	oppervlakte_totaal decimal(10,2) NOT NULL,
	oppervlakte_hr decimal(10,2) NOT NULL,
	oppervlakte_vr decimal(10,2) NOT NULL
)
;
ALTER TABLE natura_2000.natura_2000
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_eu_karterings_typen
(
	natura_2000_eu_typen_id bigint NOT NULL,
	natura_2000_karterings_type_id bigint NOT NULL
)
;
ALTER TABLE natura_2000.natura_2000_eu_karterings_typen
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_eu_typen
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	code char(4) NOT NULL,
	description char(100) NULL,
	minimum_oppervlak integer NOT NULL
)
;
ALTER TABLE natura_2000.natura_2000_eu_typen
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_eu_typen_variant
(
	natura_2000_eu_typen_id bigint NOT NULL,
	volg_nummer integer NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	variant_code char(10) NOT NULL,
	variant_description char(100) NULL
)
;
ALTER TABLE natura_2000.natura_2000_eu_typen_variant
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_gebied
(
	natura_2000_id bigint NOT NULL,
	volg_nummer integer NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	vhn_new integer NOT NULL,    -- Elk vlak in het Natura2000 productiebestand heeft nu in het attribuut VHN een waarde van 1 t/m 7, waaruit de oorspronkelijke bescherming is af te leiden:  	- VHN = 1 alleen Vogelrichtlijngebied 	- VHN = 2 alleen Habitatrichtlijngebied 	- VHN = 3 (1+2) zowel Vogel- als Habitatrichtlijngebied 	- VHN = 4 alleen NBwet-gebied 	- VHN = 5 (1+4) zowel Vogelrichtlijn- als NBwet-gebied 	- VHN = 6 (2+4) zowel Habitatrichtlijn- als NBwet-gebied 	- VHN = 7 (1+2+4) zowel Vogelrichtlijn- als Habitatrichtlijn- als NBwet-gebied   	- VHN = 8  gebruikt omaan te geven dat het vlak vervallen    	- VHN = 9 in 2015 zijn de ondergrondse kalksteengroeven in ZuidLimburg toegevoegd aan het basisbestand
	bescherming_id bigint NOT NULL,    -- Type of area. HR = Habitat Richtlijn VR = Vogel Richlijn VR+HR = Vogel en Habitat richtlijn
	sitecode_v char(24) NULL,    -- Inspire SiteCode for Vogel ricthlijn
	sitecode_h char(24) NULL,    -- nspire SiteCode for Habitat ricthlijn
	status text NULL,    -- status text 
	kadaster char(24) NULL,    -- Identification for this area at the kadaster
	staatscourant char(24) NULL,    -- Publication number that announced the creation of this area
	geom geometry NOT NULL
)
;
ALTER TABLE natura_2000.natura_2000_gebied
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_gebied_voortouwnemer
(
	natura_2000_id bigint NOT NULL,
	voortouw_nemer_id bigint NOT NULL
)
;
ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_habitat_doelstelling
(
	natura_2000_id bigint NOT NULL,
	habitat_type_id bigint NOT NULL,
	status varchar(50) NOT NULL,
	oppervlakte_doel char(5) NULL,    -- Mogelijke waarden:  	- = 	- =(<) 	- > 	- > (<)
	kwaliteits_doel char(5) NULL,    -- Mogelijke waarden:  	- = 	- >
	relatieve_bijdrage_id bigint NULL
)
;
ALTER TABLE natura_2000.natura_2000_habitat_doelstelling
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_sub_typen
(
	natura_2000_eu_typen_id bigint NOT NULL,
	volg_nummer integer NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	sub_type_code char(1) NOT NULL,
	sub_type_description char(100) NULL
)
;
ALTER TABLE natura_2000.natura_2000_sub_typen
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS natura_2000.natura_2000_sub_typen_variant
(
	natura_2000_eu_typen_id bigint NOT NULL,
	natura_2000_sub_typen_natura_2000_sub_typen integer NOT NULL,
	volg_nummer integer NOT NULL   DEFAULT NEXTVAL(('n2000_seq'::text)::regclass),
	sub_type_variant_code char(10) NOT NULL,
	sub_type_variant_description char(100) NULL
)
;
ALTER TABLE natura_2000.natura_2000_sub_typen_variant
    OWNER to anlb;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000','PK_natura_2000',
'ALTER TABLE natura_2000.natura_2000 ADD CONSTRAINT PK_natura_2000
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000','UN_natura_2000_nummer',
'ALTER TABLE natura_2000.natura_2000 ADD CONSTRAINT UN_natura_2000_nummer UNIQUE (nummer,begin_geldigheid)
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_karterings_typen','PK_natura_2000_eu_karterings_typen',
'ALTER TABLE natura_2000.natura_2000_eu_karterings_typen ADD CONSTRAINT PK_natura_2000_eu_karterings_typen
	PRIMARY KEY (natura_2000_eu_typen_id,natura_2000_karterings_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_eu_karterings_typen_dmn_natura_2000_kart_typ ON natura_2000.natura_2000_eu_karterings_typen (natura_2000_karterings_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_eu_karterings_typen_natura_2000_eu_typen ON natura_2000.natura_2000_eu_karterings_typen (natura_2000_eu_typen_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_typen','PK_natura_2000_eu_typen',
'ALTER TABLE natura_2000.natura_2000_eu_typen ADD CONSTRAINT PK_natura_2000_eu_typen
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_typen_variant','PK_natura_2000_eu_typen_variant',
'ALTER TABLE natura_2000.natura_2000_eu_typen_variant ADD CONSTRAINT PK_natura_2000_eu_typen_variant
	PRIMARY KEY (natura_2000_eu_typen_id,volg_nummer)
;');

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_eu_typen_variant_natura_2000_eu_typen ON natura_2000.natura_2000_eu_typen_variant (natura_2000_eu_typen_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied','PK_natura_2000_gebied',
'ALTER TABLE natura_2000.natura_2000_gebied ADD CONSTRAINT PK_natura_2000_gebied
	PRIMARY KEY (natura_2000_id,volg_nummer)
;');

CREATE INDEX IF NOT EXISTS IXFK_n2000_gebied_dmn_natura_2000_type ON natura_2000.natura_2000_gebied (bescherming_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_n2000_gebied_natura_2000 ON natura_2000.natura_2000_gebied (natura_2000_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied_voortouwnemer','PK_natura_2000_gebied_voortouwnemer',
'ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer ADD CONSTRAINT PK_natura_2000_gebied_voortouwnemer
	PRIMARY KEY (natura_2000_id,voortouw_nemer_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_n2000_gebied_voortouwnemer ON natura_2000.natura_2000_gebied_voortouwnemer (natura_2000_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_gebied_voortouwnemer_dmn_bronhouder ON natura_2000.natura_2000_gebied_voortouwnemer (voortouw_nemer_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_habitat_doelstelling','PK_natura_2000_habitat_doelstelling',
'ALTER TABLE natura_2000.natura_2000_habitat_doelstelling ADD CONSTRAINT PK_natura_2000_habitat_doelstelling
	PRIMARY KEY (natura_2000_id,habitat_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_habitat_doelstelling_dmn_habitat_type ON natura_2000.natura_2000_habitat_doelstelling (habitat_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_habitat_doelstelling_dmn_natura_2000_bijdrage ON natura_2000.natura_2000_habitat_doelstelling (relatieve_bijdrage_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_habitat_doelstelling_natura_2000 ON natura_2000.natura_2000_habitat_doelstelling (natura_2000_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_sub_typen','PK_natura_2000_sub_typen',
'ALTER TABLE natura_2000.natura_2000_sub_typen ADD CONSTRAINT PK_natura_2000_sub_typen
	PRIMARY KEY (natura_2000_eu_typen_id,volg_nummer)
;');

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_sub_typen_natura_2000_eu_typen ON natura_2000.natura_2000_sub_typen (natura_2000_eu_typen_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_sub_typen_variant','PK_natura_2000_sub_typen_variant',
'ALTER TABLE natura_2000.natura_2000_sub_typen_variant ADD CONSTRAINT PK_natura_2000_sub_typen_variant
	PRIMARY KEY (natura_2000_eu_typen_id,natura_2000_sub_typen_natura_2000_sub_typen,volg_nummer)
;');

CREATE INDEX IF NOT EXISTS IXFK_natura_2000_sub_typen_variant_natura_2000_sub_typen ON natura_2000.natura_2000_sub_typen_variant (natura_2000_eu_typen_id ASC,natura_2000_sub_typen_natura_2000_sub_typen ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_karterings_typen','FK_natura_2000_eu_karterings_typen_dmn_natura_2000_kart_typ',
'ALTER TABLE natura_2000.natura_2000_eu_karterings_typen ADD CONSTRAINT FK_natura_2000_eu_karterings_typen_dmn_natura_2000_kart_typ
	FOREIGN KEY (natura_2000_karterings_type_id) REFERENCES masterdata.dmn_natura_2000_karterings_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_karterings_typen','FK_natura_2000_eu_karterings_typen_natura_2000_eu_typen',
'ALTER TABLE natura_2000.natura_2000_eu_karterings_typen ADD CONSTRAINT FK_natura_2000_eu_karterings_typen_natura_2000_eu_typen
	FOREIGN KEY (natura_2000_eu_typen_id) REFERENCES natura_2000.natura_2000_eu_typen (id) ON DELETE Cascade ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_eu_typen_variant','FK_natura_2000_eu_typen_variant_natura_2000_eu_typen',
'ALTER TABLE natura_2000.natura_2000_eu_typen_variant ADD CONSTRAINT FK_natura_2000_eu_typen_variant_natura_2000_eu_typen
	FOREIGN KEY (natura_2000_eu_typen_id) REFERENCES natura_2000.natura_2000_eu_typen (id) ON DELETE Cascade ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied','FK_n2000_gebied_dmn_natura_2000_type',
'ALTER TABLE natura_2000.natura_2000_gebied ADD CONSTRAINT FK_n2000_gebied_dmn_natura_2000_type
	FOREIGN KEY (bescherming_id) REFERENCES masterdata.dmn_natura_2000_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied','FK_n2000_gebied_natura_2000',
'ALTER TABLE natura_2000.natura_2000_gebied ADD CONSTRAINT FK_n2000_gebied_natura_2000
	FOREIGN KEY (natura_2000_id) REFERENCES natura_2000.natura_2000 (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied_voortouwnemer','FK_n2000_gebied_voortouwnemer',
'ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer ADD CONSTRAINT FK_n2000_gebied_voortouwnemer
	FOREIGN KEY (natura_2000_id) REFERENCES natura_2000.natura_2000 (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_gebied_voortouwnemer','FK_natura_2000_gebied_voortouwnemer_dmn_bronhouder',
'ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer ADD CONSTRAINT FK_natura_2000_gebied_voortouwnemer_dmn_bronhouder
	FOREIGN KEY (voortouw_nemer_id) REFERENCES masterdata.dmn_bronhouder (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_habitat_doelstelling','FK_natura_2000_habitat_doelstelling_dmn_habitat_type',
'ALTER TABLE natura_2000.natura_2000_habitat_doelstelling ADD CONSTRAINT FK_natura_2000_habitat_doelstelling_dmn_habitat_type
	FOREIGN KEY (habitat_type_id) REFERENCES masterdata.dmn_habitat_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_habitat_doelstelling','FK_natura_2000_habitat_doelstelling_dmn_natura_2000_bijdrage',
'ALTER TABLE natura_2000.natura_2000_habitat_doelstelling ADD CONSTRAINT FK_natura_2000_habitat_doelstelling_dmn_natura_2000_bijdrage
	FOREIGN KEY (relatieve_bijdrage_id) REFERENCES masterdata.dmn_natura_2000_bijdrage (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_habitat_doelstelling','FK_natura_2000_habitat_doelstelling_natura_2000',
'ALTER TABLE natura_2000.natura_2000_habitat_doelstelling ADD CONSTRAINT FK_natura_2000_habitat_doelstelling_natura_2000
	FOREIGN KEY (natura_2000_id) REFERENCES natura_2000.natura_2000 (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_sub_typen','FK_natura_2000_sub_typen_natura_2000_eu_typen',
'ALTER TABLE natura_2000.natura_2000_sub_typen ADD CONSTRAINT FK_natura_2000_sub_typen_natura_2000_eu_typen
	FOREIGN KEY (natura_2000_eu_typen_id) REFERENCES natura_2000.natura_2000_eu_typen (id) ON DELETE Cascade ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('natura_2000','natura_2000_sub_typen_variant','FK_natura_2000_sub_typen_variant_natura_2000_sub_typen',
'ALTER TABLE natura_2000.natura_2000_sub_typen_variant ADD CONSTRAINT FK_natura_2000_sub_typen_variant_natura_2000_sub_typen
	FOREIGN KEY (natura_2000_eu_typen_id,natura_2000_sub_typen_natura_2000_sub_typen) REFERENCES natura_2000.natura_2000_sub_typen (natura_2000_eu_typen_id,volg_nummer) ON DELETE Cascade ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE natura_2000.natura_2000
	IS 'Bron: http://www.nationaalgeoregister.nl/geonetwork/srv/dut/catalog.search#/metadata/32b1eb9e-c54f-4598-92d2-328eb77fa0d3?tab=general  https://geodata.nationaalgeoregister.nl/natura2000/wfs'
;

COMMENT ON COLUMN natura_2000.natura_2000.nummer
	IS 'unique number of the nature 2000 area'
;

COMMENT ON COLUMN natura_2000.natura_2000.naam
	IS 'official name '
;

COMMENT ON TABLE natura_2000.natura_2000_eu_karterings_typen
	IS 'Indicates for what type of map the EUType can be used. So euCode	karteringsType 0000	H 0000	L 0000	ZGH 0000	ZGL 2180	H 2180	L 2180	ZGH 2180	ZGL 9999	L 9999	H 01	Lg 01	ZGLg'
;

COMMENT ON TABLE natura_2000.natura_2000_eu_typen
	IS 'Contains the EU codes for the different types. So Like Code 	Description 0000 	afwezig / nothing exists 1110	Permanent overstroomde zandbanken 1130 	Estuaria 1140	Slik- en zandplaten'
;

COMMENT ON TABLE natura_2000.natura_2000_eu_typen_variant
	IS 'Specifies per EuType what variants are available So EuCode	variantCode 	Description 3140 	az		in afgesloten zeearmen 3140 	hz		op hogere zandgronden 7120 	ah		actief hoogveen'
;

COMMENT ON TABLE natura_2000.natura_2000_gebied
	IS 'Bron: http://www.nationaalgeoregister.nl/geonetwork/srv/dut/catalog.search#/metadata/32b1eb9e-c54f-4598-92d2-328eb77fa0d3?tab=general  https://geodata.nationaalgeoregister.nl/natura2000/wfs'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.vhn_new
	IS 'Elk vlak in het Natura2000 productiebestand heeft nu in het attribuut VHN een waarde van 1 t/m 7, waaruit de oorspronkelijke bescherming is af te leiden:  	- VHN = 1 alleen Vogelrichtlijngebied 	- VHN = 2 alleen Habitatrichtlijngebied 	- VHN = 3 (1+2) zowel Vogel- als Habitatrichtlijngebied 	- VHN = 4 alleen NBwet-gebied 	- VHN = 5 (1+4) zowel Vogelrichtlijn- als NBwet-gebied 	- VHN = 6 (2+4) zowel Habitatrichtlijn- als NBwet-gebied 	- VHN = 7 (1+2+4) zowel Vogelrichtlijn- als Habitatrichtlijn- als NBwet-gebied   	- VHN = 8  gebruikt omaan te geven dat het vlak vervallen    	- VHN = 9 in 2015 zijn de ondergrondse kalksteengroeven in ZuidLimburg toegevoegd aan het basisbestand'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.bescherming_id
	IS 'Type of area. HR = Habitat Richtlijn VR = Vogel Richlijn VR+HR = Vogel en Habitat richtlijn'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.sitecode_v
	IS 'Inspire SiteCode for Vogel ricthlijn'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.sitecode_h
	IS 'nspire SiteCode for Habitat ricthlijn'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.status
	IS 'status text '
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.kadaster
	IS 'Identification for this area at the kadaster'
;

COMMENT ON COLUMN natura_2000.natura_2000_gebied.staatscourant
	IS 'Publication number that announced the creation of this area'
;

COMMENT ON TABLE natura_2000.natura_2000_gebied_voortouwnemer
	IS 'Bron: LNV 20190702_LNV_Voortouwnemers.xlsx'
;

COMMENT ON TABLE natura_2000.natura_2000_habitat_doelstelling
	IS 'Bron: LNV 20180219_Aangewezen_habitattypen.xlsx'
;

COMMENT ON COLUMN natura_2000.natura_2000_habitat_doelstelling.oppervlakte_doel
	IS 'Mogelijke waarden:  	- = 	- =(<) 	- > 	- > (<)'
;

COMMENT ON COLUMN natura_2000.natura_2000_habitat_doelstelling.kwaliteits_doel
	IS 'Mogelijke waarden:  	- = 	- >'
;

COMMENT ON TABLE natura_2000.natura_2000_sub_typen
	IS 'Specifies per EU-Type what sub-types are allowed.  So  EuType 	SubType 	Description 1110 	A		Permanent overstroomde zandbanken (getijdengebied) 1110	B		Permanent overstroomde zandbanken (Noordzee-kustzone) 1140	A		 Slik- en zandplaten (getijdengebied)  Note that not all EU-Types will have sub-types defined.'
;

COMMENT ON TABLE natura_2000.natura_2000_sub_typen_variant
	IS 'Specifies per SubType what variants are available So EuCode	subType	variantCode 	Description 2180	A	be		berken-eikenbos 2180	A	o		overig 2190	A	om		oligo- tot mesotrofe vormen'
;

GRANT SELECT ON natura_2000.natura_2000 TO ndvh_geoweb;
GRANT SELECT ON natura_2000.natura_2000_gebied TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA natura_2000 TO anlb_sqlpad;

