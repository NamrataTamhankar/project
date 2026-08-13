\echo "Starting deployment of imna for rnn"

/* Create Tables */
CREATE TABLE IF NOT EXISTS imna.beheer_type_beoordelingsresultaat
(
	dossier_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	beoordelings_indicator_id bigint NOT NULL,
	kwaliteits_score_id bigint NULL,
	expert_score_oordeel_id bigint NULL,
	expert_score_uitleg varchar(200) NULL
)
;

ALTER TABLE imna.beheer_type_beoordelingsresultaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.beheer_type_tussenresultaat
(
	dossier_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	kwalificerende_kenmerk_id bigint NOT NULL,
	waarde NUMERIC(14,2) NULL
)
;

ALTER TABLE imna.beheer_type_tussenresultaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.dossier
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(100) NOT NULL,
	beschikkingsJaar smallint NULL,
	beoordelaar varchar(255) NOT NULL,
	beoordelaar_email_adres varchar(255) NOT NULL,
	eigenaar varchar(255) NOT NULL,
	object_begin_tijd timestamp without time zone NOT NULL,
	object_eind_tijd timestamp without time zone NOT NULL,
	vegetatiekarteringsJaar smallint NULL,
	dossier_naam varchar(255) NULL,
	toelichting varchar(1000) NULL,
	datum_beoordeling timestamp without time zone NULL
)
;

ALTER TABLE imna.dossier
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.dossier_beheer_type
(
	dossier_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	kwaliteits_score bigint NULL
)
;

	
CREATE TABLE IF NOT EXISTS imna.dossier_beheer_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(110) NOT NULL,    -- identification of the beheertype gebied
	originele_beheer_gebied_id bigint NOT NULL,
	is_vlak_bijgesneden boolean NOT NULL,
	geom geometry(polygon) NOT NULL
)
;

ALTER TABLE imna.dossier_beheer_gebied
    OWNER to anlb;


CREATE TABLE IF NOT EXISTS imna.dossier_beoordelings_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(255) NOT NULL,
	gebiedsnaam varchar(255) NOT NULL,
	officieel_beoordelings_gebied boolean NOT NULL,    -- Indicates if the beoordelingdgebied comes from the beoordelingd_gebied table or that the user upload their own beoordelingdgebied
	geom geometry NOT NULL,
	dossier_id bigint NOT NULL,
	beschrijving varchar(1000) NULL
)
;

ALTER TABLE imna.dossier_beoordelings_gebied
    OWNER to anlb;



CREATE TABLE IF NOT EXISTS imna.waarneming_flora_en_fauna
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(100) NOT NULL,
	soort_id bigint NOT NULL,
	soort_groep_id bigint NOT NULL,
	officiele_ndff_waarneming boolean NOT NULL,    -- Indicates if the waarneming comes from the NDFF_waarnemingen table or that the user upload their own waarnemingen
	dossier_id bigint NOT NULL,
	object_begin_tijd timestamp NOT NULL,
	object_eind_tijd timestamp NULL,
	geom geometry(point) NOT NULL    -- geometry of the waarneming, which will be indexed
)
;

ALTER TABLE imna.waarneming_flora_en_fauna
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.originele_dossier_beheer_gebied
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(100) NOT NULL,
	officieel_beheer_gebied boolean NOT NULL,
	beheer_type_id bigint NOT NULL,
	dossier_id bigint NOT NULL,
	geom geometry(polygon) NOT NULL
)
;

ALTER TABLE imna.originele_dossier_beheer_gebied
    OWNER to anlb;

	
CREATE TABLE IF NOT EXISTS imna.beheer_gebied_standplaats_beoordeling
(
	dossier_id bigint NOT NULL,
	dossier_beheer_gebied_id bigint NOT NULL,
	kwaliteits_score_id bigint NULL
)
;

ALTER TABLE imna.beheer_gebied_standplaats_beoordeling
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.beheer_gebied_standplaats_tussenresultaat
(
	dossier_id bigint NOT NULL,
	dossier_beheer_gebied_id bigint NOT NULL,
	kwalificerende_kenmerk_id bigint NOT NULL,
	waarde decimal(14,2) NULL
)
;

ALTER TABLE imna.beheer_gebied_standplaats_tussenresultaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.originele_waarneming_standplaats_factoren
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(100) NOT NULL,
	dossier_id bigint NOT NULL,
	gemiddelde_voorjaars_grondwaterstand numeric(10,3) NULL,
	gemiddelde_voorjaars_grondwaterstand_opmerking varchar(255) NULL,
	gemiddelde_laagste_grondwaterstand numeric(10,3) NULL,
	gemiddelde_laagste_grondwaterstand_opmerking varchar(255) NULL,
	ph numeric(10,3) NULL,
	ph_opmerking varchar(255) NULL,
	trofie numeric(10,3) NULL,
	trofie_opmerking varchar(255) NULL,
	geom geometry(polygon) NOT NULL
)
;

