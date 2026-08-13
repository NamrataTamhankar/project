CREATE OR REPLACE VIEW geoserver.snl_cbp_collectief_beheer_plan AS 
 SELECT *
   FROM "CNL".v_collectief_beheer_plan;

CREATE OR REPLACE VIEW geoserver.snl_cbp_beheer_eenheden AS 
 SELECT *
   FROM "CNL".v_beheer_eenheden;

  
-- GRANT ACCESS TO snl_sqlpad
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;   