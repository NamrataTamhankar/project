-- VOORTGANGS_RAPPORTAGE
CREATE OR REPLACE VIEW geoserver.imna_vrn_voortgangs_rapportage AS 
SELECT * 
  FROM imna.v_gs_voortgangs_rapportage;
  
-- GEBIED_NATUUR
CREATE OR REPLACE VIEW geoserver.imna_vrn_gebied_natuur AS 
SELECT * 
  FROM imna.v_gs_gebied_natuur;

-- GEBIED_INRICHTING
CREATE OR REPLACE VIEW geoserver.imna_vrn_gebied_inrichting AS 
SELECT * 
  FROM imna.v_gs_gebied_inrichting;
  
-- GEBIED_VERWERVING
CREATE OR REPLACE VIEW geoserver.imna_vrn_gebied_verwerving AS 
SELECT * 
  FROM imna.v_gs_gebied_verwerving;

-- NATUUR_NETWERK_NEDERLAND
CREATE OR REPLACE VIEW geoserver.imna_vrn_natuur_netwerk_nederland AS 
SELECT * 
  FROM imna.v_gs_natuur_netwerk_nederland;  
  
-- RESTERENDE_INRICHINGS_AMBITIE
CREATE OR REPLACE VIEW geoserver.imna_vrn_resterende_inrichtings_ambitie AS 
SELECT * 
  FROM imna.v_gs_resterende_inrichtings_ambitie;  
   
-- GRANT ACCESS TO snl_sqlpad
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad; 