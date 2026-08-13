-- View: imna.vm_reports

-- DROP VIEW imna.vm_reports;

CREATE OR REPLACE VIEW imna.vm_reports AS 
 SELECT r.id,
        r.begin_geldigheid,
        r.eind_geldigheid,
        r.bron_houder_id,
        r.rapportage_jaar
   FROM imna.voortgangs_rapportage r
  WHERE NOT (EXISTS ( SELECT 1
                        FROM imna.voortgangs_rapportage r_prev
                       WHERE r.bron_houder_id = r_prev.bron_houder_id 
					     AND r.bron_houder_id = r_prev.bron_houder_id 
						 AND r.begin_geldigheid < r_prev.begin_geldigheid));

ALTER TABLE imna.vm_reports
  OWNER TO anlb;

-- View: imna.vm_prov_year_voortgangs_rapportage

-- DROP VIEW imna.vm_prov_year_voortgangs_rapportage;

CREATE OR REPLACE VIEW imna.vm_prov_year_voortgangs_rapportage AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
		g.id AS report_id
  FROM imna.voortgangs_rapportage g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.voortgangs_rapportage g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_voortgangs_rapportage
  OWNER TO anlb;

-- View: imna.vm_prov_year_gebied_inrichting

-- DROP VIEW imna.vm_prov_year_gebied_inrichting;

CREATE OR REPLACE VIEW imna.vm_prov_year_gebied_inrichting AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
        g.id AS gebied_inrichting_id,
		r.id AS report_id
  FROM imna.gebied_inrichting g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.gebied_inrichting g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_gebied_inrichting
  OWNER TO anlb;
  
-- View: imna.vm_prov_year_gebied_natuur

-- DROP VIEW imna.vm_prov_year_gebied_natuur;

CREATE OR REPLACE VIEW imna.vm_prov_year_gebied_natuur AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
        g.id AS gebied_natuur_id,
		r.id AS report_id
  FROM imna.gebied_natuur g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.gebied_natuur g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_gebied_natuur
  OWNER TO anlb;

-- View: imna.vm_prov_year_gebied_verwerving

-- DROP VIEW imna.vm_prov_year_gebied_verwerving;

CREATE OR REPLACE VIEW imna.vm_prov_year_gebied_verwerving AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
        g.id AS gebied_verwerving_id,
		r.id AS report_id
  FROM imna.gebied_verwerving g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.gebied_verwerving g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_gebied_verwerving
  OWNER TO anlb;  
  
-- View: imna.vm_prov_year_natuur_netwerk_nederland

-- DROP VIEW imna.vm_prov_year_natuur_netwerk_nederland;

CREATE OR REPLACE VIEW imna.vm_prov_year_natuur_netwerk_nederland AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
        g.id AS natuur_netwerk_nederland_id,
		r.id AS report_id
  FROM imna.natuur_netwerk_nederland g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.natuur_netwerk_nederland g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_natuur_netwerk_nederland
  OWNER TO anlb;

-- View: imna.vm_prov_year_resterende_inrichtings_ambitie

-- DROP VIEW imna.vm_prov_year_resterende_inrichtings_ambitie;

CREATE OR REPLACE VIEW imna.vm_prov_year_resterende_inrichtings_ambitie AS 
 SELECT r.rapportage_jaar,
        r.bron_houder_id,
        g.id AS resterende_inrichtings_ambitie_id,
		r.id AS report_id
  FROM imna.resterende_inrichtings_ambitie g,
       imna.vm_reports r
 WHERE g.bron_houder_id = r.bron_houder_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.resterende_inrichtings_ambitie g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.bron_houder_id = g_prev.bron_houder_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_resterende_inrichtings_ambitie
  OWNER TO anlb;
  
-- View: imna.v_gs_voortgangs_rapportage

-- DROP VIEW imna.v_gs_voortgangs_rapportage;

CREATE OR REPLACE VIEW imna.v_gs_voortgangs_rapportage AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
	   TRIM(opmerkingen) as opmerkingen
 FROM imna.vm_prov_year_voortgangs_rapportage p
 JOIN imna.voortgangs_rapportage g ON ( g.id = p.report_id);

 ALTER TABLE imna.v_gs_voortgangs_rapportage
  OWNER TO anlb;
 
