\echo "RNN-2177 Make kwalificerende kenmerk time travelable"
\echo "RNN-2205 Adhere to IMNA"

BEGIN;

-- Delete maatlat that have an end date
DELETE FROM rnn.maatlat WHERE eind_geldigheid IS NOT NULL;

-- Remove begin_geldigheid and eind_geldigheid from table maatlat 
ALTER TABLE IF EXISTS rnn.maatlat DROP COLUMN IF EXISTS begin_geldigheid;
ALTER TABLE IF EXISTS rnn.maatlat DROP COLUMN IF EXISTS eind_geldigheid;

-- Remove UN from rode_lijst_configuratie
ALTER TABLE rnn.kwalificerende_kenmerk DROP CONSTRAINT IF EXISTS un_rode_lijst_configuratie_identificatie;

-- Remove begin_geldigheid and eind_geldigheid from table rode_lijst_configuratie 
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie DROP COLUMN IF EXISTS begin_geldigheid;
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie DROP COLUMN IF EXISTS eind_geldigheid;

-- Add Unique key
ALTER TABLE rnn.rode_lijst_configuratie ADD CONSTRAINT un_rode_lijst_configuratie_identificatie UNIQUE (kwalificerende_kenmerk_id);

-- Remove PK rode_lijst_configuratie_rode_lijst_categorie
ALTER TABLE rnn.rode_lijst_configuratie_rode_lijst_categorie DROP CONSTRAINT PK_rode_lijst_conf_rode_lijst_cat;
-- Remove begin_geldigheid and eind_geldigheid from table rode_lijst_configuratie_rode_lijst_categorie 
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie_rode_lijst_categorie DROP COLUMN IF EXISTS begin_geldigheid;
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie_rode_lijst_categorie DROP COLUMN IF EXISTS eind_geldigheid;
-- Add PK to table rode_lijst_configuratie_rode_lijst_categorie
ALTER TABLE rnn.rode_lijst_configuratie_rode_lijst_categorie ADD CONSTRAINT PK_rode_lijst_conf_rode_lijst_cat PRIMARY KEY (rode_lijst_soort_configuratie_id,rode_lijst_soort_categorie_id);
-- Rename column rode_lijst_soort_configuratie_id to rode_lijst_configuratie_id
ALTER TABLE rnn.rode_lijst_configuratie_rode_lijst_categorie RENAME COLUMN rode_lijst_soort_configuratie_id TO rode_lijst_configuratie_id;
-- Rename column rode_lijst_soort_configuratie_id to rode_lijst_configuratie_id
ALTER TABLE rnn.rode_lijst_configuratie_rode_lijst_categorie RENAME COLUMN rode_lijst_soort_categorie_id TO rode_lijst_categorie_id;

-- Remove PK rode_lijst_configuratie_soort_groep
ALTER TABLE rnn.rode_lijst_configuratie_soort_groep DROP CONSTRAINT PK_rode_lijst_conf_soort_groep;
-- Remove begin_geldigheid and eind_geldigheid from table rode_lijst_configuratie_soort_groep  
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie_soort_groep  DROP COLUMN IF EXISTS begin_geldigheid;
ALTER TABLE IF EXISTS rnn.rode_lijst_configuratie_soort_groep  DROP COLUMN IF EXISTS eind_geldigheid;
-- Add PK to table rode_lijst_configuratie_soort_groep
ALTER TABLE rnn.rode_lijst_configuratie_soort_groep ADD CONSTRAINT PK_rode_lijst_conf_soort_groep PRIMARY KEY (rode_lijst_soort_configuratie_id,soort_group_id);
-- Rename column rode_lijst_soort_configuratie_id to rode_lijst_configuratie_id
ALTER TABLE rnn.rode_lijst_configuratie_soort_groep RENAME COLUMN rode_lijst_soort_configuratie_id TO rode_lijst_configuratie_id;

ALTER TABLE rnn.maatlat ADD CONSTRAINT UN_Maatlat_Identity UNIQUE (kwalificerende_kenmerk_id, kwaliteits_bepaling);

ALTER TABLE rnn.kwalificerende_kenmerk ADD COLUMN begin_geldigheid timestamp NULL;
ALTER TABLE rnn.kwalificerende_kenmerk ADD COLUMN eind_geldigheid timestamp NULL;

ALTER TABLE rnn.indicator_beheer_type ADD COLUMN begin_geldigheid timestamp NULL;
ALTER TABLE rnn.indicator_beheer_type ADD COLUMN eind_geldigheid timestamp NULL;

ALTER TABLE rnn.kwalificerende_kenmerk RENAME COLUMN kwalificerende_kenmerk_id TO domain_kwalificerende_kenmerk_id;

