\echo "Starting deployment of masterdata - create specific tables for SNL"

CREATE TABLE IF NOT EXISTS masterdata.lnk_table_ambitiegebied_type
(
	ambitiegebied_type_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL
)
;

ALTER TABLE masterdata.lnk_table_ambitiegebied_type
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.lnk_table_beheer_functies
(
	natuur_type_id bigint NOT NULL,
	beheer_functie_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_beheer_functies
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.lnk_table_beheer_type_regeling
(
	type_regeling_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_beheer_type_regeling
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.lnk_table_beheer_typen
(
	natuur_type_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_beheer_typen
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_beheergebied_type
(
	beheergebied_type_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL
)
;

ALTER TABLE masterdata.lnk_table_beheergebied_type
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_beheerpakket
(
	beheer_type_id bigint NOT NULL,
	beheer_pakket_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_beheerpakket
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.lnk_table_provincie_deelgebied
(
	provincie_id bigint NOT NULL,
	deelgebied_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_provincie_deelgebied
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_provincie_type_regeling
(
	provincie_id bigint NOT NULL,
	type_regeling_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.lnk_table_provincie_type_regeling
    OWNER to anlb;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_ambitiegebied_type','PK_lnk_table_ambitiegebied_type',
'ALTER TABLE masterdata.lnk_table_ambitiegebied_type ADD CONSTRAINT PK_lnk_table_ambitiegebied_type
	PRIMARY KEY (ambitiegebied_type_id,beheer_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_ambitiegebied_type_01 ON masterdata.lnk_table_ambitiegebied_type (ambitiegebied_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_04 ON masterdata.lnk_table_ambitiegebied_type (beheer_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_functies','PK_lnk_table_beheer_functies',
'ALTER TABLE masterdata.lnk_table_beheer_functies ADD CONSTRAINT PK_lnk_table_beheer_functies
	PRIMARY KEY (natuur_type_id,beheer_functie_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_natuur_type ON masterdata.lnk_table_beheer_functies (natuur_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_type_regeling','PK_lnk_table_beheer_type_regeling',
'ALTER TABLE masterdata.lnk_table_beheer_type_regeling ADD CONSTRAINT PK_lnk_table_beheer_type_regeling
	PRIMARY KEY (type_regeling_id,beheer_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_6 ON masterdata.lnk_table_beheer_type_regeling (beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_snl_1 ON masterdata.lnk_table_beheer_type_regeling (type_regeling_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_typen','PK_lnk_table_beheer_typen',
'ALTER TABLE masterdata.lnk_table_beheer_typen ADD CONSTRAINT PK_lnk_table_beheer_typen
	PRIMARY KEY (natuur_type_id,beheer_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_02 ON masterdata.lnk_table_beheer_typen (beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dmn_natuur_type_01 ON masterdata.lnk_table_beheer_typen (natuur_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheergebied_type','PK_lnk_table_beheergebied_type',
'ALTER TABLE masterdata.lnk_table_beheergebied_type ADD CONSTRAINT PK_lnk_table_beheergebied_type
	PRIMARY KEY (beheergebied_type_id,beheer_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_03 ON masterdata.lnk_table_beheergebied_type (beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheergebied_type_01 ON masterdata.lnk_table_beheergebied_type (beheergebied_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheerpakket','PK_lnk_table_beheerpakket',
'ALTER TABLE masterdata.lnk_table_beheerpakket ADD CONSTRAINT PK_lnk_table_beheerpakket
	PRIMARY KEY (beheer_type_id,beheer_pakket_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_pakket ON masterdata.lnk_table_beheerpakket (beheer_pakket_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dmn_beheer_type_01 ON masterdata.lnk_table_beheerpakket (beheer_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_deelgebied','PK_lnk_table_provincie_deelgebied',
'ALTER TABLE masterdata.lnk_table_provincie_deelgebied ADD CONSTRAINT PK_lnk_table_provincie_deelgebied
	PRIMARY KEY (provincie_id,deelgebied_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_provincie_deelgebied_dmn_deelgebied ON masterdata.lnk_table_provincie_deelgebied (deelgebied_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_provincie_deelgebied_dmn_provincie_code ON masterdata.lnk_table_provincie_deelgebied (provincie_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_type_regeling','PK_lnk_table_provincie_type_regeling',
'ALTER TABLE masterdata.lnk_table_provincie_type_regeling ADD CONSTRAINT PK_lnk_table_provincie_type_regeling
	PRIMARY KEY (provincie_id,type_regeling_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_provincie_type_regeling_dmn_provincie_code ON masterdata.lnk_table_provincie_type_regeling (provincie_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_provincie_type_regeling_dmn_type_regeling ON masterdata.lnk_table_provincie_type_regeling (type_regeling_id ASC)
;


/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_ambitiegebied_type','FK_dmn_ambitiegebied_type_01',
'ALTER TABLE masterdata.lnk_table_ambitiegebied_type ADD CONSTRAINT FK_dmn_ambitiegebied_type_01
	FOREIGN KEY (ambitiegebied_type_id) REFERENCES masterdata.dmn_ambitiegebied_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_ambitiegebied_type','FK_dmn_beheer_type_04',
'ALTER TABLE masterdata.lnk_table_ambitiegebied_type ADD CONSTRAINT FK_dmn_beheer_type_04
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_functies','FK_dmn_beheer_functie',
'ALTER TABLE masterdata.lnk_table_beheer_functies ADD CONSTRAINT FK_dmn_beheer_functie
	FOREIGN KEY (beheer_functie_id) REFERENCES masterdata.dmn_beheer_functie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_functies','FK_dmn_natuur_type_02',
'ALTER TABLE masterdata.lnk_table_beheer_functies ADD CONSTRAINT FK_dmn_natuur_type_02
	FOREIGN KEY (natuur_type_id) REFERENCES masterdata.dmn_natuur_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_type_regeling','FK_dmn_beheer_type_6',
'ALTER TABLE masterdata.lnk_table_beheer_type_regeling ADD CONSTRAINT FK_dmn_beheer_type_6
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_type_regeling','FK_dmn_beheer_type_snl_1',
'ALTER TABLE masterdata.lnk_table_beheer_type_regeling ADD CONSTRAINT FK_dmn_beheer_type_snl_1
	FOREIGN KEY (type_regeling_id) REFERENCES masterdata.dmn_type_regeling_snl (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_type_regeling','FK_dmn_beheer_type_snl_1',
'ALTER TABLE masterdata.lnk_table_beheer_type_regeling ADD CONSTRAINT FK_dmn_beheer_type_snl_1
	FOREIGN KEY (type_regeling_id) REFERENCES masterdata.dmn_type_regeling_snl (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_typen','FK_dmn_beheer_type_02',
'ALTER TABLE masterdata.lnk_table_beheer_typen ADD CONSTRAINT FK_dmn_beheer_type_02
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheer_typen','FK_dmn_natuur_type_01',
'ALTER TABLE masterdata.lnk_table_beheer_typen ADD CONSTRAINT FK_dmn_natuur_type_01
	FOREIGN KEY (natuur_type_id) REFERENCES masterdata.dmn_natuur_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheergebied_type','FK_dmn_beheer_type_03',
'ALTER TABLE masterdata.lnk_table_beheergebied_type ADD CONSTRAINT FK_dmn_beheer_type_03
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheergebied_type','FK_dmn_beheergebied_type_01',
'ALTER TABLE masterdata.lnk_table_beheergebied_type ADD CONSTRAINT FK_dmn_beheergebied_type_01
	FOREIGN KEY (beheergebied_type_id) REFERENCES masterdata.dmn_beheergebied_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheerpakket','FK_dmn_beheer_pakket',
'ALTER TABLE masterdata.lnk_table_beheerpakket ADD CONSTRAINT FK_dmn_beheer_pakket
	FOREIGN KEY (beheer_pakket_id) REFERENCES masterdata.dmn_beheer_pakket (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_beheerpakket','FK_dmn_beheer_type_01',
'ALTER TABLE masterdata.lnk_table_beheerpakket ADD CONSTRAINT FK_dmn_beheer_type_01
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_deelgebied','FK_lnk_table_provincie_deelgebied_dmn_deelgebied',
'ALTER TABLE masterdata.lnk_table_provincie_deelgebied ADD CONSTRAINT FK_lnk_table_provincie_deelgebied_dmn_deelgebied
	FOREIGN KEY (deelgebied_id) REFERENCES masterdata.dmn_deelgebied (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_deelgebied','FK_lnk_table_provincie_deelgebied_dmn_provincie_code',
'ALTER TABLE masterdata.lnk_table_provincie_deelgebied ADD CONSTRAINT FK_lnk_table_provincie_deelgebied_dmn_provincie_code
	FOREIGN KEY (provincie_id) REFERENCES masterdata.dmn_provincie_code (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_type_regeling','FK_lnk_table_provincie_type_regeling_dmn_provincie_code',
'ALTER TABLE masterdata.lnk_table_provincie_type_regeling ADD CONSTRAINT FK_lnk_table_provincie_type_regeling_dmn_provincie_code
	FOREIGN KEY (provincie_id) REFERENCES masterdata.dmn_provincie_code (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_provincie_type_regeling','FK_lnk_table_provincie_type_regeling_dmn_type_regeling',
'ALTER TABLE masterdata.lnk_table_provincie_type_regeling ADD CONSTRAINT FK_lnk_table_provincie_type_regeling_dmn_type_regeling
	FOREIGN KEY (type_regeling_id) REFERENCES masterdata.dmn_type_regeling (id) ON DELETE No Action ON UPDATE No Action
;');

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;