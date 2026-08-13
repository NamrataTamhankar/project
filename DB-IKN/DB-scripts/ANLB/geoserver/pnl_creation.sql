\echo "Starting deployment of GeoServer - PNL Creation"

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_agrarisch AS 
 SELECT v_beheer_gebied_agrarisch.provincie,
    v_beheer_gebied_agrarisch.status,
    v_beheer_gebied_agrarisch.status_desc,
    v_beheer_gebied_agrarisch.subsidie_jaar,
    v_beheer_gebied_agrarisch.identificatie,
    v_beheer_gebied_agrarisch.beheer_type,
    v_beheer_gebied_agrarisch.beheer_type_desc,
    v_beheer_gebied_agrarisch.subsidiabel,
    v_beheer_gebied_agrarisch.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_agrarisch.toegestane_beheer_paketten,
    v_beheer_gebied_agrarisch.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied_agrarisch.geometry
   FROM "PNL".v_beheer_gebied_agrarisch
  WHERE ((v_beheer_gebied_agrarisch.status = 2) OR (v_beheer_gebied_agrarisch.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie AS 
 SELECT v_beheer_gebied_ambitie.provincie,
    v_beheer_gebied_ambitie.status,
    v_beheer_gebied_ambitie.status_desc,
    v_beheer_gebied_ambitie.subsidie_jaar,
    v_beheer_gebied_ambitie.identificatie,
    v_beheer_gebied_ambitie.beheer_type,
    v_beheer_gebied_ambitie.beheer_type_desc,
    v_beheer_gebied_ambitie.subsidiabel,
    v_beheer_gebied_ambitie.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie.recreatie_type,
    v_beheer_gebied_ambitie.recreatie_type_desc,
    v_beheer_gebied_ambitie.taak_stelling,
    v_beheer_gebied_ambitie.taak_stelling_desc,
    v_beheer_gebied_ambitie.status_ehs,
    v_beheer_gebied_ambitie.status_ehs_desc,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie.geometry
   FROM "PNL".v_beheer_gebied_ambitie
  WHERE ((v_beheer_gebied_ambitie.status = 2) OR (v_beheer_gebied_ambitie.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_ambitie
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_agrarisch AS 
 SELECT v_beheer_gebied_ambitie_agrarisch.provincie,
    v_beheer_gebied_ambitie_agrarisch.status,
    v_beheer_gebied_ambitie_agrarisch.status_desc,
    v_beheer_gebied_ambitie_agrarisch.subsidie_jaar,
    v_beheer_gebied_ambitie_agrarisch.identificatie,
    v_beheer_gebied_ambitie_agrarisch.beheer_type,
    v_beheer_gebied_ambitie_agrarisch.beheer_type_desc,
    v_beheer_gebied_ambitie_agrarisch.subsidiabel,
    v_beheer_gebied_ambitie_agrarisch.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie_agrarisch.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie_agrarisch.recreatie_type,
    v_beheer_gebied_ambitie_agrarisch.recreatie_type_desc,
    v_beheer_gebied_ambitie_agrarisch.taak_stelling,
    v_beheer_gebied_ambitie_agrarisch.taak_stelling_desc,
    v_beheer_gebied_ambitie_agrarisch.status_ehs,
    v_beheer_gebied_ambitie_agrarisch.status_ehs_desc,
    v_beheer_gebied_ambitie_agrarisch.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie_agrarisch.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie_agrarisch.geometry
   FROM "PNL".v_beheer_gebied_ambitie_agrarisch
  WHERE ((v_beheer_gebied_ambitie_agrarisch.status = 2) OR (v_beheer_gebied_ambitie_agrarisch.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_ambitie_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_landschap AS 
 SELECT v_beheer_gebied_ambitie_landschap.provincie,
    v_beheer_gebied_ambitie_landschap.status,
    v_beheer_gebied_ambitie_landschap.status_desc,
    v_beheer_gebied_ambitie_landschap.subsidie_jaar,
    v_beheer_gebied_ambitie_landschap.identificatie,
    v_beheer_gebied_ambitie_landschap.beheer_type,
    v_beheer_gebied_ambitie_landschap.beheer_type_desc,
    v_beheer_gebied_ambitie_landschap.subsidiabel,
    v_beheer_gebied_ambitie_landschap.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie_landschap.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie_landschap.recreatie_type,
    v_beheer_gebied_ambitie_landschap.recreatie_type_desc,
    v_beheer_gebied_ambitie_landschap.taak_stelling,
    v_beheer_gebied_ambitie_landschap.taak_stelling_desc,
    v_beheer_gebied_ambitie_landschap.status_ehs,
    v_beheer_gebied_ambitie_landschap.status_ehs_desc,
    v_beheer_gebied_ambitie_landschap.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie_landschap.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie_landschap.geometry
   FROM "PNL".v_beheer_gebied_ambitie_landschap
  WHERE ((v_beheer_gebied_ambitie_landschap.status = 2) OR (v_beheer_gebied_ambitie_landschap.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_ambitie_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_ambitie_natuur AS 
 SELECT v_beheer_gebied_ambitie_natuur.provincie,
    v_beheer_gebied_ambitie_natuur.status,
    v_beheer_gebied_ambitie_natuur.status_desc,
    v_beheer_gebied_ambitie_natuur.subsidie_jaar,
    v_beheer_gebied_ambitie_natuur.identificatie,
    v_beheer_gebied_ambitie_natuur.beheer_type,
    v_beheer_gebied_ambitie_natuur.beheer_type_desc,
    v_beheer_gebied_ambitie_natuur.subsidiabel,
    v_beheer_gebied_ambitie_natuur.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie_natuur.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie_natuur.recreatie_type,
    v_beheer_gebied_ambitie_natuur.recreatie_type_desc,
    v_beheer_gebied_ambitie_natuur.taak_stelling,
    v_beheer_gebied_ambitie_natuur.taak_stelling_desc,
    v_beheer_gebied_ambitie_natuur.status_ehs,
    v_beheer_gebied_ambitie_natuur.status_ehs_desc,
    v_beheer_gebied_ambitie_natuur.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie_natuur.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie_natuur.geometry
   FROM "PNL".v_beheer_gebied_ambitie_natuur
  WHERE ((v_beheer_gebied_ambitie_natuur.status = 2) OR (v_beheer_gebied_ambitie_natuur.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_ambitie_natuur
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_landschap AS 
 SELECT v_beheer_gebied_landschap.provincie,
    v_beheer_gebied_landschap.status,
    v_beheer_gebied_landschap.status_desc,
    v_beheer_gebied_landschap.subsidie_jaar,
    v_beheer_gebied_landschap.identificatie,
    v_beheer_gebied_landschap.beheer_type,
    v_beheer_gebied_landschap.beheer_type_desc,
    v_beheer_gebied_landschap.subsidiabel,
    v_beheer_gebied_landschap.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_landschap.toegestane_beheer_paketten,
    v_beheer_gebied_landschap.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied_landschap.geometry
   FROM "PNL".v_beheer_gebied_landschap
  WHERE ((v_beheer_gebied_landschap.status = 2) OR (v_beheer_gebied_landschap.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_landschap
    OWNER TO anlb;


CREATE OR REPLACE VIEW geoserver.snl_nbp_beheer_gebied_natuur AS 
 SELECT v_beheer_gebied_natuur.provincie,
    v_beheer_gebied_natuur.status,
    v_beheer_gebied_natuur.status_desc,
    v_beheer_gebied_natuur.subsidie_jaar,
    v_beheer_gebied_natuur.identificatie,
    v_beheer_gebied_natuur.beheer_type,
    v_beheer_gebied_natuur.beheer_type_desc,
    v_beheer_gebied_natuur.subsidiabel,
    v_beheer_gebied_natuur.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_natuur.toegestane_beheer_paketten,
    v_beheer_gebied_natuur.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied_natuur.geometry
   FROM "PNL".v_beheer_gebied_natuur
  WHERE ((v_beheer_gebied_natuur.status = 2) OR (v_beheer_gebied_natuur.status = 3));
;

ALTER TABLE geoserver.snl_nbp_beheer_gebied_natuur
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_bijzonder_gebied AS 
 SELECT v_bijzonder_gebied.provincie,
    v_bijzonder_gebied.status,
    v_bijzonder_gebied.status_desc,
    v_bijzonder_gebied.subsidie_jaar,
    v_bijzonder_gebied.identificatie,
    v_bijzonder_gebied.gebieds_naam,
    v_bijzonder_gebied.gebieds_code,
    v_bijzonder_gebied.gebieds_code_desc,
    v_bijzonder_gebied.geometry
   FROM "PNL".v_bijzonder_gebied
  WHERE ((v_bijzonder_gebied.status = 2) OR (v_bijzonder_gebied.status = 3));
;

ALTER TABLE geoserver.snl_nbp_bijzonder_gebied
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_deel_gebied AS 
 SELECT v_deel_gebied.provincie,
    v_deel_gebied.status,
    v_deel_gebied.status_desc,
    v_deel_gebied.subsidie_jaar,
    v_deel_gebied.identificatie,
    v_deel_gebied.gebieds_naam,
    v_deel_gebied.beschrijving,
    v_deel_gebied.geometry
   FROM "PNL".v_deel_gebied
  WHERE ((v_deel_gebied.status = 2) OR (v_deel_gebied.status = 3));
;

ALTER TABLE geoserver.snl_nbp_deel_gebied
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_natuur_beheer_plan AS 
 SELECT v_natuur_beheer_plan.provincie,
    v_natuur_beheer_plan.status,
    v_natuur_beheer_plan.status_desc,
    v_natuur_beheer_plan.subsidie_jaar,
    v_natuur_beheer_plan.identificatie,
    v_natuur_beheer_plan.plan_naam,
    v_natuur_beheer_plan.plan_verwijzing,
    v_natuur_beheer_plan.plan_eigenaar,
    v_natuur_beheer_plan.datum_vaststelling,
    v_natuur_beheer_plan.geometry
   FROM "PNL".v_natuur_beheer_plan
  WHERE ((v_natuur_beheer_plan.status = 2) OR (v_natuur_beheer_plan.status = 3));
;

ALTER TABLE geoserver.snl_nbp_natuur_beheer_plan
    OWNER TO anlb;
	
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;