-- beschikking_rapportage
CREATE OR REPLACE VIEW geoserver.imna_bes_beschikking_rapportage AS 
SELECT * 
  FROM imna.v_gs_beschikking_rapportage;
  
-- beschikking
CREATE OR REPLACE VIEW geoserver.imna_bes_beschikking AS 
SELECT * 
  FROM imna.v_gs_beschikking;

-- GRANT ACCESS TO snl_sqlpad
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad; 