ALTER TABLE imna.originele_waarneming_standplaats_factoren
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.waarneming_standplaats_factor_tussenresultaat
(
	waarneming_standplaatsfactoren_id bigint NOT NULL,
	kwalificerende_kenmerk_id bigint NOT NULL,
	kwaliteits_score_id bigint NULL
)
;

ALTER TABLE imna.waarneming_standplaats_factor_tussenresultaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.waarneming_standplaats_factoren
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna.imna_seq'::text)::regclass),
	identificatie varchar(110) NOT NULL,
	dossier_beheergebied_id bigint NOT NULL,
	originele_waarneming_standplaats_factoren_id bigint NOT NULL,
	is_vlak_bijgesneden boolean NOT NULL,
	geom geometry(polygon) NOT NULL
)
;

ALTER TABLE imna.waarneming_standplaats_factoren
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS imna.waarneming_standplaats_factoren_beoordeling
(
	waarneming_standplaatsfactoren_id bigint NOT NULL,
	kwaliteits_score_id bigint NULL
)
;	

ALTER TABLE imna.waarneming_standplaats_factoren_beoordeling
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS imna.dossier_beheer_type_soorten
(
	dossier_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,    -- This table holds information about the species that are related to a beheer type and are observed or not. For sake of simplicity we didn't connect this table to the dmn_kwalificerende_kenmerk table. If in the future more kwalificerende kernmerken need to be registered for a specy, we can add an intersection table 
	soort_id bigint NOT NULL,
	waargenomen boolean NOT NULL,
	geom geometry(multipolygon) NULL
)
;

ALTER TABLE imna.dossier_beheer_type_soorten
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.dossier_beheer_type_soorten_tussenresultaat
(
	dossier_id bigint NOT NULL,
	beheer_type_id bigint NOT NULL,
	soort_id bigint NOT NULL,
	kwalificerende_kenmerk_id bigint NOT NULL,    -- Only spreading will be the qualifying kenmerk in this tussen resultaat table. Other kenmerks might be added in the future
	waarde NUMERIC(14,2) NULL
)
;

ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
    OWNER to anlb;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_beoordelingsresultaat','PK_beheer_type_beoordelingsresultaat',
