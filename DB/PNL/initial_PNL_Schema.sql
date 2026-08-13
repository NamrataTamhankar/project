-- View: "PNL".v_beheer_gebied

-- DROP VIEW "PNL".v_beheer_gebied;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
       btype AS beheer_type,
	   (SELECT description FROM masterdata.dmn_beheer_type where code = btype) AS beheer_type_desc,
       CASE 
			WHEN subs = 1 THEN
				'Ja'
			WHEN subs = 0 THEN
				'Nee' 
       END AS subsidiabel,
       indbtype AS indicatieve_verhouding_beheer_typen,
       toegbp AS toegestane_beheer_paketten,       
       nsubsbp AS niet_subsidiabele_beheer_paketten,
	   geom AS geometry
  FROM "PNL"."BeheergebiedShape" b
 ;
 
 ALTER TABLE "PNL".v_beheer_gebied
  OWNER TO anlb;


-- View: "PNL".v_beheer_gebied_ambitie

-- DROP VIEW "PNL".v_beheer_gebied_ambitie;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
       btype AS beheer_type,
	   (SELECT description FROM masterdata.dmn_beheer_type where code = btype) AS beheer_type_desc,
	   CASE 
			WHEN subssknl = 1 THEN
				'Ja'
			WHEN subssknl = 0 THEN
				'Nee' 
       END AS subsidiabel,
       indbtype AS indicatieve_verhouding_beheer_typen,
       toegbp AS toegestane_beheer_paketten,       
	   rtype AS recreatie_type,
	    CASE 
			WHEN rtype = 'R0' THEN
				'Afgesloten natuurterrein' 
			WHEN rtype = 'R1' THEN
				'Opengesteld inrichtingsniveau beperkt' 
			WHEN rtype = 'R2' THEN
				'Opengesteld inrichtingsniveau basis' 
			WHEN rtype = 'R3' THEN
				'Opengesteld inrichtingsniveau plus' 
			WHEN rtype = 'R4' THEN
				'Opengesteld recreatie om de stad' 				
       END AS recreatie_type_desc,
	   taakstllng AS taak_stelling,
  	   CASE 
			WHEN taakstllng = 1 THEN
				'Bestaande natuur' 
			WHEN taakstllng = 2 THEN
				'Nieuwe natuur' 
			WHEN taakstllng = 3 THEN
				'Natte natuur' 
			WHEN taakstllng = 4 THEN
				'Robuuste verbindingen' 
			WHEN taakstllng = 5 THEN
				'Beheersgebied' 				
			WHEN taakstllng = 6 THEN
				'RODS' 
			WHEN taakstllng = 999 THEN
				'Geen taakstelling' 				
       END AS taak_stelling_desc,
       statusehs  AS status_ehs,
	   CASE 
			WHEN statusehs = 1 THEN
				'EHS Planologisch beschermd' 
			WHEN statusehs = 2 THEN
				'EHS Planologisch beschermd Grote wateren' 				
       END AS status_ehs_desc,				
	   gegadnwntr AS gegadigden_nieuwe_natuur,
	     CASE 
			WHEN gegadnwntr = 1 THEN
				'TBOs' 
			WHEN gegadnwntr = 2 THEN
				'Particulieren' 
			WHEN gegadnwntr = 3 THEN
				'TBOs en particulieren' 				
       END AS gegadigden_nieuwe_natuur_desc,								
	   geom AS geometry
  FROM "PNL"."BeheergebiedAmbitieShape" b
 ;
 
 ALTER TABLE "PNL".v_beheer_gebied_ambitie
  OWNER TO anlb;


-- View: "PNL".v_beheer_gebied_agrarisch

-- DROP VIEW "PNL".v_beheer_gebied_agrarisch;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_agrarisch AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied 
  WHERE beheer_type LIKE 'A%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_agrarisch
  OWNER TO anlb;

-- View: "PNL".v_beheer_gebied_ambitie_agrarisch

-- DROP VIEW "PNL".v_beheer_gebied_ambitie_agrarisch;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_agrarisch AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied_ambitie 
  WHERE beheer_type LIKE 'A%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_agrarisch
  OWNER TO anlb;
  
-- View: "PNL".v_beheer_gebied_ambitie_landschap

-- DROP VIEW "PNL".v_beheer_gebied_ambitie_landschap;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_landschap AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied_ambitie 
  WHERE beheer_type LIKE 'L%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_landschap
  OWNER TO anlb;
  
-- View: "PNL".v_beheer_gebied_ambitie_natuur

-- DROP VIEW "PNL".v_beheer_gebied_ambitie_natuur;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_natuur AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied_ambitie 
  WHERE beheer_type LIKE 'N%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_natuur
  OWNER TO anlb;
  
-- View: "PNL".v_beheer_gebied_landschap

-- DROP VIEW "PNL".v_beheer_gebied_landschap;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_landschap AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied 
  WHERE beheer_type LIKE 'L%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_landschap
  OWNER TO anlb;
  
-- View: "PNL".v_beheer_gebied_natuur

