CREATE OR REPLACE FUNCTION pg_temp.create_constraint_if_not_exists (
    t_schema_name text, t_table_name text, t_constraint_name text, t_constraint_sql text
) 
RETURNS void AS
$$
BEGIN
    -- Look for our constraint
    IF NOT EXISTS ( SELECT 1
                      FROM information_schema.constraint_column_usage 
                     WHERE constraint_schema = t_schema_name
					   AND table_name = t_table_name
                       AND constraint_name = LOWER(t_constraint_name)
					 UNION 
					SELECT 1 
					  FROM information_schema.table_constraints
					 WHERE table_name = t_table_name
                       AND constraint_name = LOWER(t_constraint_name))
    THEN
        EXECUTE t_constraint_sql;
		RAISE NOTICE 'constraint % % added',t_table_name,t_constraint_name;
	ELSE
		RAISE NOTICE 'constraint % % already exists, skipping',t_table_name,t_constraint_name;
    END IF;
END;
$$ LANGUAGE 'plpgsql';

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kans_versie_staging','PK_besi_species_group_kans_versie_staging',
'ALTER TABLE besi.besi_species_group_kans_versie_staging ADD CONSTRAINT PK_besi_species_group_kans_versie_staging
	PRIMARY KEY (versie,besi_species_group_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_species_group_kans_versie_staging_besi_species_group ON besi.besi_species_group_kans_versie_staging (besi_species_group_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig_staging','PK_besi_species_group_kansen_huidig_staging',
'ALTER TABLE besi.besi_species_group_kansen_huidig_staging ADD CONSTRAINT PK_besi_species_group_kansen_huidig_staging
	PRIMARY KEY (grid_id,besi_species_group_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kans_versie_staging','PK_taxa_kans_versie_staging',
'ALTER TABLE besi.taxa_kans_versie_staging ADD CONSTRAINT PK_taxa_kans_versie_staging
	PRIMARY KEY (versie,taxa_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_taxa_kans_versie_staging_taxa ON besi.taxa_kans_versie_staging (taxa_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig_staging','PK_taxa_kansen_huidig_staging',
'ALTER TABLE besi.taxa_kansen_huidig_staging ADD CONSTRAINT PK_taxa_kansen_huidig_staging
	PRIMARY KEY (taxa_id,grid_id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kans_versie_staging','FK_besi_species_group_kans_versie_staging_besi_species_group',
'ALTER TABLE besi.besi_species_group_kans_versie_staging ADD CONSTRAINT FK_besi_species_group_kans_versie_staging_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig_staging','FK_besi_species_group_kansen_huidig_staging_basis_grid',
'ALTER TABLE besi.besi_species_group_kansen_huidig_staging ADD CONSTRAINT FK_besi_species_group_kansen_huidig_staging_basis_grid
	FOREIGN KEY (grid_id) REFERENCES besi.basis_grid (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_species_group_kansen_huidig_staging','FK_besi_species_group_kansen_huidig_staging_besi_species_group',
'ALTER TABLE besi.besi_species_group_kansen_huidig_staging ADD CONSTRAINT FK_besi_species_group_kansen_huidig_staging_besi_species_group
	FOREIGN KEY (besi_species_group_id) REFERENCES besi.besi_species_group (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kans_versie_staging','FK_taxa_kans_versie_taxa_staging',
'ALTER TABLE besi.taxa_kans_versie_staging ADD CONSTRAINT FK_taxa_kans_versie_taxa_staging
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig_staging','FK_taxa_kansen_huidig_staging_basis_grid',
'ALTER TABLE besi.taxa_kansen_huidig_staging ADD CONSTRAINT FK_taxa_kansen_huidig_staging_basis_grid
	FOREIGN KEY (grid_id) REFERENCES besi.basis_grid (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('besi','taxa_kansen_huidig_staging','FK_taxa_kansen_huidig_staging_taxa',
'ALTER TABLE besi.taxa_kansen_huidig_staging ADD CONSTRAINT FK_taxa_kansen_huidig_staging_taxa
	FOREIGN KEY (taxa_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action
;');





SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_geotiff_staging','PK_besi_geotiff_staging',
'ALTER TABLE geoweb.besi_geotiff_staging ADD CONSTRAINT PK_besi_geotiff_staging
	PRIMARY KEY (taxa_id,versie)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_geotiff_staging_taxa_kans_versie ON geoweb.besi_geotiff_staging (taxa_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_geotiff_files_staging','PK_besi_geotiff_files_staging',
'ALTER TABLE geoweb.besi_geotiff_files_staging ADD CONSTRAINT PK_besi_geotiff_files_staging
	PRIMARY KEY (taxa_id,versie,sequence)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_species_group_geotiff_staging','PK_besi_species_group_geotiff_staging',
'ALTER TABLE geoweb.besi_species_group_geotiff_staging ADD CONSTRAINT PK_besi_species_group_geotiff_staging
	PRIMARY KEY (besi_species_group_id,versie)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_species_group_geotiff_staging_besi_species_group ON geoweb.besi_species_group_geotiff_staging (besi_species_group_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_species_group_geotiff_files_staging','PK_besi_species_group_geotiff_files_staging',
'ALTER TABLE geoweb.besi_species_group_geotiff_files_staging ADD CONSTRAINT PK_besi_species_group_geotiff_files_staging
	PRIMARY KEY (besi_species_group_id,versie,sequence)
;');


/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_geotiff_staging','FK_besi_geotiff_staging_taxa_kans_versie',
'ALTER TABLE geoweb.besi_geotiff_staging ADD CONSTRAINT FK_besi_geotiff_staging_taxa_kans_versie
	FOREIGN KEY (taxa_id,versie) REFERENCES besi.taxa_kans_versie_staging (taxa_id,versie) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_geotiff_files_staging','FK_besi_geotiff_files_staging_besi_geotiff',
'ALTER TABLE geoweb.besi_geotiff_files_staging ADD CONSTRAINT FK_besi_geotiff_files_staging_besi_geotiff
	FOREIGN KEY (taxa_id,versie) REFERENCES geoweb.besi_geotiff_staging (taxa_id,versie) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_species_group_geotiff_staging','FK_besi_species_group_geotiff_staging_besi_species_group_kans_versie',
'ALTER TABLE geoweb.besi_species_group_geotiff_staging ADD CONSTRAINT FK_besi_species_group_geotiff_staging_besi_species_group_kans_versie
	FOREIGN KEY (besi_species_group_id,versie) REFERENCES besi.besi_species_group_kans_versie_staging (besi_species_group_id,versie) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_species_group_geotiff_files_staging','FK_besi_species_group_geotiff_files_staging_besi_species_group_geotiff',
'ALTER TABLE geoweb.besi_species_group_geotiff_files_staging ADD CONSTRAINT FK_besi_species_group_geotiff_files_staging_besi_species_group_geotiff
	FOREIGN KEY (besi_species_group_id,versie) REFERENCES geoweb.besi_species_group_geotiff_staging (besi_species_group_id,versie) ON DELETE No Action ON UPDATE No Action
;');