CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_agrarisch AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_agrarisch
  WHERE status = '2' OR status = '3';

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_landschap AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_landschap
  WHERE status = '2' OR status = '3';

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_natuur AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_natuur
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_ambitie
  WHERE status = '2' OR status = '3'; 
  
  CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_agrarisch AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_ambitie_agrarisch
  WHERE status = '2' OR status = '3';   
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_landschap AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_ambitie_landschap
  WHERE status = '2' OR status = '3';

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_natuur AS 
 SELECT *
   FROM "PNL".v_beheer_gebied_ambitie_natuur
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_ambitie_landschap AS 
 SELECT *
   FROM "PNL".v_zoek_gebied_ambitie_landschap
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_bijzonder_gebied AS 
 SELECT *
   FROM "PNL".v_bijzonder_gebied
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_deel_gebied AS 
 SELECT *
   FROM "PNL".v_deel_gebied
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_natuur_beheer_plan AS 
 SELECT *
   FROM "PNL".v_natuur_beheer_plan
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_agrarisch AS 
 SELECT *
   FROM "PNL".v_zoek_gebied_agrarisch
  WHERE status = '2' OR status = '3';

CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_landschap AS 
 SELECT *
   FROM "PNL".v_zoek_gebied_landschap
  WHERE status = '2' OR status = '3';
  
CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_water AS 
 SELECT *
   FROM "PNL".v_zoek_gebied_water
  WHERE status = '2' OR status = '3';
  
-- GRANT ACCESS TO snl_sqlpad
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;   