-- DROP VIEW "PNL".v_beheer_gebied_natuur;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_natuur AS 
 SELECT * 
  FROM "PNL".v_beheer_gebied 
  WHERE beheer_type LIKE 'N%'
  ;

ALTER TABLE "PNL".v_beheer_gebied_natuur
  OWNER TO anlb;
  
-- View: "PNL".v_bijzonder_gebied

-- DROP VIEW "PNL".v_bijzonder_gebied;

CREATE OR REPLACE VIEW "PNL".v_bijzonder_gebied AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   bnaam AS gebieds_naam,
       bcode AS gebieds_code,
	  CASE 
			WHEN bcode = 'B1' THEN
				'Probleemgebiedenvergoeding' 
			WHEN bcode = 'B2' THEN
				'Vaarland' 
			WHEN bcode = 'B3' THEN
				'Gescheperde Schaapskuddes' 
       END AS gebieds_code_desc,	   	   
	   geom AS geometry
  FROM "PNL"."BijzondergebiedShape" b
 ;
 
 ALTER TABLE "PNL".v_bijzonder_gebied
  OWNER TO anlb;
  
-- View: "PNL".v_deel_gebied

-- DROP VIEW "PNL".v_deel_gebied;

CREATE OR REPLACE VIEW "PNL".v_deel_gebied AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
       deelnaam AS gebieds_naam,
       beschr AS beschrijving,
	   geom AS geometry
  FROM "PNL"."DeelgebiedShape" b
 ;
 
 ALTER TABLE "PNL".v_deel_gebied
  OWNER TO anlb;
  
-- View: "PNL".v_natuur_beheer_plan

-- DROP VIEW "PNL".v_natuur_beheer_plan;

CREATE OR REPLACE VIEW "PNL".v_natuur_beheer_plan AS 
 SELECT prv_id  AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   nbpnaam AS plan_naam,
       nbpverw AS plan_verwijzing,
       nbpeig  AS plan_eigenaar,
       datumv AS datum_vaststelling,
	   geom AS geometry
  FROM "PNL"."NatuurbeheerplanShape" b
 ;
 
 ALTER TABLE "PNL".v_natuur_beheer_plan
  OWNER TO anlb;
  
-- View: "PNL".v_zoek_gebied_agrarisch

-- DROP VIEW "PNL".v_zoek_gebied_agrarisch;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_agrarisch AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   naam AS naam,
	   agrarnt AS agrarisch_natuur_type,
	   dgnaam AS deel_gebied_naam,
       toegbp AS toegestane_beheer_typen,
       toegcb AS toegestane_beheer_clusters,
       toegbf AS toegestane_beheer_functies,
	
	   geom AS geometry
  FROM "PNL"."AgrarischZoekGebiedShape" b
 ;
 
 ALTER TABLE "PNL".v_zoek_gebied_agrarisch
  OWNER TO anlb;
  
-- View: "PNL".v_zoek_gebied_ambitie_landschap

-- DROP VIEW "PNL".v_zoek_gebied_ambitie_landschap;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_ambitie_landschap AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   lzgnaam AS naam,
       toegbt AS toegestane_beheer_typen,
	   geom AS geometry
  FROM "PNL"."LandschapsZoekgebiedAmbitieShape" b
 ;
 
 ALTER TABLE "PNL".v_zoek_gebied_ambitie_landschap
  OWNER TO anlb;
  
-- View: "PNL".v_zoek_gebied_landschap

-- DROP VIEW "PNL".v_zoek_gebied_landschap;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_landschap AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   lzgnaam AS naam,
       toegbt AS toegestane_beheer_typen,
	   nsubsbp AS niet_subsidiabele_beheer_pakketten,
	   geom AS geometry
  FROM "PNL"."LandschapsZoekgebiedShape" b
 ;
 
 ALTER TABLE "PNL".v_zoek_gebied_landschap
  OWNER TO anlb;
  
-- View: "PNL".v_zoek_gebied_water

-- DROP VIEW "PNL".v_zoek_gebied_water;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_water AS 
 SELECT (SELECT prv_id FROM "PNL"."NatuurbeheerplanShape" p WHERE p.nbp_id=b.nbp_id) AS provincie,
       (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) AS status,
	   CASE 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 1 THEN
				'Concept' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 2 THEN
				'Vastgesteld ontwerp' 
			WHEN (SELECT status_code FROM "PNL".tln_nbp s WHERE s.nbp_id=b.nbp_id) = 3 THEN
				'Vastgesteld definitief' 
       END AS status_desc,	   
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   naam AS naam,
	   wtrt AS water_natuur_type,
	   dgnaam AS deel_gebied_naam,
       toegbp AS toegestane_beheer_typen,
       toegcb AS toegestane_beheer_clusters,
       toegbf AS toegestane_beheer_functies,
	   geom AS geometry
  FROM "PNL"."ZoekGebiedWaterShape" b
 ;
 
 ALTER TABLE "PNL".v_zoek_gebied_water
  OWNER TO anlb;