-- Schema: geoserver

-- DROP SCHEMA geoserver;

CREATE SCHEMA geoserver
  AUTHORIZATION anlb;

GRANT ALL ON SCHEMA geoserver TO anlb;
GRANT USAGE ON SCHEMA geoserver TO anlb_sqlpad;

-- NATUUR_BEHEER_PLAN
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_natuur_beheer_plan AS 
SELECT * 
  FROM imna.v_gs_natuur_beheer_plan
 WHERE (status = '2' OR status = '3');

-- BEHEER_GEBIED
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_beheer_gebied AS 
SELECT * 
  FROM imna.v_gs_beheer_gebied
  WHERE (status = '2' OR status = '3');
  
-- BEHEER_GEBIED_AMBITIE   
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_beheer_gebied_ambitie AS 
SELECT * 
  FROM imna.v_gs_beheer_gebied_ambitie
 WHERE (status = '2' OR status = '3');
  
-- BIJZONDER_GEBIED
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_bijzonder_gebied AS 
SELECT * 
  FROM imna.v_gs_bijzonder_gebied
  WHERE (status = '2' OR status = '3');
   
-- DEEL_GEBIED
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_deel_gebied AS 
SELECT * 
  FROM imna.v_gs_deel_gebied
  WHERE (status = '2' OR status = '3');
   
-- ZOEK_GEBIED_LANDSCHAP
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_zoek_gebied_landschap AS 
SELECT * 
  FROM imna.v_gs_zoek_gebied_landschap
  WHERE (status = '2' OR status = '3');
   
-- ZOEK_GEBIED_AGRARISCH
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_zoek_gebied_agrarisch AS 
SELECT * 
  FROM imna.v_gs_zoek_gebied_agrarisch
  WHERE (status = '2' OR status = '3');
   
-- ZOEK_GEBIED_WATER
CREATE OR REPLACE VIEW geoserver.imna_nbp_viewer_zoek_gebied_water AS 
SELECT * 
  FROM imna.v_gs_zoek_gebied_water
  WHERE (status = '2' OR status = '3');
   
-- GRANT ACCESS TO snl_sqlpad
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad; 