-- View: imna.v_gs_gebied_inrichting

-- DROP VIEW imna.v_gs_gebied_inrichting;

CREATE OR REPLACE VIEW imna.v_gs_gebied_inrichting AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
	   (SELECT TRIM(code) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_beheerder_id) as type_beheerder,
	   (SELECT TRIM(description) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_beheerder_id) as type_beheerder_desc,	
	   contract_nummer,
	   relatie_nummer,
       g.geom
 FROM imna.vm_prov_year_gebied_inrichting p
 JOIN imna.gebied_inrichting g ON ( g.id = p.gebied_inrichting_id);

 ALTER TABLE imna.v_gs_gebied_inrichting
  OWNER TO anlb;
 
 -- View: imna.v_gs_gebied_natuur

-- DROP VIEW imna.v_gs_gebied_natuur;

CREATE OR REPLACE VIEW imna.v_gs_gebied_natuur AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_natuur where id = g.status_natuur_id) as status_natuur,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_natuur where id = g.status_natuur_id) as status_natuur_desc,	
	   (SELECT TRIM(code) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_beheerder_id) as type_beheerder,
	   (SELECT TRIM(description) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_beheerder_id) as type_beheerder_desc,	
	   TRIM(eenheid_nummer) as eenheid_nummer,
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_pakket where id = g.beheer_pakket_id) as beheer_pakket,
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_pakket where id = g.beheer_pakket_id) as beheer_pakket_desc,		   
	   contract_nummer,
	   relatie_nummer,
       g.geom
 FROM imna.vm_prov_year_gebied_natuur p
 JOIN imna.gebied_natuur g ON ( g.id = p.gebied_natuur_id);

 ALTER TABLE imna.v_gs_gebied_natuur
  OWNER TO anlb;
 
 -- View: imna.v_gs_gebied_verwerving

-- DROP VIEW imna.v_gs_gebied_verwerving;

CREATE OR REPLACE VIEW imna.v_gs_gebied_verwerving AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_verwerving where id = g.status_verwerving_id) as status_verwerving,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_verwerving where id = g.status_verwerving_id) as status_verwerving_desc,	
	   (SELECT TRIM(code) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_eigenaar_id) as type_eigenaar,
	   (SELECT TRIM(description) FROM masterdata.dmn_type_beheerder_en_eigenaar where id = g.type_eigenaar_id) as type_eigenaar_desc,	
	   contract_nummer,
	   relatie_nummer,
       g.geom
 FROM imna.vm_prov_year_gebied_verwerving p
 JOIN imna.gebied_verwerving g ON ( g.id = p.gebied_verwerving_id);

 ALTER TABLE imna.v_gs_gebied_verwerving
  OWNER TO anlb;
  
 -- View: imna.v_gs_natuur_netwerk_nederland

-- DROP VIEW imna.v_gs_natuur_netwerk_nederland;

CREATE OR REPLACE VIEW imna.v_gs_natuur_netwerk_nederland AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
       g.geom
 FROM imna.vm_prov_year_natuur_netwerk_nederland p
 JOIN imna.natuur_netwerk_nederland g ON ( g.id = p.natuur_netwerk_nederland_id);

 ALTER TABLE imna.v_gs_natuur_netwerk_nederland
  OWNER TO anlb; 
 
 -- View: imna.v_gs_resterende_inrichtings_ambitie

-- DROP VIEW imna.v_gs_resterende_inrichtings_ambitie;

CREATE OR REPLACE VIEW imna.v_gs_resterende_inrichtings_ambitie AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.bron_houder_id) as bron_houder_desc,
	   p.rapportage_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
	   resterende_inrichting_natuurpact,
	   resterende_inrichting_aanvullend
 FROM imna.vm_prov_year_resterende_inrichtings_ambitie p
 JOIN imna.resterende_inrichtings_ambitie g ON ( g.id = p.resterende_inrichtings_ambitie_id);

 ALTER TABLE imna.v_gs_resterende_inrichtings_ambitie
  OWNER TO anlb;
 
 
  