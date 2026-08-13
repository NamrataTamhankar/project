-- Create the tables:
-- besi.besi_species_group_kans_versie_staging
-- besi.besi_species_group_kansen_huidig_staging
-- besi.taxa_kans_versie_staging
-- besi.taxa_kansen_huidig_staging

CREATE TABLE IF NOT EXISTS besi.besi_species_group_kans_versie_staging
(
	besi_species_group_id bigint NOT NULL,    -- Reference to the table BesiSpeciesGroup.
	versie bigint NOT NULL,    -- version of the probability map of the besi species group
	datum date NOT NULL,    -- start validity of the probability map for the besi species group.
	omschrijving text NULL    -- description of the probability map for the besi species group.
);

ALTER TABLE besi.besi_species_group_kans_versie_staging
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.besi_species_group_kansen_huidig_staging
(
	besi_species_group_id bigint NOT NULL,
	grid_id bigint NOT NULL,    -- reference to the grid cell specifying the actual geographical location of the probability.
	kans decimal NOT NULL,    -- probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance.
	dichtheid decimal NULL,    -- Model-based representation of spatial distribution of observations. Provides more information than just presence and absence.
	kwantiel integer NULL    -- Population centers based on chance maps.
);

ALTER TABLE besi.besi_species_group_kansen_huidig_staging
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.taxa_kans_versie_staging
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	versie bigint NOT NULL,    -- version of the probability map of the Taxon
	datum date NOT NULL,    -- start validity of the probability map for the Taxon.
	omschrijving text NULL    -- description of the probability map for the Taxon.
);

ALTER TABLE besi.taxa_kans_versie_staging
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.taxa_kansen_huidig_staging
(
	taxa_id bigint NOT NULL,    -- reference to the taxon using the internal id
	grid_id bigint NOT NULL,    -- reference to the grid cell specifying the actual geographical location of the probability.
	kans decimal NOT NULL,    -- probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance
	dichtheid decimal NULL,    -- Model-based representation of spatial distribution of observations. Provides more information than just presence and absence.
	kwantiel integer NULL    -- Population centers based on chance maps.
);

ALTER TABLE besi.taxa_kansen_huidig_staging
    OWNER to anlb;

-- Create the tables:
-- geoweb.besi_geotiff_staging
-- geoweb.besi_geotiff_files_staging
-- geoweb.besi_species_group_geotiff_staging
-- geoweb.besi_species_group_geotiff_files_staging

CREATE TABLE IF NOT EXISTS geoweb.besi_geotiff_staging
(
	taxa_id bigint NOT NULL,
	versie bigint NOT NULL,
	creation_date timestamp NOT NULL
);

ALTER TABLE geoweb.besi_geotiff_staging
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoweb.besi_geotiff_files_staging
(
	taxa_id bigint NOT NULL,
	versie bigint NOT NULL,
	sequence bigint NOT NULL,    -- Sequence of the file, for every file in besi_geotiff it starts by 1 again
	file_name varchar(1024) NOT NULL,    -- Name of the file
	file_type varchar(50) NOT NULL    -- File type of the file
);

ALTER TABLE geoweb.besi_geotiff_files_staging
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoweb.besi_species_group_geotiff_staging
(
	besi_species_group_id bigint NOT NULL,
	versie bigint NOT NULL,
	creation_date timestamp NOT NULL
)
;

ALTER TABLE geoweb.besi_species_group_geotiff_staging
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoweb.besi_species_group_geotiff_files_staging
(
	besi_species_group_id bigint NOT NULL,
	versie bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL
)
;

ALTER TABLE geoweb.besi_species_group_geotiff_files
    OWNER to anlb;

-- Add comments to the tables and attributes

COMMENT ON TABLE besi.besi_species_group_kans_versie_staging
	IS 'List of different versions of probability maps available per besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie_staging.besi_species_group_id
	IS 'Reference to the table BesiSpeciesGroup.'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie_staging.versie
	IS 'version of the probability map of the besi species group'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie_staging.datum
	IS 'start validity of the probability map for the besi species group.'
;

COMMENT ON COLUMN besi.besi_species_group_kans_versie_staging.omschrijving
	IS 'description of the probability map for the besi species group.'
;

COMMENT ON TABLE besi.besi_species_group_kansen_huidig_staging
	IS 'specifies per besi species group,the latest version of the probability map, per grid cell several indicators if a besi species group could be found at the grid cell'
;

COMMENT ON COLUMN besi.besi_species_group_kansen_huidig_staging.grid_id
	IS 'reference to the grid cell specifying the actual geographical location of the probability.'
;

COMMENT ON COLUMN besi.besi_species_group_kansen_huidig_staging.kans
	IS 'probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance.'
;

COMMENT ON TABLE besi.taxa_kans_versie_staging
	IS 'List of different versions of probability maps available per Taxon'
;

COMMENT ON COLUMN besi.taxa_kans_versie_staging.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.taxa_kans_versie_staging.versie
	IS 'version of the probability map of the Taxon'
;

COMMENT ON COLUMN besi.taxa_kans_versie_staging.datum
	IS 'start validity of the probability map for the Taxon.'
;

COMMENT ON COLUMN besi.taxa_kans_versie_staging.omschrijving
	IS 'description of the probability map for the Taxon.'
;

COMMENT ON TABLE besi.taxa_kansen_huidig_staging
	IS 'specifies per species,the latest version of the probability map, per grid cell several indicators if a taxon could be found at the grid cell'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig_staging.taxa_id
	IS 'reference to the taxon using the internal id'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig_staging.grid_id
	IS 'reference to the grid cell specifying the actual geographical location of the probability.'
;

COMMENT ON COLUMN besi.taxa_kansen_huidig_staging.kans
	IS 'probability that a species could exists or lives at the grid cell. value is between 0 and 1, with  0% indicating no chance, and 1 indication 100% chance'
;

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN geoweb.besi_geotiff.creation_date
	IS 'Creation date of the geotiff '
;

COMMENT ON COLUMN geoweb.besi_geotiff_files.sequence
	IS 'Sequence of the file, for every file in besi_geotiff it starts by 1 again'
;

COMMENT ON COLUMN geoweb.besi_geotiff_files.file_name
	IS 'Name of the file'
;

COMMENT ON COLUMN geoweb.besi_geotiff_files.file_type
	IS 'File type of the file'
;

COMMENT ON COLUMN geoweb.besi_species_group_geotiff.creation_date
	IS 'Creation date of the geotiff '
;

COMMENT ON COLUMN geoweb.besi_species_group_geotiff_files.sequence
	IS 'Sequence of the file, for every file in besi_species_group_geotiff it starts by 1 again'
;

COMMENT ON COLUMN geoweb.besi_species_group_geotiff_files.file_name
	IS 'Name of the file'
;

COMMENT ON COLUMN geoweb.besi_species_group_geotiff_files.file_type
	IS 'File type of the file'
;

-- Set 

GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad;










