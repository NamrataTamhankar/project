\echo "Starting deployment of besi schema for ANLB automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS besi
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA besi TO anlb;

--GRANT USAGE ON SCHEMA besi TO ;
GRANT USAGE ON SCHEMA besi TO anlb_sqlpad;
GRANT USAGE ON SCHEMA besi TO besi_readonly;

/* Create Sequence if not exists */
CREATE SEQUENCE IF NOT EXISTS besi.besi_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE besi.besi_seq
    OWNER TO anlb;


/* Create Tables */

CREATE TABLE IF NOT EXISTS besi.basis_grid
(
	id bigint NOT NULL,    -- id of the grid cell
	geom geometry(polygon) NOT NULL    -- 25m2 square of the grid cell
)
;

ALTER TABLE besi.basis_grid
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.besi_access_database_versie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('besi_seq'::text)::regclass),
	versienummer integer NOT NULL,
	ingediend_door varchar(50) NULL,
	release_notes text NULL,
	startdatum timestamp NOT NULL   DEFAULT NOW(),
	einddatum timestamp NULL
)
;

ALTER TABLE besi.besi_access_database_versie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.besi_species_group
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('besi.besi_seq'::text)::regclass),
	valid_from date NOT NULL,
	valid_to date NULL,
	identity varchar(50) NOT NULL,
	name varchar(255) NULL,
	scientific varchar(255) NULL,
	beschermende_factor_id bigint NULL,
	publish boolean NOT NULL   DEFAULT false,
	selectie_kans decimal NULL    -- This column indicates if the report selection should deviate from the standard 0,75. This number would be the change for this specific specie
)
;

ALTER TABLE besi.besi_species_group
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.besi_species_group_kans_versie
(
	besi_species_group_id bigint NOT NULL,    -- Reference to the table BesiSpeciesGroup.
	versie bigint NOT NULL,    -- version of the probability map of the besi species group
	datum date NOT NULL,    -- start validity of the probability map for the besi species group.
	omschrijving text NULL    -- description of the probability map for the besi species group.
)
;

ALTER TABLE besi.besi_species_group_kans_versie
    OWNER to anlb;


CREATE TABLE IF NOT EXISTS besi.besi_species_group_kansen_huidig
(
	besi_species_group_id bigint NOT NULL,
	grid_id bigint NOT NULL,    -- reference to the grid cell specifying the actual geographical location of the probability.
	kans decimal NOT NULL,    -- probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance.
	dichtheid decimal NULL,    -- Model-based representation of spatial distribution of observations. Provides more information than just presence and absence.
	kwantiel integer NULL    -- Population centers based on chance maps.
)
;

ALTER TABLE besi.besi_species_group_kansen_huidig
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.besi_species_group_rapport_text
(
	besi_species_group_id bigint NOT NULL,    -- Reference to the table BesiSpeciesGroup.
	beschrijving_habitat varchar(255) NULL,    -- specific text on the habitat of the besi species group
	gevoeligheid varchar(255) NULL,    -- Short description on potential negative effects to the besi species group
	advies varchar(600) NULL    -- Text describing the advise on how to avoid or lessen the negative effects on the besi species group
)
;

ALTER TABLE besi.besi_species_group_rapport_text
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.besi_taxa
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	valid_from timestamp NOT NULL,    -- start validity of the taxon in relationship with BESI
	valid_to timestamp NULL,    -- end validity of the taxon in relationship with BESI
	beschermende_factor_id bigint NULL,    -- reference the policy/law that applies to the Taxon using the internal id
	publish boolean NOT NULL   DEFAULT false,    -- Indicates if a heat map for this species should be published
	selectie_kans decimal NULL    -- This column indicates if the report selection should deviate from the standard 0,75. This number would be the change for this specific specie
)
;

ALTER TABLE besi.besi_taxa
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.effect_besi_species_group
(
	besi_species_group_id bigint NOT NULL,    -- Reference to the table BesiSpeciesGroup.
	effect_id bigint NOT NULL    -- reference to the effect using the internal id.
)
;

ALTER TABLE besi.effect_besi_species_group
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.effect_soort
(
	effect_id bigint NOT NULL,    -- reference to the effect using the internal id
	taxa_id bigint NOT NULL    -- reference to the taxon using the internal id
)
;

ALTER TABLE besi.effect_soort
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.effect_werkzaamheid
(
	werkzaamheid_id bigint NOT NULL,    -- reference to the workItem using the internal id
	effect_id bigint NOT NULL    -- reference to the effect using the internal id
)
;

