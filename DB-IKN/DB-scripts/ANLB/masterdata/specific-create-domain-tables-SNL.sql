\echo "Starting deployment of masterdata - create specific domain tables for SNL"

/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_ambitiegebied_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_ambitiegebied_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_functie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_functie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_pakket
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_pakket
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_pakket_landschap
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_pakket_landschap
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_agrarisch
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_agrarisch
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_beschikking_niet_snl
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_beschikking_niet_snl
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_grootschaligenatuur
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_grootschaligenatuur
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_landschap
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_landschap
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_natuur
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_natuur
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_natuur_ambitie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_natuur_ambitie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_omtevormennatuur_ambitie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_omtevormennatuur_ambitie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_beheer_type_water
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheer_type_water
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_beheergebied_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_beheergebied_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_bijzonder_gebied_code
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_bijzonder_gebied_code
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_deelgebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_deelgebied
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natuur_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_natuur_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natuur_type_agrarisch
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_natuur_type_agrarisch
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.dmn_natuur_type_klimaat
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_natuur_type_klimaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_natuur_type_water
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_natuur_type_water
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_openstellings_bijdrage_type
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_openstellings_bijdrage_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_provincie_code
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_provincie_code
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_aanvraag_subsidie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_aanvraag_subsidie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_beheer_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_beheer_gebied
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_beheer_gebied_ambitie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_beheer_gebied_ambitie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_bijzonder_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_bijzonder_gebied
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_deel_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_deel_gebied
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_ehs
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_ehs
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_natuur
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_natuur
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_plan
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_plan
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_zoek_gebied_agrarisch
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_zoek_gebied_agrarisch
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_zoek_gebied_klimaat
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_zoek_gebied_klimaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_zoek_gebied_landschap
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_zoek_gebied_landschap
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_zoek_gebied_water
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_status_zoek_gebied_water
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_type_beheerder_en_eigenaar
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_type_beheerder_en_eigenaar
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_type_regeling
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_type_regeling
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_type_regeling_niet_snl
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_type_regeling_niet_snl
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.dmn_type_regeling_snl
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_type_regeling_snl
    OWNER to anlb;


