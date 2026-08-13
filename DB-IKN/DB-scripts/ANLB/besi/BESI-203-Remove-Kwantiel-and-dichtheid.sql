
-- Drop Views from Geoserver schema
DROP VIEW IF EXISTS geoserver.besi_taxa_kwantiel;
DROP VIEW IF EXISTS geoserver.besi_besi_species_group_kwantiel;

-- Drop Views from BeSI schema
DROP VIEW IF EXISTS besi.v_gs_taxa_kwantiel;
DROP VIEW IF EXISTS besi.v_gs_taxa_kansen_kwantiel;
DROP VIEW IF EXISTS besi.v_gs_besi_species_group_kansen_kwantiel;
DROP VIEW IF EXISTS besi.v_gs_besi_species_group_kwantiel;

-- Update View besi.v_gw_besi_all_species_in_grid
DROP VIEW IF EXISTS besi.v_gw_besi_all_species_in_grid;
CREATE OR REPLACE VIEW besi.v_gw_besi_all_species_in_grid
 AS
 SELECT t.identity, t.name, t.scientific, 
	bt.valid_from, bt.valid_to, bt.publish, 
	tkh.grid_id, tkh.kans
  FROM besi.besi_taxa bt
  JOIN besi.taxa_kansen_huidig tkh on tkh.taxa_id = bt.taxa_id
  JOIN ndff.taxa t on t.id = bt.taxa_id
  WHERE bt.valid_to IS NULL
UNION
SELECT sg.identity, sg.name, sg.scientific, 
	sg.valid_from, sg.valid_to, sg.publish, 
	sgkh.grid_id, sgkh.kans
  FROM besi.besi_species_group sg
  JOIN besi.besi_species_group_kansen_huidig sgkh on sgkh.besi_species_group_id = sg.id
  WHERE sg.valid_to IS NULL;

ALTER TABLE besi.v_gw_besi_all_species_in_grid
    OWNER TO anlb;
	
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;
GRANT SELECT ON besi.v_gw_besi_all_species_in_grid TO anlb_sqlpad;
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;

-- Drop attributes from taxa_kansen_huidig
ALTER TABLE besi.taxa_kansen_huidig DROP COLUMN IF EXISTS kwantiel;
ALTER TABLE besi.taxa_kansen_huidig DROP COLUMN IF EXISTS dichtheid;

-- Drop attributes from -- Drop attributes from besi_species_group_kansen_huidig
ALTER TABLE besi.besi_species_group_kansen_huidig DROP COLUMN IF EXISTS kwantiel;
ALTER TABLE besi.besi_species_group_kansen_huidig DROP COLUMN IF EXISTS dichtheid;