ALTER TABLE besi.effect_werkzaamheid
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.taxa_kans_versie
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	versie bigint NOT NULL,    -- version of the probability map of the Taxon
	datum date NOT NULL,    -- start validity of the probability map for the Taxon.
	omschrijving text NULL    -- description of the probability map for the Taxon.
)
;

ALTER TABLE besi.taxa_kans_versie
    OWNER to anlb;


CREATE TABLE IF NOT EXISTS besi.taxa_kansen_huidig
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	grid_id bigint NOT NULL,    -- reference to the grid cell specifying the actual geographical location of the probability.
	kans decimal NOT NULL,    -- probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance
	dichtheid decimal NULL,    -- Model-based representation of spatial distribution of observations. Provides more information than just presence and absence.
	kwantiel integer NULL    -- Population centers based on chance maps.
)
;

ALTER TABLE besi.taxa_kansen_huidig
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS besi.taxa_rapport_text
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	beschrijving_habitat varchar(255) NULL,    -- specific text on the habitat of the Taxon
	gevoeligheid varchar(255) NULL,    -- Short description on potential negative effects to the Taxon
	advies varchar(600) NULL    -- Text describing the advise on how to avoid or lessen the negative effects on the Taxon
)
;

ALTER TABLE besi.taxa_rapport_text
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('besi','basis_grid','PK_basis_grid',
'ALTER TABLE besi.basis_grid ADD CONSTRAINT PK_basis_grid
	PRIMARY KEY (id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_access_database_versie','PK_besi_access_database_versie',
'ALTER TABLE besi.besi_access_database_versie ADD CONSTRAINT PK_besi_access_database_versie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_access_database_versie','UN_versienummer',
'ALTER TABLE besi.besi_access_database_versie ADD CONSTRAINT UN_versienummer UNIQUE (versienummer)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group','PK_besi_species_group',
'ALTER TABLE besi.besi_species_group ADD CONSTRAINT PK_besi_species_group
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group','UN_besi_species_group_identity',
'ALTER TABLE besi.besi_species_group ADD CONSTRAINT UN_besi_species_group_identity UNIQUE (identity)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_species_group_dmn_beschermende_factor ON besi.besi_species_group (beschermende_factor_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kans_versie','PK_besi_species_group_kans_versie',
'ALTER TABLE besi.besi_species_group_kans_versie ADD CONSTRAINT PK_besi_species_group_kans_versie
	PRIMARY KEY (versie,besi_species_group_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_species_group_kans_versie_besi_species_group ON besi.besi_species_group_kans_versie (besi_species_group_id ASC)
;


SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig','PK_besi_species_group_kansen_huidig',
'ALTER TABLE besi.besi_species_group_kansen_huidig ADD CONSTRAINT PK_besi_species_group_kansen_huidig
	PRIMARY KEY (grid_id,besi_species_group_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_rapport_text','PK_besi_species_group_rapport_text',
'ALTER TABLE besi.besi_species_group_rapport_text ADD CONSTRAINT PK_besi_species_group_rapport_text
	PRIMARY KEY (besi_species_group_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_species_group_rapport_text_besi_species_group ON besi.besi_species_group_rapport_text (besi_species_group_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_taxa','PK_besi_taxa',
'ALTER TABLE besi.besi_taxa ADD CONSTRAINT PK_besi_taxa
	PRIMARY KEY (taxa_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_taxa_dmn_beschermende_factor ON besi.besi_taxa (beschermende_factor_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_besi_taxa_taxa ON besi.besi_taxa (taxa_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_besi_species_group','PK_effect_besi_species_group',
'ALTER TABLE besi.effect_besi_species_group ADD CONSTRAINT PK_effect_besi_species_group
	PRIMARY KEY (besi_species_group_id,effect_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_effect_besi_species_group_besi_species_group ON besi.effect_besi_species_group (besi_species_group_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_effect_besi_species_group_dmn_effect ON besi.effect_besi_species_group (effect_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_soort','PK_effect_soort',
'ALTER TABLE besi.effect_soort ADD CONSTRAINT PK_effect_soort
	PRIMARY KEY (effect_id,taxa_id)
;');


CREATE INDEX IF NOT EXISTS IXFK_effect_soort_dmn_effect ON besi.effect_soort (effect_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_effect_soort_taxa ON besi.effect_soort (taxa_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_werkzaamheid','PK_effect_werkzaamheid',
'ALTER TABLE besi.effect_werkzaamheid ADD CONSTRAINT PK_effect_werkzaamheid
	PRIMARY KEY (werkzaamheid_id,effect_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_effect_werkzaamheid_dmn_effect ON besi.effect_werkzaamheid (effect_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_effect_werkzaamheid_werkzaamheid ON besi.effect_werkzaamheid (werkzaamheid_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kans_versie','PK_taxa_kans_versie',
'ALTER TABLE besi.taxa_kans_versie ADD CONSTRAINT PK_taxa_kans_versie
	PRIMARY KEY (versie,taxa_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_taxa_kans_versie_taxa ON besi.taxa_kans_versie (taxa_id ASC)
;


SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig','PK_taxa_kansen_huidig',
'ALTER TABLE besi.taxa_kansen_huidig ADD CONSTRAINT PK_taxa_kansen_huidig
	PRIMARY KEY (taxa_id,grid_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_rapport_text','PK_taxa_rapport_text',
'ALTER TABLE besi.taxa_rapport_text ADD CONSTRAINT PK_taxa_rapport_text
	PRIMARY KEY (taxa_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_taxa_rapport_text_taxa ON besi.taxa_rapport_text (taxa_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group','FK_besi_species_group_dmn_beschermende_factor',
'ALTER TABLE besi.besi_species_group ADD CONSTRAINT FK_besi_species_group_dmn_beschermende_factor
	FOREIGN KEY (beschermende_factor_id) REFERENCES masterdata.dmn_beschermende_factor (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kans_versie','FK_besi_species_group_kans_versie_besi_species_group',
'ALTER TABLE besi.besi_species_group_kans_versie ADD CONSTRAINT FK_besi_species_group_kans_versie_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig','FK_besi_species_group_kansen_huidig_basis_grid',
'ALTER TABLE besi.besi_species_group_kansen_huidig ADD CONSTRAINT FK_besi_species_group_kansen_huidig_basis_grid
	FOREIGN KEY (grid_id) REFERENCES besi.basis_grid (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig','FK_besi_species_group_kansen_huidig_besi_species_group',
'ALTER TABLE besi.besi_species_group_kansen_huidig ADD CONSTRAINT FK_besi_species_group_kansen_huidig_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_rapport_text','FK_besi_species_group_rapport_text_besi_species_group',
'ALTER TABLE besi.besi_species_group_rapport_text ADD CONSTRAINT FK_besi_species_group_rapport_text_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_taxa','FK_besi_taxa_dmn_beschermende_factor',
'ALTER TABLE besi.besi_taxa ADD CONSTRAINT FK_besi_taxa_dmn_beschermende_factor
	FOREIGN KEY (beschermende_factor_id) REFERENCES masterdata.dmn_beschermende_factor (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_taxa','FK_besi_taxa_taxa',
'ALTER TABLE besi.besi_taxa ADD CONSTRAINT FK_besi_taxa_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_besi_species_group','FK_effect_besi_species_group_besi_species_group',
'ALTER TABLE besi.effect_besi_species_group ADD CONSTRAINT FK_effect_besi_species_group_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_besi_species_group','FK_effect_besi_species_group_dmn_effect',
'ALTER TABLE besi.effect_besi_species_group ADD CONSTRAINT FK_effect_besi_species_group_dmn_effect
	FOREIGN KEY (effect_id) REFERENCES masterdata.dmn_effect (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_soort','FK_effect_soort_dmn_effect',
'ALTER TABLE besi.effect_soort ADD CONSTRAINT FK_effect_soort_dmn_effect
	FOREIGN KEY (effect_id) REFERENCES masterdata.dmn_effect (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_soort','FK_effect_soort_taxa',
'ALTER TABLE besi.effect_soort ADD CONSTRAINT FK_effect_soort_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_werkzaamheid','FK_effect_werkzaamheid_dmn_effect',
'ALTER TABLE besi.effect_werkzaamheid ADD CONSTRAINT FK_effect_werkzaamheid_dmn_effect
	FOREIGN KEY (effect_id) REFERENCES masterdata.dmn_effect (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','effect_werkzaamheid','FK_effect_werkzaamheid_werkzaamheid',
'ALTER TABLE besi.effect_werkzaamheid ADD CONSTRAINT FK_effect_werkzaamheid_werkzaamheid
	FOREIGN KEY (werkzaamheid_id) REFERENCES dso.werkzaamheid (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kans_versie','FK_taxa_kans_versie_taxa',
'ALTER TABLE besi.taxa_kans_versie ADD CONSTRAINT FK_taxa_kans_versie_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig','FK_taxa_kansen_huidig_basis_grid',
'ALTER TABLE besi.taxa_kansen_huidig ADD CONSTRAINT FK_taxa_kansen_huidig_basis_grid
	FOREIGN KEY (grid_id) REFERENCES besi.basis_grid (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig','FK_taxa_kansen_huidig_taxa',
'ALTER TABLE besi.taxa_kansen_huidig ADD CONSTRAINT FK_taxa_kansen_huidig_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_rapport_text','FK_taxa_rapport_text_taxa',
'ALTER TABLE besi.taxa_rapport_text ADD CONSTRAINT FK_taxa_rapport_text_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

/* CREATE TABLE IF NOT EXISTS Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE besi.basis_grid
	IS 'contains a set of adjoining squares of 25m2 that covers the full extend of the Netherlands'
;

COMMENT ON COLUMN besi.basis_grid.id
	IS 'id of the grid cell'
;

COMMENT ON COLUMN besi.basis_grid.geom
	IS '25m2 square of the grid cell'
;

COMMENT ON TABLE besi.besi_species_group
	IS 'Table where it stores species groups that are only applicable in Besi, which means not scientific defined.'
;

COMMENT ON COLUMN besi.besi_species_group.selectie_kans
	IS 'This column indicates if the report selection should deviate from the standard 0,75. This number would be the change for this specific specie'
;

COMMENT ON TABLE besi.besi_species_group_kans_versie
	IS 'List of different versions of probability maps available per besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie.besi_species_group_id
	IS 'Reference to the table BesiSpeciesGroup.'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie.versie
	IS 'version of the probability map of the besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie.datum
	IS 'start validity of the probability map for the besi species group.'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie.omschrijving
	IS 'description of the probability map for the besi species group.'
;


COMMENT ON TABLE besi.besi_species_group_kansen_huidig
	IS 'specifies per besi species group,the latest version of the probability map, per grid cell several indicators if a besi species group could be found at the grid cell'
;

COMMENT ON COLUMN besi.besi_species_group_kansen_huidig.grid_id
	IS 'reference to the grid cell specifying the actual geographical location of the probability.'
;

COMMENT ON COLUMN besi.besi_species_group_kansen_huidig.kans
	IS 'probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance.'
;


COMMENT ON TABLE besi.besi_species_group_rapport_text
	IS 'The texts that will be shown to the user in the report when relevant for the selections they made.'
;

COMMENT ON COLUMN besi.besi_species_group_rapport_text.besi_species_group_id
	IS 'Reference to the table BesiSpeciesGroup.'
;

COMMENT ON COLUMN besi.besi_species_group_rapport_text.beschrijving_habitat
	IS 'specific text on the habitat of the besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_rapport_text.gevoeligheid
	IS 'Short description on potential negative effects to the besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_rapport_text.advies
	IS 'Text describing the advise on how to avoid or lessen the negative effects on the besi species group'
;

COMMENT ON TABLE besi.besi_taxa
	IS 'Contains all Taxa that are relevant for BESI.And contains specific attributes not defined by NDFF'
;

COMMENT ON COLUMN besi.besi_taxa.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.besi_taxa.valid_from
	IS 'start validity of the taxon in relationship with BESI'
;

COMMENT ON COLUMN besi.besi_taxa.valid_to
	IS 'end validity of the taxon in relationship with BESI'
;

COMMENT ON COLUMN besi.besi_taxa.beschermende_factor_id
	IS 'reference the policy/law that applies to the Taxon using the internal id'
;

COMMENT ON COLUMN besi.besi_taxa.publish
	IS 'Indicates if a heat map for this species should be published'
;

COMMENT ON COLUMN besi.besi_taxa.selectie_kans
	IS 'This column indicates if the report selection should deviate from the standard 0,75. This number would be the change for this specific specie'
;

COMMENT ON TABLE besi.effect_besi_species_group
	IS 'Defines what negative effects on flora and fauna apply to what besi species group'
;

COMMENT ON COLUMN besi.effect_besi_species_group.besi_species_group_id
	IS 'Reference to the table BesiSpeciesGroup.'
;

COMMENT ON COLUMN besi.effect_besi_species_group.effect_id
	IS 'reference to the effect using the internal id.'
;

COMMENT ON TABLE besi.effect_soort
	IS 'Defines what negative effects on flora and fauna apply to what species of specific taxa of flora and fauna'
;

COMMENT ON COLUMN besi.effect_soort.effect_id
	IS 'reference to the effect using the internal id'
;

COMMENT ON COLUMN besi.effect_soort.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON TABLE besi.effect_werkzaamheid
	IS 'Defines what negative effects on flora and fauna can be caused by the workItem'
;

COMMENT ON COLUMN besi.effect_werkzaamheid.werkzaamheid_id
	IS 'reference to the workItem using the internal id'
;

COMMENT ON COLUMN besi.effect_werkzaamheid.effect_id
	IS 'reference to the effect using the internal id'
;

COMMENT ON TABLE besi.taxa_kans_versie
	IS 'List of different versions of probability maps available per Taxon'
;

COMMENT ON COLUMN besi.taxa_kans_versie.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.taxa_kans_versie.versie
	IS 'version of the probability map of the Taxon'
;

COMMENT ON COLUMN besi.taxa_kans_versie.datum
	IS 'start validity of the probability map for the Taxon.'
;

COMMENT ON COLUMN besi.taxa_kans_versie.omschrijving
	IS 'description of the probability map for the Taxon.'
;

COMMENT ON TABLE besi.taxa_kansen_huidig
	IS 'specifies per species,the latest version of the probability map, per grid cell several indicators if a taxon could be found at the grid cell'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig.grid_id
	IS 'reference to the grid cell specifying the actual geographical location of the probability.'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig.kans
	IS 'probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance'
;


COMMENT ON TABLE besi.taxa_rapport_text
	IS 'The texts that will be shown to the user in the report when relevant for the selections they made.'
;

COMMENT ON COLUMN besi.taxa_rapport_text.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.taxa_rapport_text.beschrijving_habitat
	IS 'specific text on the habitat of the Taxon'
;

COMMENT ON COLUMN besi.taxa_rapport_text.gevoeligheid
	IS 'Short description on potential negative effects to the Taxon'
;

COMMENT ON COLUMN besi.taxa_rapport_text.advies
	IS 'Text describing the advise on how to avoid or lessen the negative effects on the Taxon'
;

/* Create Views */

CREATE OR REPLACE VIEW besi.v_gs_besi_species_group_kans_versie
 AS
 SELECT k.besi_species_group_id,
    t.identity,
    t.name,
    t.scientific,
    k.versie,
    k.datum,
    k.omschrijving
   FROM besi.besi_species_group_kans_versie k
     JOIN besi.besi_species_group t ON t.id = k.besi_species_group_id
  WHERE (EXISTS ( SELECT 1
           FROM besi.besi_species_group t_1
          WHERE t_1.id = k.besi_species_group_id AND t_1.publish = true)) AND NOT (EXISTS ( SELECT 1
           FROM besi.besi_species_group_kans_versie kh
          WHERE kh.besi_species_group_id = k.besi_species_group_id AND kh.versie > k.versie));

ALTER TABLE besi.v_gs_besi_species_group_kans_versie
    OWNER TO anlb;



-- View: besi.v_gs_species_group_kansen

 CREATE OR REPLACE VIEW besi.v_gs_besi_species_group_kansen
 AS
 SELECT k.besi_species_group_id,
    t.identity,
    t.name,
    t.scientific,
    k.kans,
    g.geom
   FROM besi.besi_species_group_kansen_huidig k
   JOIN besi.basis_grid g ON g.id = k.grid_id
   JOIN besi.besi_species_group t ON t.id = k.besi_species_group_id
  WHERE k.kans > 0::numeric 
    AND (EXISTS ( SELECT 1
                    FROM besi.besi_species_group t_1
                   WHERE t_1.id = k.besi_species_group_id 
					 AND t_1.publish = true)) ; 
ALTER TABLE besi.v_gs_besi_species_group_kansen
    OWNER TO anlb;



-- View: besi.v_gs_taxa_kans_versie

CREATE OR REPLACE VIEW besi.v_gs_taxa_kans_versie
 AS
 SELECT k.taxa_id,
    t.identity,
    t.name,
    t.scientific,
    k.versie,
    k.datum,
    k.omschrijving
   FROM besi.taxa_kans_versie k
     JOIN ndff.taxa t ON t.id = k.taxa_id
  WHERE (EXISTS ( SELECT 1
           FROM besi.besi_taxa t_1
          WHERE t_1.taxa_id = k.taxa_id AND t_1.publish = true)) AND NOT (EXISTS ( SELECT 1
           FROM besi.taxa_kans_versie kh
          WHERE kh.taxa_id = k.taxa_id AND kh.versie > k.versie));

ALTER TABLE besi.v_gs_taxa_kans_versie
    OWNER TO anlb;


-- View: besi.v_gs_taxa_kansen

 CREATE OR REPLACE VIEW besi.v_gs_taxa_kansen
 AS
 SELECT k.taxa_id,
    t.identity,
    t.name,
    t.scientific,
    k.kans,
    g.geom
   FROM besi.taxa_kansen_huidig k
   JOIN besi.basis_grid g ON g.id = k.grid_id
   JOIN ndff.taxa t ON t.id = k.taxa_id
  WHERE k.kans > 0::numeric 
    AND (EXISTS ( SELECT 1
                    FROM besi.besi_taxa t_1
                   WHERE t_1.taxa_id = k.taxa_id 
					 AND t_1.publish = true)) ; 
ALTER TABLE besi.v_gs_taxa_kansen
    OWNER TO anlb;



-- View: besi.v_gw_besi_star

CREATE OR REPLACE VIEW besi.v_gw_besi_star
 AS
  SELECT effect_werkzaamheid.werkzaamheid_id,
		effect_soort.taxa_id,
		taxa_kansen_huidig.grid_id
   FROM besi.effect_werkzaamheid
   JOIN besi.effect_soort ON effect_werkzaamheid.effect_id = effect_soort.effect_id
   JOIN besi.taxa_kansen_huidig ON taxa_kansen_huidig.taxa_id = effect_soort.taxa_id
   JOIN besi.besi_taxa ON besi_taxa.taxa_id = taxa_kansen_huidig.taxa_id 
  WHERE (EXISTS ( SELECT 1
                    FROM besi.besi_taxa
                   WHERE besi_taxa.taxa_id = effect_soort.taxa_id 
				     AND besi_taxa.valid_to IS NULL)) 
	AND (EXISTS ( SELECT 1
					FROM besi.taxa_rapport_text
					WHERE taxa_rapport_text.taxa_id = effect_soort.taxa_id)) 
	AND ((besi_taxa.selectie_kans is NULL AND taxa_kansen_huidig.kans > 0.75)
	OR (besi_taxa.selectie_kans is NOT NULL AND taxa_kansen_huidig.kans > besi_taxa.selectie_kans));

ALTER TABLE besi.v_gw_besi_star
    OWNER TO anlb;
;

-- View: besi.v_gw_besi_star_besi_species_group


CREATE OR REPLACE VIEW besi.v_gw_besi_star_besi_species_group
 AS
 SELECT effect_werkzaamheid.werkzaamheid_id,
		effect_besi_species_group.besi_species_group_id,
		besi_species_group_kansen_huidig.grid_id
   FROM besi.effect_werkzaamheid
   JOIN besi.effect_besi_species_group ON effect_werkzaamheid.effect_id = effect_besi_species_group.effect_id
   JOIN besi.besi_species_group_kansen_huidig ON besi_species_group_kansen_huidig.besi_species_group_id = effect_besi_species_group.besi_species_group_id
   JOIN besi.besi_species_group ON besi_species_group.id = besi_species_group_kansen_huidig.besi_species_group_id 
  WHERE (EXISTS ( SELECT 1
                    FROM besi.besi_species_group
                   WHERE besi_species_group.id = effect_besi_species_group.besi_species_group_id 
				     AND besi_species_group.valid_to IS NULL)) 
	AND (EXISTS ( SELECT 1
					FROM besi.besi_species_group_rapport_text
					WHERE besi_species_group_rapport_text.besi_species_group_id = effect_besi_species_group.besi_species_group_id)) 
	AND ((besi_species_group.selectie_kans is NULL AND besi_species_group_kansen_huidig.kans > 0.75)
	OR (besi_species_group.selectie_kans is NOT NULL AND besi_species_group_kansen_huidig.kans > besi_species_group.selectie_kans));


ALTER TABLE besi.v_gw_besi_star_besi_species_group
    OWNER TO anlb;
;

/* Create Functions */

CREATE INDEX IF NOT EXISTS "IDX_basis_grid_geom"
    ON besi.basis_grid USING gist
    (geom);
	


GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;


/* IMNA-9871 Besi new database user account */
GRANT SELECT ON besi.basis_grid TO besi_geoweb;
GRANT SELECT ON besi.besi_access_database_versie TO besi_geoweb;
GRANT USAGE ON SCHEMA besi TO besi_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;