/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_ambitiegebied_type','PK_dmn_ambitiegebied_type',
'ALTER TABLE masterdata.dmn_ambitiegebied_type ADD CONSTRAINT PK_dmn_ambitiegebied_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_ambitiegebied_type','un_code_ambitiegebied_type',
'ALTER TABLE masterdata.dmn_ambitiegebied_type ADD CONSTRAINT un_code_ambitiegebied_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_functie','PK_dmn_beheer_functie',
'ALTER TABLE masterdata.dmn_beheer_functie ADD CONSTRAINT PK_dmn_beheer_functie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_functie','un_code_beheer_functie',
'ALTER TABLE masterdata.dmn_beheer_functie ADD CONSTRAINT un_code_beheer_functie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_pakket','PK_dmn_beheer_pakket',
'ALTER TABLE masterdata.dmn_beheer_pakket ADD CONSTRAINT PK_dmn_beheer_pakket
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_pakket','un_code_beheer_pakket',
'ALTER TABLE masterdata.dmn_beheer_pakket ADD CONSTRAINT un_code_beheer_pakket UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_pakket_landschap','PK_dmn_beheer_pakket_landschap',
'ALTER TABLE masterdata.dmn_beheer_pakket_landschap ADD CONSTRAINT PK_dmn_beheer_pakket_landschap
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_pakket_landschap','un_code_beheer_pakket_landschap',
'ALTER TABLE masterdata.dmn_beheer_pakket_landschap ADD CONSTRAINT un_code_beheer_pakket_landschap UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type','PK_dmn_beheer_type',
'ALTER TABLE masterdata.dmn_beheer_type ADD CONSTRAINT PK_dmn_beheer_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type','un_code_beheer_type',
'ALTER TABLE masterdata.dmn_beheer_type ADD CONSTRAINT un_code_beheer_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_agrarisch','PK_dmn_beheer_type_agrarisch',
'ALTER TABLE masterdata.dmn_beheer_type_agrarisch ADD CONSTRAINT PK_dmn_beheer_type_agrarisch
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_agrarisch','un_code_beheer_type_agrarisch',
'ALTER TABLE masterdata.dmn_beheer_type_agrarisch ADD CONSTRAINT un_code_beheer_type_agrarisch UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_beschikking_niet_snl','PK_dmn_beheer_type_beschikking_niet_snl',
'ALTER TABLE masterdata.dmn_beheer_type_beschikking_niet_snl ADD CONSTRAINT PK_dmn_beheer_type_beschikking_niet_snl
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_beschikking_niet_snl','un_code_beheer_type_beschikking_niet_snl',
'ALTER TABLE masterdata.dmn_beheer_type_beschikking_niet_snl ADD CONSTRAINT un_code_beheer_type_beschikking_niet_snl UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_grootschaligenatuur','PK_dmn_gebied_type_grootschalige_natuur',
'ALTER TABLE masterdata.dmn_beheer_type_grootschaligenatuur ADD CONSTRAINT PK_dmn_gebied_type_grootschalige_natuur
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_grootschaligenatuur','un_code_gebied_type_grootschalige_natuur',
'ALTER TABLE masterdata.dmn_beheer_type_grootschaligenatuur ADD CONSTRAINT un_code_gebied_type_grootschalige_natuur UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_landschap','PK_dmn_beheer_type_landschap',
'ALTER TABLE masterdata.dmn_beheer_type_landschap ADD CONSTRAINT PK_dmn_beheer_type_landschap
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_landschap','un_code_beheer_type_landschap',
'ALTER TABLE masterdata.dmn_beheer_type_landschap ADD CONSTRAINT un_code_beheer_type_landschap UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_natuur','PK_dmn_gebied_type_natuur',
'ALTER TABLE masterdata.dmn_beheer_type_natuur ADD CONSTRAINT PK_dmn_gebied_type_natuur
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_natuur','un_code_gebied_type_natuur',
'ALTER TABLE masterdata.dmn_beheer_type_natuur ADD CONSTRAINT un_code_gebied_type_natuur UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_natuur_ambitie','PK_dmn_beheer_type_natuur_ambitie',
'ALTER TABLE masterdata.dmn_beheer_type_natuur_ambitie ADD CONSTRAINT PK_dmn_beheer_type_natuur_ambitie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_natuur_ambitie','un_code_beheer_type_natuur_ambitie',
'ALTER TABLE masterdata.dmn_beheer_type_natuur_ambitie ADD CONSTRAINT un_code_beheer_type_natuur_ambitie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_omtevormennatuur_ambitie','PK_dmn_beheer_type_omtevormennatuur_ambitie',
'ALTER TABLE masterdata.dmn_beheer_type_omtevormennatuur_ambitie ADD CONSTRAINT PK_dmn_beheer_type_omtevormennatuur_ambitie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_omtevormennatuur_ambitie','un_code_beheer_type_omtevormennatuur_ambitie',
'ALTER TABLE masterdata.dmn_beheer_type_omtevormennatuur_ambitie ADD CONSTRAINT un_code_beheer_type_omtevormennatuur_ambitie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_water','PK_dmn_beheer_type_water',
'ALTER TABLE masterdata.dmn_beheer_type_water ADD CONSTRAINT PK_dmn_beheer_type_water
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheer_type_water','un_code_beheer_type_water',
'ALTER TABLE masterdata.dmn_beheer_type_water ADD CONSTRAINT un_code_beheer_type_water UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheergebied_type','PK_dmn_gebiedgebied_type',
'ALTER TABLE masterdata.dmn_beheergebied_type ADD CONSTRAINT PK_dmn_gebiedgebied_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_beheergebied_type','un_code_beheergebied_type',
'ALTER TABLE masterdata.dmn_beheergebied_type ADD CONSTRAINT un_code_beheergebied_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bijzonder_gebied_code','PK_dmn_bijzonder_gebied_code',
'ALTER TABLE masterdata.dmn_bijzonder_gebied_code ADD CONSTRAINT PK_dmn_bijzonder_gebied_code
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_bijzonder_gebied_code','un_code_bijzonder_gebied_code',
'ALTER TABLE masterdata.dmn_bijzonder_gebied_code ADD CONSTRAINT un_code_bijzonder_gebied_code UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_deelgebied','PK_dmn_deelgebied',
'ALTER TABLE masterdata.dmn_deelgebied ADD CONSTRAINT PK_dmn_deelgebied
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_deelgebied','un_code_deelgebied',
'ALTER TABLE masterdata.dmn_deelgebied ADD CONSTRAINT un_code_deelgebied UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type','PK_dmn_natuur_type_water',
'ALTER TABLE masterdata.dmn_natuur_type ADD CONSTRAINT PK_dmn_natuur_type_water
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type','un_code_natuur_type_water',
'ALTER TABLE masterdata.dmn_natuur_type ADD CONSTRAINT un_code_natuur_type_water UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_agrarisch','PK_dmn_natuur_type_agrarisch',
'ALTER TABLE masterdata.dmn_natuur_type_agrarisch ADD CONSTRAINT PK_dmn_natuur_type_agrarisch
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_agrarisch','un_code_natuur_type_agrarisch',
'ALTER TABLE masterdata.dmn_natuur_type_agrarisch ADD CONSTRAINT un_code_natuur_type_agrarisch UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_klimaat','PK_dmn_natuur_type_klimaat',
'ALTER TABLE masterdata.dmn_natuur_type_klimaat ADD CONSTRAINT PK_dmn_natuur_type_klimaat
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_klimaat','un_code_natuur_type_klimaat',
'ALTER TABLE masterdata.dmn_natuur_type_klimaat ADD CONSTRAINT un_code_natuur_type_klimaat UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_water','PK_dmn_gebied_type',
'ALTER TABLE masterdata.dmn_natuur_type_water ADD CONSTRAINT PK_dmn_gebied_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_natuur_type_water','un_code_gebied_type',
'ALTER TABLE masterdata.dmn_natuur_type_water ADD CONSTRAINT un_code_gebied_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_openstellings_bijdrage_type','PK_dmn_openstellings_bijdrage_type',
'ALTER TABLE masterdata.dmn_openstellings_bijdrage_type ADD CONSTRAINT PK_dmn_openstellings_bijdrage_type
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_openstellings_bijdrage_type','un_code_openstellings_bijdrage_type',
'ALTER TABLE masterdata.dmn_openstellings_bijdrage_type ADD CONSTRAINT un_code_openstellings_bijdrage_type UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_provincie_code','PK_dmn_provincie_code',
'ALTER TABLE masterdata.dmn_provincie_code ADD CONSTRAINT PK_dmn_provincie_code
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_provincie_code','un_code_provincie_code',
'ALTER TABLE masterdata.dmn_provincie_code ADD CONSTRAINT un_code_provincie_code UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_aanvraag_subsidie','PK_dmn_status_aanvraag_subsidie',
'ALTER TABLE masterdata.dmn_status_aanvraag_subsidie ADD CONSTRAINT PK_dmn_status_aanvraag_subsidie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_aanvraag_subsidie','un_code_status_aanvraag_subsidie',
'ALTER TABLE masterdata.dmn_status_aanvraag_subsidie ADD CONSTRAINT un_code_status_aanvraag_subsidie UNIQUE (code)
;');


SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_beheer_gebied','PK_dmn_status_beheer_gebied',
'ALTER TABLE masterdata.dmn_status_beheer_gebied ADD CONSTRAINT PK_dmn_status_beheer_gebied
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_beheer_gebied','un_code_status_beheer_gebied',
'ALTER TABLE masterdata.dmn_status_beheer_gebied ADD CONSTRAINT un_code_status_beheer_gebied UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_beheer_gebied_ambitie','PK_dmn_status_beheer_gebied_ambitie',
'ALTER TABLE masterdata.dmn_status_beheer_gebied_ambitie ADD CONSTRAINT PK_dmn_status_beheer_gebied_ambitie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_beheer_gebied_ambitie','un_code_status_beheer_gebied_ambitie',
'ALTER TABLE masterdata.dmn_status_beheer_gebied_ambitie ADD CONSTRAINT un_code_status_beheer_gebied_ambitie UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_bijzonder_gebied','PK_dmn_status_bijzonder_gebied',
'ALTER TABLE masterdata.dmn_status_bijzonder_gebied ADD CONSTRAINT PK_dmn_status_bijzonder_gebied
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_bijzonder_gebied','un_code_status_bijzonder_gebied',
'ALTER TABLE masterdata.dmn_status_bijzonder_gebied ADD CONSTRAINT un_code_status_bijzonder_gebied UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_deel_gebied','PK_dmn_status_deel_gebied',
'ALTER TABLE masterdata.dmn_status_deel_gebied ADD CONSTRAINT PK_dmn_status_deel_gebied
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_deel_gebied','un_code_status_deel_gebied',
'ALTER TABLE masterdata.dmn_status_deel_gebied ADD CONSTRAINT un_code_status_deel_gebied UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_ehs','PK_dmn_status_ehs',
'ALTER TABLE masterdata.dmn_status_ehs ADD CONSTRAINT PK_dmn_status_ehs
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_ehs','un_code_status_ehs',
'ALTER TABLE masterdata.dmn_status_ehs ADD CONSTRAINT un_code_status_ehs UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_natuur','PK_dmn_status_natuur',
'ALTER TABLE masterdata.dmn_status_natuur ADD CONSTRAINT PK_dmn_status_natuur
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_natuur','un_code_status_natuur',
'ALTER TABLE masterdata.dmn_status_natuur ADD CONSTRAINT un_code_status_natuur UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_plan','PK_dmn_status_plan',
'ALTER TABLE masterdata.dmn_status_plan ADD CONSTRAINT PK_dmn_status_plan
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_plan','un_code_status_plan',
'ALTER TABLE masterdata.dmn_status_plan ADD CONSTRAINT un_code_status_plan UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_agrarisch','PK_dmn_status_zoek_gebied_agrarisch',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_agrarisch ADD CONSTRAINT PK_dmn_status_zoek_gebied_agrarisch
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_agrarisch','un_code_status_zoek_gebied_agrarisch',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_agrarisch ADD CONSTRAINT un_code_status_zoek_gebied_agrarisch UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_klimaat','PK_dmn_status_zoek_gebied_klimaat',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_klimaat ADD CONSTRAINT PK_dmn_status_zoek_gebied_klimaat
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_klimaat','un_code_status_zoek_gebied_klimaat',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_klimaat ADD CONSTRAINT un_code_status_zoek_gebied_klimaat UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_landschap','PK_dmn_status_zoek_gebied_landschap',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_landschap ADD CONSTRAINT PK_dmn_status_zoek_gebied_landschap
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_landschap','un_code_status_zoek_gebied_landschap',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_landschap ADD CONSTRAINT un_code_status_zoek_gebied_landschap UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_water','PK_dmn_status_zoek_gebied_water',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_water ADD CONSTRAINT PK_dmn_status_zoek_gebied_water
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_zoek_gebied_water','un_code_status_zoek_gebied_water',
'ALTER TABLE masterdata.dmn_status_zoek_gebied_water ADD CONSTRAINT un_code_status_zoek_gebied_water UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_beheerder_en_eigenaar','PK_dmn_type_beheerder_en_eigenaar',
'ALTER TABLE masterdata.dmn_type_beheerder_en_eigenaar ADD CONSTRAINT PK_dmn_type_beheerder_en_eigenaar
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_beheerder_en_eigenaar','un_code_type_beheerder_en_eigenaar',
'ALTER TABLE masterdata.dmn_type_beheerder_en_eigenaar ADD CONSTRAINT un_code_type_beheerder_en_eigenaar UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling','PK_dmn_type_regeling',
'ALTER TABLE masterdata.dmn_type_regeling ADD CONSTRAINT PK_dmn_type_regeling
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling','un_code_type_regeling',
'ALTER TABLE masterdata.dmn_type_regeling ADD CONSTRAINT un_code_type_regeling UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling_niet_snl','PK_dmn_beheer_type_pre_snl',
'ALTER TABLE masterdata.dmn_type_regeling_niet_snl ADD CONSTRAINT PK_dmn_beheer_type_pre_snl
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling_niet_snl','un_code_beheer_type_pre_snl',
'ALTER TABLE masterdata.dmn_type_regeling_niet_snl ADD CONSTRAINT un_code_beheer_type_pre_snl UNIQUE (code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling_snl','PK_dmn_beheer_type_snl',
'ALTER TABLE masterdata.dmn_type_regeling_snl ADD CONSTRAINT PK_dmn_beheer_type_snl
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_type_regeling_snl','un_code_beheer_type_snl',
'ALTER TABLE masterdata.dmn_type_regeling_snl ADD CONSTRAINT un_code_beheer_type_snl UNIQUE (code)
;');

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;