'ALTER TABLE imna.beheer_type_beoordelingsresultaat ADD CONSTRAINT PK_beheer_type_beoordelingsresultaat
	PRIMARY KEY (dossier_id,beheer_type_id,beoordelings_indicator_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_beheer_type_beoordelingsresultaat_dmn_indicator_type ON imna.beheer_type_beoordelingsresultaat (beoordelings_indicator_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_type_beoordelingsresultaat_dmn_kwaliteits_bepaling ON imna.beheer_type_beoordelingsresultaat (kwaliteits_score_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_type_beoordelingsresultaat_dossier_beheer_type ON imna.beheer_type_beoordelingsresultaat (dossier_id ASC,beheer_type_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_tussenresultaat','PK_beheer_type_tussenresultaat',
'ALTER TABLE imna.beheer_type_tussenresultaat ADD CONSTRAINT PK_beheer_type_tussenresultaat
	PRIMARY KEY (dossier_id,beheer_type_id,kwalificerende_kenmerk_id)
;');


CREATE INDEX IF NOT EXISTS IXFK_beheer_type_tussenresultaat_dossier_beheer_type ON imna.beheer_type_tussenresultaat (dossier_id ASC,beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_type_tussenresultaat_kwalificerende_kenmerk ON imna.beheer_type_tussenresultaat (kwalificerende_kenmerk_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier','PK_dossier',
'ALTER TABLE imna.dossier ADD CONSTRAINT PK_dossier
	PRIMARY KEY (id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type','PK_dossier_beheer_type',
'ALTER TABLE imna.dossier_beheer_type ADD CONSTRAINT PK_dossier_beheer_type
	PRIMARY KEY (dossier_id,beheer_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_dmn_beheer_type ON imna.dossier_beheer_type (beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_dmn_kwaliteits_bepaling ON imna.dossier_beheer_type (kwaliteits_score ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_dossier ON imna.dossier_beheer_type (dossier_id ASC)
;


SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_gebied','PK_dossier_beheer_gebied',
'ALTER TABLE imna.dossier_beheer_gebied ADD CONSTRAINT PK_dossier_beheer_gebied
	PRIMARY KEY (id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beoordelings_gebied','PK_dossier_beoordelings_gebied',
'ALTER TABLE imna.dossier_beoordelings_gebied ADD CONSTRAINT PK_dossier_beoordelings_gebied
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dossier_beoordelings_gebied_dossier ON imna.dossier_beoordelings_gebied (dossier_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_flora_en_fauna','PK_waarneming_flora_en_fauna',
'ALTER TABLE imna.waarneming_flora_en_fauna ADD CONSTRAINT PK_waarneming_flora_en_fauna
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_waarneming_flora_en_fauna_dossier ON imna.waarneming_flora_en_fauna (dossier_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_flora_en_fauna_species_group ON imna.waarneming_flora_en_fauna (soort_groep_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_flora_en_fauna_taxa ON imna.waarneming_flora_en_fauna (soort_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','originele_dossier_beheer_gebied','PK_originele_dossier_beheer_gebied',
'ALTER TABLE imna.originele_dossier_beheer_gebied ADD CONSTRAINT PK_originele_dossier_beheer_gebied
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_originele_dossier_beheer_gebied_dmn_beheer_type ON imna.originele_dossier_beheer_gebied (beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_originele_dossier_beheer_gebied_dossier ON imna.originele_dossier_beheer_gebied (dossier_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_gebied','PK_dossier_beheer_gebied',
'ALTER TABLE imna.dossier_beheer_gebied ADD CONSTRAINT PK_dossier_beheer_gebied
	PRIMARY KEY (id)
;');


CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_gebied_originele_dossier_beheer_gebied ON imna.dossier_beheer_gebied (originele_beheer_gebied_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_beoordeling','PK_beheer_gebied_sp_beoordeling',
'ALTER TABLE imna.beheer_gebied_standplaats_beoordeling ADD CONSTRAINT PK_beheer_gebied_sp_beoordeling
	PRIMARY KEY (dossier_id,dossier_beheer_gebied_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_spf_dmn_kwaliteits_bepaling ON imna.beheer_gebied_standplaats_beoordeling (kwaliteits_score_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_sp_beoordeling_dossier ON imna.beheer_gebied_standplaats_beoordeling (dossier_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_sp_beoordeling_dossier_beheer_gebied ON imna.beheer_gebied_standplaats_beoordeling (dossier_beheer_gebied_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_tussenresultaat','PK_beheer_gebied_sp_tussenresultaat',
'ALTER TABLE imna.beheer_gebied_standplaats_tussenresultaat ADD CONSTRAINT PK_beheer_gebied_sp_tussenresultaat
	PRIMARY KEY (dossier_id,dossier_beheer_gebied_id,kwalificerende_kenmerk_id)
;');


CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_sp_tussenresultaat_dossier ON imna.beheer_gebied_standplaats_tussenresultaat (dossier_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_sp_tussenresultaat_dossier_beheer_gebied ON imna.beheer_gebied_standplaats_tussenresultaat (dossier_beheer_gebied_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_beheer_gebied_sp_tussenresultaat_kwalificerende_kenmerk ON imna.beheer_gebied_standplaats_tussenresultaat (kwalificerende_kenmerk_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','originele_waarneming_standplaats_factoren','PK_originele_waarneming_standplaats_factoren',
'ALTER TABLE imna.originele_waarneming_standplaats_factoren ADD CONSTRAINT PK_originele_waarneming_standplaats_factoren
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_originele_waarneming_standplaats_factoren_dossier ON imna.originele_waarneming_standplaats_factoren (dossier_id ASC)
;


SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factor_tussenresultaat','PK_waarneming_spf_tussenresultaat',
'ALTER TABLE imna.waarneming_standplaats_factor_tussenresultaat ADD CONSTRAINT PK_waarneming_spf_tussenresultaat
	PRIMARY KEY (waarneming_standplaatsfactoren_id,kwalificerende_kenmerk_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_tussenresultaat_dmn_kwaliteits_bepaling ON imna.waarneming_standplaats_factor_tussenresultaat (kwaliteits_score_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_tussenresultaat_kwalificerende_kenmerk ON imna.waarneming_standplaats_factor_tussenresultaat (kwalificerende_kenmerk_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_tussenresultaat_waarneming_spf ON imna.waarneming_standplaats_factor_tussenresultaat (waarneming_standplaatsfactoren_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren','PK_waarneming_spf',
'ALTER TABLE imna.waarneming_standplaats_factoren ADD CONSTRAINT PK_waarneming_spf
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf ON imna.waarneming_standplaats_factoren (dossier_beheergebied_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_originele_waarneming_spf ON imna.waarneming_standplaats_factoren (originele_waarneming_standplaats_factoren_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren_beoordeling','PK_waarneming_spf_beoordeling',
'ALTER TABLE imna.waarneming_standplaats_factoren_beoordeling ADD CONSTRAINT PK_waarneming_spf_beoordeling
	PRIMARY KEY (waarneming_standplaatsfactoren_id)
;
;');

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_beoordeling_dmn_kwaliteits_bepaling ON imna.waarneming_standplaats_factoren_beoordeling (kwaliteits_score_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_waarneming_spf_beoordeling_waarneming_spf ON imna.waarneming_standplaats_factoren_beoordeling (waarneming_standplaatsfactoren_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten','PK_dossier_beheer_type_soorten',
'ALTER TABLE imna.dossier_beheer_type_soorten ADD CONSTRAINT PK_dossier_beheer_type_soorten
	PRIMARY KEY (dossier_id,beheer_type_id,soort_id)
;');


CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_soorten_dossier_beheer_type ON imna.dossier_beheer_type_soorten (dossier_id ASC,beheer_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_soorten_soort ON imna.dossier_beheer_type_soorten (soort_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten_tussenresultaat','PK_dossier_beheer_type_soorten_tussenresultaat',
'ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat ADD CONSTRAINT PK_dossier_beheer_type_soorten_tussenresultaat
	PRIMARY KEY (dossier_id,soort_id,beheer_type_id, kwalificerende_kenmerk_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt ON imna.dossier_beheer_type_soorten_tussenresultaat (dossier_id ASC,beheer_type_id ASC,soort_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk ON imna.dossier_beheer_type_soorten_tussenresultaat (kwalificerende_kenmerk_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_beheer_type_beoores_dmn_kwaliteits_bepaling_exp_oordeel ON imna.beheer_type_beoordelingsresultaat (expert_score_oordeel_id ASC);

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beoordelings_gebied','FK_dossier_beoordelings_gebied_dossier',
'ALTER TABLE imna.dossier_beoordelings_gebied ADD CONSTRAINT FK_dossier_beoordelings_gebied_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_beoordelingsresultaat','FK_beheer_type_beoordelingsresultaat_dmn_indicator_type',
'ALTER TABLE imna.beheer_type_beoordelingsresultaat ADD CONSTRAINT FK_beheer_type_beoordelingsresultaat_dmn_indicator_type
	FOREIGN KEY (beoordelings_indicator_id) REFERENCES masterdata.dmn_indicator_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_beoordelingsresultaat','FK_beheer_type_beoordelingsresultaat_dmn_kwaliteits_bepaling',
'ALTER TABLE imna.beheer_type_beoordelingsresultaat ADD CONSTRAINT FK_beheer_type_beoordelingsresultaat_dmn_kwaliteits_bepaling
	FOREIGN KEY (kwaliteits_score_id) REFERENCES masterdata.dmn_kwaliteits_bepaling (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_beoordelingsresultaat','FK_beheer_type_beoordelingsresultaat_dossier_beheer_type',
'ALTER TABLE imna.beheer_type_beoordelingsresultaat ADD CONSTRAINT FK_beheer_type_beoordelingsresultaat_dossier_beheer_type
	FOREIGN KEY (dossier_id,beheer_type_id) REFERENCES imna.dossier_beheer_type (dossier_id,beheer_type_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_tussenresultaat','FK_beheer_type_tussenresultaat_dossier_beheer_type',
'ALTER TABLE imna.beheer_type_tussenresultaat ADD CONSTRAINT FK_beheer_type_tussenresultaat_dossier_beheer_type
	FOREIGN KEY (dossier_id,beheer_type_id) REFERENCES imna.dossier_beheer_type (dossier_id,beheer_type_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_tussenresultaat','FK_beheer_type_tussenresultaat_kwalificerende_kenmerk',
'ALTER TABLE imna.beheer_type_tussenresultaat ADD CONSTRAINT FK_beheer_type_tussenresultaat_kwalificerende_kenmerk
	FOREIGN KEY (kwalificerende_kenmerk_id) REFERENCES rnn.kwalificerende_kenmerk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type','FK_dossier_beheer_type_dmn_beheer_type',
'ALTER TABLE imna.dossier_beheer_type ADD CONSTRAINT FK_dossier_beheer_type_dmn_beheer_type
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type','FK_dossier_beheer_type_dmn_kwaliteits_bepaling',
'ALTER TABLE imna.dossier_beheer_type ADD CONSTRAINT FK_dossier_beheer_type_dmn_kwaliteits_bepaling
	FOREIGN KEY (kwaliteits_score) REFERENCES masterdata.dmn_kwaliteits_bepaling (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type','FK_dossier_beheer_type_dossier',
'ALTER TABLE imna.dossier_beheer_type ADD CONSTRAINT FK_dossier_beheer_type_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_flora_en_fauna','FK_waarneming_flora_en_fauna_dossier',
'ALTER TABLE imna.waarneming_flora_en_fauna ADD CONSTRAINT FK_waarneming_flora_en_fauna_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_flora_en_fauna','FK_waarneming_flora_en_fauna_species_group',
'ALTER TABLE imna.waarneming_flora_en_fauna ADD CONSTRAINT FK_waarneming_flora_en_fauna_species_group
	FOREIGN KEY (soort_groep_id) REFERENCES ndff.species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_flora_en_fauna','FK_waarneming_flora_en_fauna_taxa',
'ALTER TABLE imna.waarneming_flora_en_fauna ADD CONSTRAINT FK_waarneming_flora_en_fauna_taxa
	FOREIGN KEY (soort_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','originele_dossier_beheer_gebied','FK_originele_dossier_beheer_gebied_dmn_beheer_type',
'ALTER TABLE imna.originele_dossier_beheer_gebied ADD CONSTRAINT FK_originele_dossier_beheer_gebied_dmn_beheer_type
	FOREIGN KEY (beheer_type_id) REFERENCES masterdata.dmn_beheer_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','originele_dossier_beheer_gebied','FK_originele_dossier_beheer_gebied_dossier',
'ALTER TABLE imna.originele_dossier_beheer_gebied ADD CONSTRAINT FK_originele_dossier_beheer_gebied_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_gebied','FK_dossier_beheer_gebied_originele_dossier_beheer_gebied',
'ALTER TABLE imna.dossier_beheer_gebied ADD CONSTRAINT FK_dossier_beheer_gebied_originele_dossier_beheer_gebied
	FOREIGN KEY (originele_beheer_gebied_id) REFERENCES imna.originele_dossier_beheer_gebied (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_beoordeling','FK_beheer_gebied_sp_beoordeling_dossier',
'ALTER TABLE imna.beheer_gebied_standplaats_beoordeling ADD CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_beoordeling','FK_beheer_gebied_sp_beoordeling_dossier_beheer_gebied',
'ALTER TABLE imna.beheer_gebied_standplaats_beoordeling ADD CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier_beheer_gebied
	FOREIGN KEY (dossier_beheer_gebied_id) REFERENCES imna.dossier_beheer_gebied (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_beoordeling','FK_beheer_gebied_spf_beoordeling_dmn_kwaliteits_bepaling',
'ALTER TABLE imna.beheer_gebied_standplaats_beoordeling ADD CONSTRAINT FK_beheer_gebied_spf_beoordeling_dmn_kwaliteits_bepaling
	FOREIGN KEY (kwaliteits_score_id) REFERENCES masterdata.dmn_kwaliteits_bepaling (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_tussenresultaat','FK_beheer_gebied_sp_tussenresultaat_dossier',
'ALTER TABLE imna.beheer_gebied_standplaats_tussenresultaat ADD CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_tussenresultaat','FK_beheer_gebied_sp_tussenresultaat_dossier_beheer_gebied',
'ALTER TABLE imna.beheer_gebied_standplaats_tussenresultaat ADD CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier_beheer_gebied
	FOREIGN KEY (dossier_beheer_gebied_id) REFERENCES imna.dossier_beheer_gebied (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_standplaats_tussenresultaat','FK_beheer_gebied_sp_tussenresultaat_kwalificerende_kenmerk',
'ALTER TABLE imna.beheer_gebied_standplaats_tussenresultaat ADD CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_kwalificerende_kenmerk
	FOREIGN KEY (kwalificerende_kenmerk_id) REFERENCES rnn.kwalificerende_kenmerk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','originele_waarneming_standplaats_factoren','FK_originele_waarneming_standplaats_factoren_dossier',
'ALTER TABLE imna.originele_waarneming_standplaats_factoren ADD CONSTRAINT FK_originele_waarneming_standplaats_factoren_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factor_tussenresultaat','FK_waarneming_spf_tussenresultaat_dmn_kwaliteits_bepaling',
'ALTER TABLE imna.waarneming_standplaats_factor_tussenresultaat ADD CONSTRAINT FK_waarneming_spf_tussenresultaat_dmn_kwaliteits_bepaling
	FOREIGN KEY (kwaliteits_score_id) REFERENCES masterdata.dmn_kwaliteits_bepaling (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factor_tussenresultaat','FK_waarneming_spf_tussenresultaat_kwalificerende_kenmerk',
'ALTER TABLE imna.waarneming_standplaats_factor_tussenresultaat ADD CONSTRAINT FK_waarneming_spf_tussenresultaat_kwalificerende_kenmerk
	FOREIGN KEY (kwalificerende_kenmerk_id) REFERENCES rnn.kwalificerende_kenmerk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factor_tussenresultaat','FK_waarneming_spf_tussenresultaat_waarneming_spf',
'ALTER TABLE imna.waarneming_standplaats_factor_tussenresultaat ADD CONSTRAINT FK_waarneming_spf_tussenresultaat_waarneming_spf
	FOREIGN KEY (waarneming_standplaatsfactoren_id) REFERENCES imna.waarneming_standplaats_factoren (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren','FK_waarneming_spf',
'ALTER TABLE imna.waarneming_standplaats_factoren ADD CONSTRAINT FK_waarneming_spf
	FOREIGN KEY (dossier_beheergebied_id) REFERENCES imna.dossier_beheer_gebied (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren','FK_waarneming_spf_originele_waarneming_spf',
'ALTER TABLE imna.waarneming_standplaats_factoren ADD CONSTRAINT FK_waarneming_spf_originele_waarneming_spf
	FOREIGN KEY (originele_waarneming_standplaats_factoren_id) REFERENCES imna.originele_waarneming_standplaats_factoren (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren_beoordeling','FK_waarneming_spf_beoordeling_dmn_kwaliteits_bepaling',
'ALTER TABLE imna.waarneming_standplaats_factoren_beoordeling ADD CONSTRAINT FK_waarneming_spf_beoordeling_dmn_kwaliteits_bepaling
	FOREIGN KEY (kwaliteits_score_id) REFERENCES masterdata.dmn_kwaliteits_bepaling (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','waarneming_standplaats_factoren_beoordeling','FK_waarneming_spf_beoordeling_waarneming_spf',
'ALTER TABLE imna.waarneming_standplaats_factoren_beoordeling ADD CONSTRAINT FK_waarneming_spf_beoordeling_waarneming_spf
	FOREIGN KEY (waarneming_standplaatsfactoren_id) REFERENCES imna.waarneming_standplaats_factoren (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten','FK_dossier_beheer_type_soorten_dossier_beheer_type',
'ALTER TABLE imna.dossier_beheer_type_soorten ADD CONSTRAINT FK_dossier_beheer_type_soorten_dossier_beheer_type
	FOREIGN KEY (dossier_id,beheer_type_id) REFERENCES imna.dossier_beheer_type (dossier_id,beheer_type_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten','FK_dossier_beheer_type_soorten_soort',
'ALTER TABLE imna.dossier_beheer_type_soorten ADD CONSTRAINT FK_dossier_beheer_type_soorten_soort
	FOREIGN KEY (soort_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten_tussenresultaat','FK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt',
'ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat ADD CONSTRAINT FK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt
	FOREIGN KEY (dossier_id,beheer_type_id,soort_id) REFERENCES imna.dossier_beheer_type_soorten (dossier_id,beheer_type_id,soort_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten_tussenresultaat','FK_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk',
'ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat ADD CONSTRAINT FK_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk
	FOREIGN KEY (kwalificerende_kenmerk_id) REFERENCES masterdata.dmn_kwalificerende_kenmerk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_type_beoordelingsresultaat','FK_beheer_type_beoores_dmn_kwaliteits_bepaling_exp_oordeel',
'ALTER TABLE imna.beheer_type_beoordelingsresultaat ADD CONSTRAINT FK_beheer_type_beoores_dmn_kwaliteits_bepaling_exp_oordeel
	FOREIGN KEY (expert_score_oordeel_id) REFERENCES masterdata.dmn_kwaliteits_bepaling_expert_oordeel (id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */


COMMENT ON TABLE imna.beheer_gebied_standplaats_beoordeling
	IS 'The final assessment of a management area based on the interim results of the management area in question based on the maatlat'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_beoordeling.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_beoordeling.dossier_beheer_gebied_id
	IS 'Reference to the management area'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_beoordeling.kwaliteits_score_id
	IS 'The quality score of the management area.'
;

COMMENT ON TABLE imna.beheer_gebied_standplaats_tussenresultaat
	IS 'This table stores the interim results for the management area. These are the results for the qualifying characteristics "OppHigh," "OppMidden," "OppLaag," and "Could not be calculated."'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_tussenresultaat.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_tussenresultaat.dossier_beheer_gebied_id
	IS 'Reference to the management area'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_tussenresultaat.kwalificerende_kenmerk_id
	IS 'Reference to the kwalificerende kenmerk'
;

COMMENT ON COLUMN imna.beheer_gebied_standplaats_tussenresultaat.waarde
	IS 'Total area for the qualifying characteristics High, Medium, Low and "could not be calculated"'
;

COMMENT ON TABLE imna.beheer_type_beoordelingsresultaat
	IS 'Contains the assessment result for a management type of an indicator. Where possible, this has been calculated, such as for flora and fauna and site factors. For the other three indicators, this is only the expert opinion.'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.beheer_type_id
	IS 'Reference to the beheer type'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.beoordelings_indicator_id
	IS 'reference to the inficator'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.kwaliteits_score_id
	IS 'Reference to the quality score. The calculation of the score for an indicator.'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.expert_score_oordeel_id
	IS 'Expert Judgement Score filled in by the user (High, Medium, Low)'
;

COMMENT ON COLUMN imna.beheer_type_beoordelingsresultaat.expert_score_uitleg
	IS 'Explanation of the Expert Judgement for an indicator for an mangement type'
;

COMMENT ON TABLE imna.dossier
	IS 'Dossier to which the entire calculation is related to'
;

COMMENT ON COLUMN imna.dossier.id
	IS 'Internal id of the dossier within rnn'
;

COMMENT ON COLUMN imna.dossier.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.dossier.dossier_naam
	IS 'The (textual) designation of the specific object.'
;

COMMENT ON COLUMN imna.dossier.beschikkingsjaar
	IS 'Not required: Year of management areas used for the assessment.'
;

COMMENT ON COLUMN imna.dossier.vegetatiekarteringsjaar
	IS 'Year the vegetation mapping was carried out.'
;

COMMENT ON COLUMN imna.dossier.beoordelaar
	IS 'Person who made the assessment.'
;

COMMENT ON COLUMN imna.dossier.beoordelaar_email_adres
	IS 'Email address that the user can add in Geoweb, for sending the email.'
;

COMMENT ON COLUMN imna.dossier.eigenaar
	IS 'person or organization that owns the dossier. (For example: Natuurmonumenten)'
;

COMMENT ON COLUMN imna.dossier.object_begin_tijd
	IS 'The time at which the object came into existence in reality.'
;

COMMENT ON COLUMN imna.dossier.object_eind_tijd
	IS 'The point in time at which the object is no longer valid in reality.'
;

COMMENT ON COLUMN imna.dossier.datum_beoordeling
	IS 'Date the actual assessment was performed in the system'
;

COMMENT ON COLUMN imna.dossier.toelichting
	IS 'Explanation of the dossier.'
;

COMMENT ON TABLE imna.dossier_beheer_gebied
	IS 'Management area where the calculation will be performed'
;

COMMENT ON COLUMN imna.dossier_beheer_gebied.id
	IS 'Internal id of the management area.'
;

COMMENT ON COLUMN imna.dossier_beheer_gebied.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.dossier_beheer_gebied.originele_beheer_gebied_id
	IS 'Reference to the original management area'
;

COMMENT ON COLUMN imna.dossier_beheer_gebied.is_vlak_bijgesneden
	IS 'Indicator if the geometry is the same as the original geometry'
;

COMMENT ON COLUMN imna.dossier_beheer_gebied.geom
	IS 'The two-dimensional geometric representation of the plane formed by the contours of the object.'
;

COMMENT ON TABLE imna.dossier_beheer_type
	IS 'Management types that are present in a dossier, including the overall assessment of the management type.'
;

COMMENT ON COLUMN imna.dossier_beheer_type.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.dossier_beheer_type.beheer_type_id
	IS 'Reference to the management type'
;

COMMENT ON COLUMN imna.dossier_beheer_type.kwaliteits_score
	IS 'reference to the quality score'
;

COMMENT ON TABLE imna.dossier_beheer_type_soorten
	IS 'Shows the observed and unobserved species that are important for a management type. These may also include red list species.'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten.dossier_id
	IS 'Reference to dossier'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten.beheer_type_id
	IS 'reference to management type'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten.waargenomen
	IS 'Indication of whether the species has been observed in the management type'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten.geom
	IS 'Is a geometry that represents the combined grid cells in which a species is observed.'
;

COMMENT ON TABLE imna.dossier_beheer_type_soorten_tussenresultaat
	IS 'This is the intersection table between the soorten found and kwalificerende kenmerk. For not only spreading is needed.'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten_tussenresultaat.dossier_id
	IS 'Part of the key to the table dossier_beheer_type_soorten'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten_tussenresultaat.beheer_type_id
	IS 'Part of the key to the table dossier_beheer_type_soorten'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten_tussenresultaat.soort_id
	IS 'Part of the key to the table dossier_beheer_type_soorten'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten_tussenresultaat.kwalificerende_kenmerk_id
	IS 'Only spreading will be the qualifying kenmerk in this tussen resultaat table. Other kenmerks might be added in the future'
;

COMMENT ON COLUMN imna.dossier_beheer_type_soorten_tussenresultaat.waarde
	IS 'The value of in between results, for example spreading in percentages'
;

COMMENT ON TABLE imna.dossier_beoordelings_gebied
	IS 'Assessment area of the dossier.'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.id
	IS 'Internal id of the assessment area used in the dossier.'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.gebiedsnaam
	IS 'Name of the assessment area. Formal assessment areas have a fixed name, non-formal assessment areas do not.'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.beschrijving
	IS 'The coherent enumeration of characteristics of the object'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.officieel_beoordelings_gebied
	IS 'Indicates if the beoordelingdgebied comes from the beoordelingd_gebied table or that the user upload their own beoordelingdgebied'
;

COMMENT ON COLUMN imna.dossier_beoordelings_gebied.geom
	IS 'The two-dimensional geometric representation of the plane formed by the contours of the object.'
;

COMMENT ON TABLE imna.originele_dossier_beheer_gebied
	IS 'Original management area, from SNL or included in the Geopackage'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.id
	IS 'Internal id of the original management area.'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.officieel_beheer_gebied
	IS 'Indication whether the management area was uploaded by the user or whether it came from SNL.'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.beheer_type_id
	IS 'The further concretization / detailing of the natural type'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.originele_dossier_beheer_gebied.geom
	IS 'The two-dimensional geometric representation of the plane formed by the contours of the object.'
;

COMMENT ON TABLE imna.originele_waarneming_standplaats_factoren
	IS 'The observations as submitted by the user via the geopackage.'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.id
	IS 'Internal id of the original waarneming standplaatsfactoren '
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.dossier_id
	IS 'Reference to the dossier'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.gemiddelde_voorjaars_grondwaterstand
	IS 'Average groundwater level at the start of the growing season (April 1) (cm)'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.gemiddelde_voorjaars_grondwaterstand_opmerking
	IS 'Comments on average spring groundwater level'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.gemiddelde_laagste_grondwaterstand
	IS 'Average lowest groundwater level (cm)'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.gemiddelde_laagste_grondwaterstand_opmerking
	IS 'Comments on average lowest groundwater level'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.pH
	IS 'p­H-H2O'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.pH_opmerking
	IS 'Comments for pH-H2O value'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.trofie
	IS 'Value for trofie'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.trofie_opmerking
	IS 'Comments on trofie'
;

COMMENT ON COLUMN imna.originele_waarneming_standplaats_factoren.geom
	IS 'The two-dimensional geometric representation of the plane formed by the contours of the object.'
;

COMMENT ON TABLE imna.beheer_type_tussenresultaat
	IS 'This table stores the interim results of the dossier management type. These are the interim results of the indicators standplaatsfactor and flora and fauna, such as oppHoog, oppMidden and oppLow, but also qualifying species and distribution.'
;

COMMENT ON TABLE imna.waarneming_flora_en_fauna
	IS 'Waarneming_Flora_En_Fauna are observations that were done in nature. A user can upload their own waarneming. If they don''t , the waarnemingen from the NDFF_waarnemingen table are copied to this table. The boolean officiele_ndff_waarnimng indicates that the waarneming is copied from the ndff_waarnemingen table'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.id
	IS 'Internal id of the waarneming flor and fauna area.'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.soort_id
	IS 'reference to soort'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.soort_groep_id
	IS 'Reference to soort groep'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.officiele_ndff_waarneming
	IS 'Indicates if the waarneming comes from the NDFF_waarnemingen table or that the user upload their own waarnemingen'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.dossier_id
	IS 'Reference to dossier'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.object_begin_tijd
	IS 'The time at which the object came into existence in reality.'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.object_eind_tijd
	IS 'The point in time at which the object is no longer valid in reality.'
;

COMMENT ON COLUMN imna.waarneming_flora_en_fauna.geom
	IS 'original location where the species was observed without (uncertainty) buffer.'
;

COMMENT ON TABLE imna.waarneming_standplaats_factor_tussenresultaat
	IS 'Score based on the calculation of a single standplaatsfactor using the maatlat. Scores are calculated for gvg, glg, pH, and trophies.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factor_tussenresultaat.waarneming_standplaatsfactoren_id
	IS 'Refeerence to the waarneming standplaatsfactoren.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factor_tussenresultaat.kwalificerende_kenmerk_id
	IS 'Reference to the kwalificerende kenmerk'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factor_tussenresultaat.kwaliteits_score_id
	IS 'Reference to the quaility score.'
;

COMMENT ON TABLE imna.waarneming_standplaats_factoren
	IS 'An observation of various standplaatsfactoren, including values for gvg, glg, pH, and trophic content. The observation is linked to a management area, allowing the correct metric for the management type to be retrieved.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.id
	IS 'Internal id of the waarneming standplaatsfactoren cut off by the management type.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.identificatie
	IS 'The unique code for identifying the object.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.dossier_beheergebied_id
	IS 'Attribute to the management area where the observation was made. Everything outside the original area is cropped out.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.originele_waarneming_standplaats_factoren_id
	IS 'Reference to the originele waarneming standplaatsfactoren'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.is_vlak_bijgesneden
	IS 'Indication of whether the area has been cropped. This can happen if the original standplaats factor observation apply to multiple management areas.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren.geom
	IS 'The two-dimensional geometric representation of the plane formed by the contours of the object.'
;

COMMENT ON TABLE imna.waarneming_standplaats_factoren_beoordeling
	IS 'The assessment of the combination of all intermediate results of the standplaatsfactors together in the area that falls within the management area based on the maatlat belonging to the management type.'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren_beoordeling.waarneming_standplaatsfactoren_id
	IS 'Reference to the waarneming standplaatsfactor'
;

COMMENT ON COLUMN imna.waarneming_standplaats_factoren_beoordeling.kwaliteits_score_id
	IS 'Reference to the quality score'
;








CREATE INDEX IF NOT EXISTS "IDX_waarneming_flora_en_fauna_geom"
    ON imna.waarneming_flora_en_fauna USING gist
    (geom);
	
CREATE INDEX IF NOT EXISTS "IDX_originele_dossier_beheer_gebied_geom"
    ON imna.originele_dossier_beheer_gebied USING gist
    (geom);
	
CREATE INDEX IF NOT EXISTS "IDX_dossier_beheer_gebied_geom"
    ON imna.dossier_beheer_gebied USING gist
    (geom);

CREATE INDEX IF NOT EXISTS "IDX_dossier_beoordelings_gebied_geom"
    ON imna.dossier_beoordelings_gebied USING gist
    (geom);

GRANT SELECT ON ALL TABLES IN SCHEMA imna TO anlb_sqlpad;