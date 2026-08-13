-- View: imna.bes_reports

-- DROP VIEW imna.bes_reports;

CREATE OR REPLACE VIEW imna.bes_reports AS 
 SELECT r.id,
        r.begin_geldigheid,
        r.eind_geldigheid,
        r.provincie_id,
        r.beheer_jaar
   FROM imna.beschikking_rapportage r
  WHERE NOT (EXISTS ( SELECT 1
                        FROM imna.beschikking_rapportage r_prev
                       WHERE r.provincie_id = r_prev.provincie_id 
					     AND r.provincie_id = r_prev.provincie_id 
						 AND r.begin_geldigheid < r_prev.begin_geldigheid));

ALTER TABLE imna.bes_reports
  OWNER TO anlb;
  
-- View: imna.vm_prov_year_beschikking_rapportage

-- DROP VIEW imna.vm_prov_year_beschikking_rapportage;

CREATE OR REPLACE VIEW imna.vm_prov_year_beschikking_rapportage AS 
 SELECT r.beheer_jaar,
        r.provincie_id,
		g.id AS report_id
  FROM imna.beschikking_rapportage g,
       imna.bes_reports r
 WHERE g.provincie_id = r.provincie_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.beschikking_rapportage g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.provincie_id = g_prev.provincie_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_beschikking_rapportage
  OWNER TO anlb;

-- View: imna.vm_prov_year_beschikking

-- DROP VIEW imna.vm_prov_year_beschikking;

CREATE OR REPLACE VIEW imna.vm_prov_year_beschikking AS 
 SELECT r.beheer_jaar,
        r.provincie_id,
        g.id AS beschikking_id,
		r.id AS report_id
  FROM imna.beschikking g,
       imna.bes_reports r
 WHERE g.provincie_id = r.provincie_id 
   AND g.begin_geldigheid <= r.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.beschikking g_prev
                      WHERE g.identificatie = g_prev.identificatie 
					    AND g.provincie_id = g_prev.provincie_id 
						AND r.begin_geldigheid >= g_prev.begin_geldigheid
						AND g.begin_geldigheid < g_prev.begin_geldigheid)) 
	AND (g.eind_geldigheid IS NULL OR g.eind_geldigheid >= r.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_beschikking
  OWNER TO anlb;

-- View: imna.v_gs_beschikking_rapportage

-- DROP VIEW imna.v_gs_beschikking_rapportage;

CREATE OR REPLACE VIEW imna.v_gs_beschikking_rapportage AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie_desc,
	   p.beheer_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid
 FROM imna.vm_prov_year_beschikking_rapportage p
 JOIN imna.beschikking_rapportage g ON ( g.id = p.report_id);

 ALTER TABLE imna.v_gs_beschikking_rapportage
  OWNER TO anlb;
  
-- View: imna.v_gs_beschikking

-- DROP VIEW imna.v_gs_beschikking;

CREATE OR REPLACE VIEW imna.v_gs_beschikking AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie_desc,
	   p.beheer_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
	   g.contract_nummer,
	   g.datum_beschikking,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_aanvraag_subsidie where id = g.status_aanvraag_subsidie_id) as status_aanvraag_subsidie,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_aanvraag_subsidie where id = g.status_aanvraag_subsidie_id) as status_aanvraag_subsidie_desc,	
	   (SELECT TRIM(code) FROM masterdata.dmn_type_regeling where id = g.type_regeling_id) as type_regeling,
	   (SELECT TRIM(description) FROM masterdata.dmn_type_regeling where id = g.type_regeling_id) as type_regeling_desc,			
	    -- beheer_type
       CASE 
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type WHERE id = snl.beheer_type_id)
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_niet_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type WHERE id = nietsnl.beheer_type_id)
      END AS beheer_type,
       -- beheer_type_desc
      CASE 
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type WHERE id = snl.beheer_type_id)
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_niet_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type WHERE id = nietsnl.beheer_type_id)
      END AS beheer_type_desc,	  
       g.geom
 FROM imna.vm_prov_year_beschikking p
 JOIN imna.beschikking g ON ( g.id = p.beschikking_id)
 LEFT JOIN imna.beschikking_beheer_type_snl snl ON (snl.beschikking_id = p.beschikking_id) 
 LEFT JOIN imna.beschikking_beheer_type_niet_snl nietsnl ON (nietsnl.beschikking_id = p.beschikking_id) 
 ;

 ALTER TABLE imna.v_gs_beschikking
  OWNER TO anlb;

-- View: imna.v_rvo_beschikking_rapportage

-- DROP VIEW imna.v_rvo_beschikking_rapportage;

CREATE OR REPLACE VIEW imna.v_rvo_beschikking_rapportage AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie,
	   p.beheer_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid
 FROM imna.vm_prov_year_beschikking_rapportage p
 JOIN imna.beschikking_rapportage g ON ( g.id = p.report_id);

 ALTER TABLE imna.v_rvo_beschikking_rapportage
  OWNER TO anlb;

-- View: imna.v_rvo_beschikking

-- DROP VIEW imna.v_rvo_beschikking;

CREATE OR REPLACE VIEW imna.v_rvo_beschikking AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = g.provincie_id) as provincie,
	   p.beheer_jaar,
	   TRIM(g.identificatie) as identificatie,
   	   g.begin_geldigheid,
	   NULL as eind_geldigheid,
       g.begin_tijd,
       g.eind_tijd,
	   g.contract_nummer,
	   g.datum_beschikking,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_aanvraag_subsidie where id = g.status_aanvraag_subsidie_id) as status_aanvraag_subsidie,
	   (SELECT TRIM(code) FROM masterdata.dmn_type_regeling where id = g.type_regeling_id) as type_regeling,
	    -- beheer_type
       CASE 
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type WHERE id = snl.beheer_type_id)
			WHEN EXISTS (SELECT 1 FROM masterdata.dmn_type_regeling_niet_snl WHERE id = g.type_regeling_id) THEN
			   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type WHERE id = nietsnl.beheer_type_id)
      END AS beheer_type,
      g.geom
 FROM imna.vm_prov_year_beschikking p
 JOIN imna.beschikking g ON ( g.id = p.beschikking_id)
 LEFT JOIN imna.beschikking_beheer_type_snl snl ON (snl.beschikking_id = p.beschikking_id) 
 LEFT JOIN imna.beschikking_beheer_type_niet_snl nietsnl ON (nietsnl.beschikking_id = p.beschikking_id) 
 ;

 ALTER TABLE imna.v_rvo_beschikking
  OWNER TO anlb;  
  
  
  