ALTER TABLE rnn.kwalificerende_kenmerk DROP CONSTRAINT IF EXISTS un_kwalificerende_kenmerk_indentity;
ALTER TABLE rnn.kwalificerende_kenmerk DROP CONSTRAINT IF EXISTS fk_kwalificerende_kenmerk_indicator_beheer_type; 
DROP INDEX IF EXISTS rnn.ixfk_kwalificerende_kenmerk_indicator_beheer_type;


ALTER TABLE rnn.kwalificerende_kenmerk ADD COLUMN IF NOT EXISTS indicator_beheer_type_id bigint NULL;
ALTER TABLE rnn.indicator_beheer_type ADD COLUMN IF NOT EXISTS id bigint NULL  DEFAULT NEXTVAL(('rnn.rnn_seq'::text)::regclass);

-- Update begin_geldigheid of kwalificerende_kenmerk to 1-1-1900
UPDATE rnn.kwalificerende_kenmerk
SET begin_geldigheid = TIMESTAMP '1900-01-01'
WHERE begin_geldigheid IS NULL;

-- Update begin_geldigheid of indicator_beheer_type to 1-1-1900
UPDATE rnn.indicator_beheer_type
SET begin_geldigheid = TIMESTAMP '1900-01-01'
WHERE begin_geldigheid IS NULL;

-- Update statement to update 
UPDATE rnn.indicator_beheer_type
SET id = nextval('rnn.rnn_seq')
WHERE id IS NULL;


-- Script that fills the newly added column indicator_beheer_type_id
UPDATE rnn.kwalificerende_kenmerk kk
SET indicator_beheer_type_id = 
(SELECT id FROM rnn.indicator_beheer_type 
WHERE beheer_type_id = kk.beheer_type_id
AND indicator_type_id = kk.indicator_type_id);

-- Add constraints back to tables
ALTER TABLE rnn.indicator_beheer_type DROP CONSTRAINT PK_indicator_beheer_type;
ALTER TABLE rnn.indicator_beheer_type ADD CONSTRAINT PK_indicator_beheer_type PRIMARY KEY (id);
ALTER TABLE rnn.indicator_beheer_type ADD CONSTRAINT UN_indicator_beheer_type_identity UNIQUE (beheer_type_id,indicator_type_id,begin_geldigheid);

ALTER TABLE rnn.kwalificerende_kenmerk ADD CONSTRAINT UN_kwalificerende_kenmerk_indentity UNIQUE (domain_kwalificerende_kenmerk_id,indicator_beheer_type_id,begin_geldigheid);
ALTER TABLE rnn.kwalificerende_kenmerk ADD CONSTRAINT FK_kwalificerende_kenmerk_indicator_beheer_type FOREIGN KEY (indicator_beheer_type_id) REFERENCES rnn.indicator_beheer_type (id) ON DELETE No Action ON UPDATE No Action;
CREATE INDEX IF NOT EXISTS ixfk_kwalificerende_kenmerk_indicator_beheer_type ON rnn.kwalificerende_kenmerk (indicator_beheer_type_id ASC)

ALTER TABLE rnn.kwalificerende_kenmerk ALTER COLUMN begin_geldigheid SET NOT NULL;
ALTER TABLE rnn.indicator_beheer_type ALTER COLUMN begin_geldigheid SET NOT NULL;

ALTER TABLE rnn.indicator_beheer_type ALTER COLUMN id SET NOT NULL;
ALTER TABLE rnn.kwalificerende_kenmerk ALTER COLUMN indicator_beheer_type_id SET NOT NULL;
ALTER TABLE rnn.kwalificerende_kenmerk ALTER COLUMN domain_kwalificerende_kenmerk_id SET NOT NULL;

-- Drop the old foreing key columns beheer_type_id and indicator_type_id
ALTER TABLE rnn.kwalificerende_kenmerk DROP COLUMN IF EXISTS beheer_type_id;
ALTER TABLE rnn.kwalificerende_kenmerk DROP COLUMN IF EXISTS indicator_type_id;


ALTER TABLE rnn.rnn_soort_groep RENAME CONSTRAINT FK_rnn_species_groups_specie_group TO FK_rnn_soort_groep_species_group;
ALTER INDEX rnn.IXFK_rnn_species_groups_specie_group RENAME TO IXFK_rnn_soort_groep_species_group;
ALTER TABLE rnn.rnn_soort_groep RENAME CONSTRAINT PK_rnn_species_group TO PK_rnn_soort_groep;
ALTER TABLE rnn.rode_lijst_configuratie_soort_groep RENAME COLUMN soort_group_id TO soort_groep_id;

--COMMIT;
--ROLLBACK;