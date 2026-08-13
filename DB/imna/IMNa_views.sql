-- View: imna.vm_distinct_year_status

-- DROP VIEW imna.vm_distinct_year_status;

CREATE OR REPLACE VIEW imna.vm_distinct_year_status AS 
 SELECT DISTINCT natuur_beheer_plan.subsidie_jaar,
				 dmn_status_plan.id AS status_id,
				 dmn_status_plan.code AS status_code,
				 dmn_status_plan.description AS status_desc
  FROM imna.natuur_beheer_plan,
       masterdata.dmn_status_plan
 ORDER BY natuur_beheer_plan.subsidie_jaar;

ALTER TABLE imna.vm_distinct_year_status
  OWNER TO anlb;

-- View: imna.vm_plans_beheer_gebied

-- DROP VIEW imna.vm_plans_beheer_gebied;

CREATE OR REPLACE VIEW imna.vm_plans_beheer_gebied AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.beheer_gebied_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.beheer_gebied_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.beheer_gebied_status_id = p_prev.beheer_gebied_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_beheer_gebied
  OWNER TO anlb;

-- View: imna.vm_plans_beheer_gebied_ambitie

-- DROP VIEW imna.vm_plans_beheer_gebied_ambitie

CREATE OR REPLACE VIEW imna.vm_plans_beheer_gebied_ambitie AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.beheer_gebied_ambitie_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.beheer_gebied_ambitie_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.beheer_gebied_ambitie_status_id = p_prev.beheer_gebied_ambitie_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_beheer_gebied_ambitie
  OWNER TO anlb;

-- View: imna.vm_plans_bijzonder_gebied

-- DROP VIEW imna.vm_plans_bijzonder_gebied

CREATE OR REPLACE VIEW imna.vm_plans_bijzonder_gebied AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.bijzonder_gebied_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.bijzonder_gebied_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.bijzonder_gebied_status_id = p_prev.bijzonder_gebied_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_bijzonder_gebied
  OWNER TO anlb;

-- View: imna.vm_plans_deel_gebied

-- DROP VIEW imna.vm_plans_deel_gebied

CREATE OR REPLACE VIEW imna.vm_plans_deel_gebied AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.deel_gebied_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.deel_gebied_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.deel_gebied_status_id = p_prev.deel_gebied_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_deel_gebied
  OWNER TO anlb;

-- View: imna.vm_plans_zoek_gebied_agrarisch

-- DROP VIEW imna.vm_plans_zoek_gebied_agrarisch

CREATE OR REPLACE VIEW imna.vm_plans_zoek_gebied_agrarisch AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.zoek_gebied_agrarisch_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.zoek_gebied_agrarisch_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.zoek_gebied_agrarisch_status_id = p_prev.zoek_gebied_agrarisch_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_zoek_gebied_agrarisch
  OWNER TO anlb;

-- View: imna.vm_plans_zoek_gebied_landschap

-- DROP VIEW imna.vm_plans_zoek_gebied_landschap

CREATE OR REPLACE VIEW imna.vm_plans_zoek_gebied_landschap AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.zoek_gebied_landschap_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.zoek_gebied_landschap_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.zoek_gebied_landschap_status_id = p_prev.zoek_gebied_landschap_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_zoek_gebied_landschap
  OWNER TO anlb;

-- View: imna.vm_plans_zoek_gebied_water

-- DROP VIEW imna.vm_plans_zoek_gebied_water

CREATE OR REPLACE VIEW imna.vm_plans_zoek_gebied_water AS 
 SELECT p.id,
        p.begin_geldigheid,
        p.eind_geldigheid,
        p.provincie_id,
        p.subsidie_jaar,
        p.zoek_gebied_water_status_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.zoek_gebied_water_status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.zoek_gebied_water_status_id = p_prev.zoek_gebied_water_status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_plans_zoek_gebied_water
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_beheer_gebied

-- DROP VIEW imna.vm_prov_year_status_beheer_gebied;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_beheer_gebied AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.beheer_gebied_status_id AS status_id,
        b.id AS beheer_gebied_id,
		p.id AS plan_id
  FROM imna.beheer_gebied b,
       imna.vm_plans_beheer_gebied p
 WHERE b.provincie_id = p.provincie_id 
   AND b.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.beheer_gebied b_prev
                      WHERE b.identificatie = b_prev.identificatie 
					    AND b.provincie_id = b_prev.provincie_id 
						AND p.begin_geldigheid >= b_prev.begin_geldigheid
						AND b.begin_geldigheid < b_prev.begin_geldigheid)) 
	AND (b.eind_geldigheid IS NULL OR b.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_beheer_gebied
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_beheer_gebied_ambitie

-- DROP VIEW imna.vm_prov_year_status_beheer_gebied_ambitie;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_beheer_gebied_ambitie AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.beheer_gebied_ambitie_status_id AS status_id,
        a.id AS ambitie_gebied_id,
		p.id AS plan_id
  FROM imna.beheer_gebied_ambitie a,
       imna.vm_plans_beheer_gebied_ambitie p
 WHERE a.provincie_id = p.provincie_id 
   AND a.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.beheer_gebied_ambitie a_prev
                      WHERE a.identificatie = a_prev.identificatie 
					    AND a.provincie_id = a_prev.provincie_id 
						AND p.begin_geldigheid >= a_prev.begin_geldigheid
						AND a.begin_geldigheid < a_prev.begin_geldigheid)) 
	AND (a.eind_geldigheid IS NULL OR a.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_beheer_gebied_ambitie
  OWNER TO anlb;
-- View: imna.vm_prov_year_status_bijzonder_gebied

-- DROP VIEW imna.vm_prov_year_status_bijzonder_gebied;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_bijzonder_gebied AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.bijzonder_gebied_status_id AS status_id,
        b.id AS bijzonder_gebied_id,
		p.id AS plan_id
  FROM imna.bijzonder_gebied b,
       imna.vm_plans_bijzonder_gebied p
 WHERE b.provincie_id = p.provincie_id 
   AND b.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.bijzonder_gebied b_prev
                      WHERE b.identificatie = b_prev.identificatie 
					    AND b.provincie_id = b_prev.provincie_id 
						AND p.begin_geldigheid >= b_prev.begin_geldigheid
						AND b.begin_geldigheid < b_prev.begin_geldigheid)) 
	AND (b.eind_geldigheid IS NULL OR b.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_bijzonder_gebied
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_deel_gebied

-- DROP VIEW imna.vm_prov_year_status_deel_gebied;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_deel_gebied AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.deel_gebied_status_id AS status_id,
        d.id AS deel_gebied_id,
		p.id AS plan_id
  FROM imna.deel_gebied d,
       imna.vm_plans_deel_gebied p
 WHERE d.provincie_id = p.provincie_id 
   AND d.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.deel_gebied d_prev
                      WHERE d.identificatie = d_prev.identificatie 
					    AND d.provincie_id = d_prev.provincie_id 
						AND p.begin_geldigheid >= d_prev.begin_geldigheid
						AND d.begin_geldigheid < d_prev.begin_geldigheid)) 
	AND (d.eind_geldigheid IS NULL OR d.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_deel_gebied
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_natuur_beheer_plan

-- DROP VIEW imna.vm_prov_year_status_natuur_beheer_plan;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_natuur_beheer_plan AS 
 SELECT p.provincie_id,
        p.subsidie_jaar,
        p.status_id,
		p.id as plan_id
   FROM imna.natuur_beheer_plan p
  WHERE (EXISTS ( SELECT 1
                    FROM imna.vm_distinct_year_status d
                   WHERE p.subsidie_jaar = d.subsidie_jaar 
					 AND p.status_id = d.status_id)) 
	AND NOT (EXISTS ( SELECT 1
                        FROM imna.natuur_beheer_plan p_prev
                       WHERE p.provincie_id = p_prev.provincie_id 
					     AND p.subsidie_jaar = p_prev.subsidie_jaar 
						 AND p.status_id = p_prev.status_id 
						 AND p.begin_geldigheid < p_prev.begin_geldigheid));

ALTER TABLE imna.vm_prov_year_status_natuur_beheer_plan
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_zoek_gebied_agrarisch

-- DROP VIEW imna.vm_prov_year_status_zoek_gebied_agrarisch;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_zoek_gebied_agrarisch AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.zoek_gebied_agrarisch_status_id AS status_id,
        z.id AS zoek_gebied_agrarisch_id,
		p.id AS plan_id
  FROM imna.zoek_gebied_agrarisch z,
       imna.vm_plans_zoek_gebied_agrarisch p
 WHERE z.provincie_id = p.provincie_id 
   AND z.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.zoek_gebied_agrarisch z_prev
                      WHERE z.identificatie = z_prev.identificatie 
					    AND z.provincie_id = z_prev.provincie_id 
						AND p.begin_geldigheid >= z_prev.begin_geldigheid
						AND z.begin_geldigheid < z_prev.begin_geldigheid)) 
	AND (z.eind_geldigheid IS NULL OR z.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_zoek_gebied_agrarisch
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_zoek_gebied_landschap

-- DROP VIEW imna.vm_prov_year_status_zoek_gebied_landschap;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_zoek_gebied_landschap AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.zoek_gebied_landschap_status_id AS status_id,
        z.id AS zoek_gebied_landschap_id,
		p.id AS plan_id
  FROM imna.zoek_gebied_landschap z,
       imna.vm_plans_zoek_gebied_landschap p
 WHERE z.provincie_id = p.provincie_id 
   AND z.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.zoek_gebied_landschap z_prev
                      WHERE z.identificatie = z_prev.identificatie 
					    AND z.provincie_id = z_prev.provincie_id 
						AND p.begin_geldigheid >= z_prev.begin_geldigheid
						AND z.begin_geldigheid < z_prev.begin_geldigheid)) 
	AND (z.eind_geldigheid IS NULL OR z.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_zoek_gebied_landschap
  OWNER TO anlb;

-- View: imna.vm_prov_year_status_zoek_gebied_water

-- DROP VIEW imna.vm_prov_year_status_zoek_gebied_water;

CREATE OR REPLACE VIEW imna.vm_prov_year_status_zoek_gebied_water AS 
 SELECT p.subsidie_jaar,
        p.provincie_id,
        p.zoek_gebied_water_status_id AS status_id,
        z.id AS zoek_gebied_water_id,
		p.id AS plan_id
  FROM imna.zoek_gebied_water z,
       imna.vm_plans_zoek_gebied_water p
 WHERE z.provincie_id = p.provincie_id 
   AND z.begin_geldigheid <= p.begin_geldigheid 
   AND NOT (EXISTS ( SELECT 1
                       FROM imna.zoek_gebied_water z_prev
                      WHERE z.identificatie = z_prev.identificatie 
					    AND z.provincie_id = z_prev.provincie_id 
						AND p.begin_geldigheid >= z_prev.begin_geldigheid
						AND z.begin_geldigheid < z_prev.begin_geldigheid)) 
	AND (z.eind_geldigheid IS NULL OR z.eind_geldigheid >= p.eind_geldigheid);

ALTER TABLE imna.vm_prov_year_status_zoek_gebied_water
  OWNER TO anlb;

-- View: imna.v_gs_beheer_gebied

-- DROP VIEW imna.v_gs_beheer_gebied;

CREATE OR REPLACE VIEW imna.v_gs_beheer_gebied AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
       TRIM(b.identificatie) as identificatie,
	   b.begin_geldigheid,
	   NULL as eind_geldigheid,
       b.begin_tijd,
       b.eind_tijd,
       -- beheer_type
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_natuur WHERE id = n.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_agrarisch WHERE id = a.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'W') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type,
       -- beheer_type_desc
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_natuur WHERE id = n.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_agrarisch WHERE id = a.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'W') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type_desc,	  
      -- subsidiabel
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
  	   CASE 
			WHEN n.subsidiabel = true THEN
				'Ja'
			WHEN n.subsidiabel = false THEN
				'Nee' 
       END
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
  	   CASE 
			WHEN g.subsidiabel = true THEN
				'Ja'
			WHEN g.subsidiabel = false THEN
				'Nee' 
       END
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
		CASE 
			WHEN a.subsidiabel = true THEN
				'Ja'
			WHEN a.subsidiabel = false THEN
				'Nee' 
       END
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
		CASE 
			WHEN l.subsidiabel = true THEN
				'Ja'
			WHEN l.subsidiabel = false THEN
				'Nee' 
       END
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'W') THEN
	    CASE 
			WHEN w.subsidiabel = true THEN
				'Ja'
			WHEN w.subsidiabel = false THEN
				'Nee' 
       END
      END AS subsidiabel,       
      -- openstellings_bijdrage_type
       CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	  (SELECT TRIM(code) FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = n.openstellings_bijdrage_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  (SELECT TRIM(code) FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = g.openstellings_bijdrage_type_id)
      END AS openstellings_bijdrage_type,
      -- openstellings_bijdrage_type_desc
       CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	  (SELECT TRIM(description) FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = n.openstellings_bijdrage_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  (SELECT TRIM(description) FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = g.openstellings_bijdrage_type_id)
      END AS openstellings_bijdrage_type_desc,
      -- indicatieve_verhouding_beheer_typen	
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  (SELECT STRING_AGG (i.percentage || '% ' || d.code || ': ' || d.description, 
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.beheer_indicatieve_verhouding_beheer_typen i
	    JOIN masterdata.dmn_beheer_type_natuur d ON (d.id = i.beheer_type_id)
	   WHERE i.beheer_gebied_id = g.beheer_gebied_id)	      
      END AS indicatieve_verhouding_beheer_typen,
      -- toegestane_beheer_paketten
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	  (SELECT STRING_AGG (d.code || ': ' || d.description, 
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.beheer_toegestane_beheer_pakketten_agrarisch pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = a.beheer_gebied_id)	      
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code || ': ' || d.description, 
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.beheer_toegestane_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = l.beheer_gebied_id)	      
      END AS toegestane_beheer_paketten,
      -- niet_subsidiabele_beheer_paketten
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	  (SELECT STRING_AGG (d.code || ': ' || d.description, 
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.beheer_niet_subsidiabele_beheer_pakketten_agrarisch pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = a.beheer_gebied_id)	      
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code || ': ' || d.description,
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.beheer_niet_subsidiabele_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = l.beheer_gebied_id)	      
      END AS niet_subsidiabele_beheer_paketten,
	(SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	(SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,
      b.geom
 FROM imna.vm_prov_year_status_beheer_gebied s
 JOIN imna.beheer_gebied b ON ( b.id = s.beheer_gebied_id)
 LEFT JOIN imna.beheer_natuur n ON (n.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_grootschaligenatuur g ON (g.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_agrarisch a ON (a.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_landschap l ON (l.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_water w ON (w.beheer_gebied_id = s.beheer_gebied_id);

 ALTER TABLE imna.v_gs_beheer_gebied
  OWNER TO anlb;
 
 -- View: imna.v_gs_beheer_gebied_ambitie

-- DROP VIEW imna.v_gs_beheer_gebied_ambitie;

CREATE OR REPLACE VIEW imna.v_gs_beheer_gebied_ambitie AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
	   TRIM(a.identificatie) as identificatie,
       a.begin_tijd,
       a.eind_tijd,
       (SELECT TRIM(code) FROM masterdata.dmn_status_ehs WHERE id = a.status_ehs_id) as status_ehs,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_ehs WHERE id = a.status_ehs_id) as status_ehs_desc,
          -- beheer_type
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'N') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_natuur_ambitie WHERE id = n.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie WHERE id = v.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'W') THEN
	   (SELECT TRIM(code) FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type,
	  -- beheer_type_desc
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'N') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_natuur_ambitie WHERE id = n.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie WHERE id = v.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'W') THEN
	   (SELECT TRIM(description) FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type_desc,
 -- subsidiabel
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'N') THEN
  	   CASE 
			WHEN n.subsidiabel = true THEN
				'Ja'
			WHEN n.subsidiabel = false THEN
				'Nee' 
       END
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
  	   CASE 
			WHEN g.subsidiabel = true THEN
				'Ja'
			WHEN g.subsidiabel = false THEN
				'Nee' 
       END
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
  	   CASE 
			WHEN v.subsidiabel = true THEN
				'Ja'
			WHEN v.subsidiabel = false THEN
				'Nee' 
       END
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
  	   CASE 
			WHEN l.subsidiabel = true THEN
				'Ja'
			WHEN l.subsidiabel = false THEN
				'Nee' 
       END
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'W') THEN
  	   CASE 
			WHEN w.subsidiabel = true THEN
				'Ja'
			WHEN w.subsidiabel = false THEN
				'Nee' 
       END
      END AS subsidiabel,       	  
      -- indicatieve_verhouding_beheer_typen	
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	  (SELECT STRING_AGG (i.percentage || '% ' || d.code || ': ' || d.description,   
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.ambitie_indicatieve_verhouding_beheer_typen_gr i
	    JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON (d.id = i.beheer_type_id)
	   WHERE i.ambitie_gebied_id = g.ambitie_gebied_id)	      
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	  (SELECT STRING_AGG (i.percentage || '% ' || d.code || ': ' || d.description,  
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.ambitie_indicatieve_verhouding_beheer_typen_vr i
	    JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON (d.id = i.beheer_type_id)
	   WHERE i.ambitie_gebied_id = v.ambitie_gebied_id)	     	   
      END AS indicatieve_verhouding_beheer_typen,
       -- toegestane_beheer_paketten
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code || ': ' || d.description,  
			      '<br>'
			      ORDER BY d.code)
	    FROM imna.ambitie_toegestane_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.ambitie_gebied_id = l.ambitie_gebied_id)	      
      END AS toegestane_beheer_paketten,
	  (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	  (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,
      a.geom
 FROM imna.vm_prov_year_status_beheer_gebied_ambitie s
 JOIN imna.beheer_gebied_ambitie a ON ( a.id = s.ambitie_gebied_id)
 LEFT JOIN imna.ambitie_natuur n ON (n.ambitie_gebied_id = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_grootschaligenatuur g ON (g.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_omtevormennatuur v ON (v.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_landschap l ON (l.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_water w ON (w.ambitie_gebied_id  = s.ambitie_gebied_id);

 ALTER TABLE imna.v_gs_beheer_gebied_ambitie
  OWNER TO anlb;
  
  -- View: imna.v_gs_bijzonder_gebied

-- DROP VIEW imna.v_gs_bijzonder_gebied;

CREATE OR REPLACE VIEW imna.v_gs_bijzonder_gebied AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
   	   b.begin_geldigheid,
	   NULL as eind_geldigheid,
	   TRIM(b.identificatie) as identificatie,
       b.begin_tijd,
       b.eind_tijd,
       (SELECT TRIM(code) FROM masterdata.dmn_bijzonder_gebied_code WHERE id = b.gebieds_code_id) as gebieds_code,
	   (SELECT TRIM(description) FROM masterdata.dmn_bijzonder_gebied_code WHERE id = b.gebieds_code_id) as gebieds_code_desc,
       TRIM(b.gebieds_naam) as gebieds_naam,
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	   (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,
       b.geom
 FROM imna.vm_prov_year_status_bijzonder_gebied s
 JOIN imna.bijzonder_gebied b ON ( b.id = s.bijzonder_gebied_id);

 ALTER TABLE imna.v_gs_bijzonder_gebied
  OWNER TO anlb;
  
  -- View: imna.v_gs_deel_gebied

-- DROP VIEW imna.v_gs_deel_gebied;

CREATE OR REPLACE VIEW imna.v_gs_deel_gebied AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
	   TRIM(d.identificatie) as identificatie,
   	   d.begin_geldigheid,
	   NULL as eind_geldigheid,
       d.begin_tijd,
       d.eind_tijd,
       TRIM(d.gebieds_naam) as gebieds_naam,
       TRIM(d.beschrijving) as beschrijving,
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	   (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,
       d.geom
 FROM imna.vm_prov_year_status_deel_gebied s
 JOIN imna.deel_gebied d ON ( d.id = s.deel_gebied_id);

 ALTER TABLE imna.v_gs_deel_gebied
  OWNER TO anlb;
  
  -- View: imna.v_gs_natuur_beheer_plan

-- DROP VIEW imna.v_gs_natuur_beheer_plan;

CREATE OR REPLACE VIEW imna.v_gs_natuur_beheer_plan AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
	   TRIM(p.identificatie) as identificatie,
   	   p.begin_geldigheid,
	   NULL as eind_geldigheid,
	   p.datum_vaststelling,
	   TRIM(p.plan_naam) as plan_naam,
	   (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = p.plan_eigenaar_id) as plan_eigenaar,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = p.plan_eigenaar_id) as plan_eigenaar_desc,
	   TRIM(p.plan_verwijzing) as plan_verwijzing,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.beheer_gebied_status_id) as beheer_gebied_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.beheer_gebied_status_id) as beheer_gebied_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.beheer_gebied_ambitie_status_id) as beheer_gebied_ambitie_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.beheer_gebied_ambitie_status_id) as beheer_gebied_ambitie_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.bijzonder_gebied_status_id) as bijzonder_gebied_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.bijzonder_gebied_status_id) as bijzonder_gebied_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.deel_gebied_status_id) as deel_gebied_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.deel_gebied_status_id) as deel_gebied_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_landschap_status_id) as zoek_gebied_landschap_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_landschap_status_id) as zoek_gebied_landschap_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_agrarisch_status_id) as zoek_gebied_agrarisch_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_agrarisch_status_id) as zoek_gebied_agrarisch_status_desc,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_water_status_id) as zoek_gebied_water_status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = p.zoek_gebied_water_status_id) as zoek_gebied_water_status_desc,
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	   document_link AS document_link
 FROM imna.vm_prov_year_status_natuur_beheer_plan s
 JOIN imna.natuur_beheer_plan p ON ( p.id = s.plan_id);

 ALTER TABLE imna.v_gs_natuur_beheer_plan
  OWNER TO anlb;
  
  -- View: imna.v_gs_zoek_gebied_agrarisch

-- DROP VIEW imna.v_gs_zoek_gebied_agrarisch;

CREATE OR REPLACE VIEW imna.v_gs_zoek_gebied_agrarisch AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
	   TRIM(a.identificatie) as identificatie,
       a.begin_tijd,
       a.eind_tijd,
      (SELECT TRIM(code) FROM masterdata.dmn_natuur_type_agrarisch WHERE id = a.agrarisch_natuur_type_id) as agrarisch_natuur_type,
	  (SELECT TRIM(description) FROM masterdata.dmn_natuur_type_agrarisch WHERE id = a.agrarisch_natuur_type_id) as agrarisch_natuur_type_desc,
       TRIM(a.naam) as naam,
       TRIM(a.deel_gebied_naam) as deel_gebied_naam,
       -- toegestane_beheer_functies
       (SELECT STRING_AGG (d.code || ': ' || d.description, 
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_functies_agrarisch fun
	      JOIN masterdata.dmn_beheer_functie d ON (d.id = fun.beheer_functie_id)
         WHERE fun.zoek_gebied_agrarisch_id = a.id) AS toegestane_beheer_functies,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code || ': ' || d.description, 
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_agrarisch typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_agrarisch_id = a.id) AS toegestane_beheer_typen,
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	   (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,
       a.geom
 FROM imna.vm_prov_year_status_zoek_gebied_agrarisch s
 JOIN imna.zoek_gebied_agrarisch a ON ( a.id = s.zoek_gebied_agrarisch_id);

 ALTER TABLE imna.v_gs_zoek_gebied_agrarisch
  OWNER TO anlb;
  
  -- View: imna.v_gs_zoek_gebied_landschap

-- DROP VIEW imna.v_gs_zoek_gebied_landschap;

CREATE OR REPLACE VIEW imna.v_gs_zoek_gebied_landschap AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
	   TRIM(l.identificatie) as identificatie,
   	   l.begin_geldigheid,
	   NULL as eind_geldigheid,
       l.begin_tijd,
       l.eind_tijd,
       TRIM(l.naam) as naam,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code || ': ' || d.description,  
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_landschap typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_landschap_id = l.id) AS toegestane_beheer_typen,
       -- niet_subsidiabele_beheer_pakketten
       (SELECT STRING_AGG (d.code || ': ' || d.description,  
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_niet_subsidiabele_beheer_pakketten_landschap pak
	      JOIN masterdata.dmn_beheer_pakket_landschap d ON (d.id = pak.beheer_pakket_id)
         WHERE pak.zoek_gebied_landschap_id = l.id) AS niet_subsidiabele_beheer_pakketten, 
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
       (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link,		 
       l.geom
 FROM imna.vm_prov_year_status_zoek_gebied_landschap s
 JOIN imna.zoek_gebied_landschap l ON ( l.id = s.zoek_gebied_landschap_id);

 ALTER TABLE imna.v_gs_zoek_gebied_landschap
  OWNER TO anlb;
  
  -- View: imna.v_gs_zoek_gebied_water

-- DROP VIEW imna.v_gs_zoek_gebied_water;

CREATE OR REPLACE VIEW imna.v_gs_zoek_gebied_water AS 
SELECT (SELECT TRIM(code) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   (SELECT TRIM(description) FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie_desc,
	   s.subsidie_jaar,
	   (SELECT TRIM(code) FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   (SELECT TRIM(description) FROM masterdata.dmn_status_plan where id = s.status_id) as status_desc,
	   TRIM(a.identificatie) as identificatie,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
       a.begin_tijd,
       a.eind_tijd,
      (SELECT TRIM(code) FROM masterdata.dmn_natuur_type_water WHERE id = a.water_natuur_type_id) as water_natuur_type,
	  (SELECT TRIM(description) FROM masterdata.dmn_natuur_type_water WHERE id = a.water_natuur_type_id) as water_natuur_type_desc,
       TRIM(a.naam) as naam,
       TRIM(a.deel_gebied_naam) as deel_gebied_naam,
       -- toegestane_beheer_functies
       (SELECT STRING_AGG (d.code || ': ' || d.description, 
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_functies_water fun
	      JOIN masterdata.dmn_beheer_functie d ON (d.id = fun.beheer_functie_id)
         WHERE fun.zoek_gebied_water_id = a.id) AS toegestane_beheer_functies,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code || ': ' || d.description, 
	                       '<br>'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_water typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_water_id = a.id) AS toegestane_beheer_typen,
	   (SELECT value FROM masterdata.parameters pr WHERE pr.name = 'DrupalArchiveURL') || 
	   (SELECT document_link FROM imna.natuur_beheer_plan WHERE id = s.plan_id) AS document_link, 
       a.geom
 FROM imna.vm_prov_year_status_zoek_gebied_water s
 JOIN imna.zoek_gebied_water a ON ( a.id = s.zoek_gebied_water_id);

 ALTER TABLE imna.v_gs_zoek_gebied_water
  OWNER TO anlb;
  
  -- View: imna.v_rvo_beheer_gebied

-- DROP VIEW imna.v_rvo_beheer_gebied;

CREATE OR REPLACE VIEW imna.v_rvo_beheer_gebied AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
       b.identificatie,
	   b.begin_geldigheid,
	   NULL as eind_geldigheid,
       b.begin_tijd,
       b.eind_tijd,
       -- beheer_type
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_natuur WHERE id = n.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_agrarisch WHERE id = a.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'W') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type,
      -- subsidiabel
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	  n.subsidiabel
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  g.subsidiabel
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	  a.subsidiabel
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	  l.subsidiabel
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'W') THEN
	  a.subsidiabel
      END AS subsidiabel,       
      -- openstellings_bijdrage_type
       CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'N') THEN
	  (SELECT code FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = n.openstellings_bijdrage_type_id)
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  (SELECT code FROM masterdata.dmn_openstellings_bijdrage_type WHERE id = g.openstellings_bijdrage_type_id)
      END AS openstellings_bijdrage_type,
      -- indicatieve_verhouding_beheer_typen	
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'G') THEN
	  (SELECT STRING_AGG (i.percentage || '%' || d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.beheer_indicatieve_verhouding_beheer_typen i
	    JOIN masterdata.dmn_beheer_type_natuur d ON (d.id = i.beheer_type_id)
	   WHERE i.beheer_gebied_id = g.beheer_gebied_id)	      
      END AS indicatieve_verhouding_beheer_typen,
      -- toegestane_beheer_paketten
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	  (SELECT STRING_AGG (d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.beheer_toegestane_beheer_pakketten_agrarisch pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = a.beheer_gebied_id)	      
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.beheer_toegestane_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = l.beheer_gebied_id)	      
      END AS toegestane_beheer_paketten,
      -- niet_subsidiabele_beheer_paketten
      CASE 
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'A') THEN
	  (SELECT STRING_AGG (d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.beheer_niet_subsidiabele_beheer_pakketten_agrarisch pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = a.beheer_gebied_id)	      
	WHEN b.gebied_type_id = (SELECT id FROM masterdata.dmn_beheergebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.beheer_niet_subsidiabele_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.beheer_gebied_id = l.beheer_gebied_id)	      
      END AS niet_subsidiabele_beheer_paketten,
      b.geom
 FROM imna.vm_prov_year_status_beheer_gebied s
 JOIN imna.beheer_gebied b ON ( b.id = s.beheer_gebied_id)
 LEFT JOIN imna.beheer_natuur n ON (n.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_grootschaligenatuur g ON (g.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_agrarisch a ON (a.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_landschap l ON (l.beheer_gebied_id = s.beheer_gebied_id) 
 LEFT JOIN imna.beheer_water w ON (w.beheer_gebied_id = s.beheer_gebied_id);

 ALTER TABLE imna.v_rvo_beheer_gebied
  OWNER TO anlb;
  
  -- View: imna.v_rvo_beheer_gebied_ambitie

-- DROP VIEW imna.v_rvo_beheer_gebied_ambitie;

CREATE OR REPLACE VIEW imna.v_rvo_beheer_gebied_ambitie AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
	   a.identificatie,
       a.begin_tijd,
       a.eind_tijd,
       (SELECT code FROM masterdata.dmn_status_ehs WHERE id = a.status_ehs_id) as status_ehs,
          -- beheer_type
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'N') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_natuur_ambitie WHERE id = n.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_grootschaligenatuur WHERE id = g.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie WHERE id = v.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_landschap WHERE id = l.beheer_type_id)
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'W') THEN
	   (SELECT code FROM masterdata.dmn_beheer_type_water WHERE id = w.beheer_type_id)
      END AS beheer_type,
 -- subsidiabel
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'N') THEN
	  n.subsidiabel
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	  g.subsidiabel
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	  v.subsidiabel	  
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	  l.subsidiabel
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'W') THEN
	  w.subsidiabel
      END AS subsidiabel,  	  
      -- indicatieve_verhouding_beheer_typen	
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'G') THEN
	  (SELECT STRING_AGG (i.percentage || '%' || d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.ambitie_indicatieve_verhouding_beheer_typen_gr i
	    JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON (d.id = i.beheer_type_id)
	   WHERE i.ambitie_gebied_id = g.ambitie_gebied_id)	      
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'V') THEN
	  (SELECT STRING_AGG (i.percentage || '%' || d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.ambitie_indicatieve_verhouding_beheer_typen_vr i
	    JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON (d.id = i.beheer_type_id)
	   WHERE i.ambitie_gebied_id = v.ambitie_gebied_id)	     	   
      END AS indicatieve_verhouding_beheer_typen,
       -- toegestane_beheer_paketten
      CASE 
	WHEN a.gebied_type_id = (SELECT id FROM masterdata.dmn_ambitiegebied_type WHERE code = 'L') THEN
	  (SELECT STRING_AGG (d.code , 
			      ';'
			      ORDER BY d.code)
	    FROM imna.ambitie_toegestane_beheer_pakketten_landschap pak
	    JOIN masterdata.dmn_beheer_pakket d ON (d.id = pak.beheer_pakket_id)
	   WHERE pak.ambitie_gebied_id = l.ambitie_gebied_id)	      
      END AS toegestane_beheer_paketten,
      a.geom
 FROM imna.vm_prov_year_status_beheer_gebied_ambitie s
 JOIN imna.beheer_gebied_ambitie a ON ( a.id = s.ambitie_gebied_id)
 LEFT JOIN imna.ambitie_natuur n ON (n.ambitie_gebied_id = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_grootschaligenatuur g ON (g.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_omtevormennatuur v ON (v.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_landschap l ON (l.ambitie_gebied_id  = s.ambitie_gebied_id) 
 LEFT JOIN imna.ambitie_water w ON (w.ambitie_gebied_id  = s.ambitie_gebied_id);

 ALTER TABLE imna.v_rvo_beheer_gebied_ambitie
  OWNER TO anlb;
  
  -- View: imna.v_rvo_bijzonder_gebied

-- DROP VIEW imna.v_rvo_bijzonder_gebied;

CREATE OR REPLACE VIEW imna.v_rvo_bijzonder_gebied AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
   	   b.begin_geldigheid,
	   NULL as eind_geldigheid,
	   b.identificatie,
       b.begin_tijd,
       b.eind_tijd,
       (SELECT code FROM masterdata.dmn_bijzonder_gebied_code WHERE id = b.gebieds_code_id) as gebieds_code,
       b.gebieds_naam,
       b.geom
 FROM imna.vm_prov_year_status_bijzonder_gebied s
 JOIN imna.bijzonder_gebied b ON ( b.id = s.bijzonder_gebied_id);

 ALTER TABLE imna.v_rvo_bijzonder_gebied
  OWNER TO anlb;
  
  -- View: imna.v_rvo_deel_gebied

-- DROP VIEW imna.v_rvo_deel_gebied;

CREATE OR REPLACE VIEW imna.v_rvo_deel_gebied AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   d.identificatie,
   	   d.begin_geldigheid,
	   NULL as eind_geldigheid,
       d.begin_tijd,
       d.eind_tijd,
       d.gebieds_naam,
       d.beschrijving,
       d.geom
 FROM imna.vm_prov_year_status_deel_gebied s
 JOIN imna.deel_gebied d ON ( d.id = s.deel_gebied_id);

 ALTER TABLE imna.v_rvo_deel_gebied
  OWNER TO anlb;
  
  -- View: imna.v_rvo_natuur_beheer_plan

-- DROP VIEW imna.v_rvo_natuur_beheer_plan;

CREATE OR REPLACE VIEW imna.v_rvo_natuur_beheer_plan AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   p.identificatie,
   	   p.begin_geldigheid,
	   NULL as eind_geldigheid,
	   p.datum_vaststelling,
	   p.plan_naam,
	   (SELECT code FROM masterdata.dmn_provincie_code where id = p.plan_eigenaar_id) as plan_eigenaar,
	   p.plan_verwijzing,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.beheer_gebied_status_id) as beheer_gebied_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.beheer_gebied_ambitie_status_id) as beheer_gebied_ambitie_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.bijzonder_gebied_status_id) as bijzonder_gebied_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.deel_gebied_status_id) as deel_gebied_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.zoek_gebied_landschap_status_id) as zoek_gebied_landschap_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.zoek_gebied_agrarisch_status_id) as zoek_gebied_agrarisch_status,
	   (SELECT code FROM masterdata.dmn_status_plan where id = p.zoek_gebied_water_status_id) as zoek_gebied_water_status,
	   document_link 
 FROM imna.vm_prov_year_status_natuur_beheer_plan s
 JOIN imna.natuur_beheer_plan p ON ( p.id = s.plan_id);

 ALTER TABLE imna.v_rvo_natuur_beheer_plan
  OWNER TO anlb;
  
  -- View: imna.v_rvo_zoek_gebied_agrarisch

-- DROP VIEW imna.v_rvo_zoek_gebied_agrarisch;

CREATE OR REPLACE VIEW imna.v_rvo_zoek_gebied_agrarisch AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
	   a.identificatie,
       a.begin_tijd,
       a.eind_tijd,
      (SELECT code FROM masterdata.dmn_natuur_type_agrarisch WHERE id = a.agrarisch_natuur_type_id) as agrarisch_natuur_type,
       a.naam,
       a.deel_gebied_naam,
       -- toegestane_beheer_functies
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_functies_agrarisch fun
	      JOIN masterdata.dmn_beheer_functie d ON (d.id = fun.beheer_functie_id)
         WHERE fun.zoek_gebied_agrarisch_id = a.id) AS toegestane_beheer_functies,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_agrarisch typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_agrarisch_id = a.id) AS toegestane_beheer_typen,
       a.geom
 FROM imna.vm_prov_year_status_zoek_gebied_agrarisch s
 JOIN imna.zoek_gebied_agrarisch a ON ( a.id = s.zoek_gebied_agrarisch_id);

 ALTER TABLE imna.v_rvo_zoek_gebied_agrarisch
  OWNER TO anlb;
  
  -- View: imna.v_rvo_zoek_gebied_landschap

-- DROP VIEW imna.v_rvo_zoek_gebied_landschap;

CREATE OR REPLACE VIEW imna.v_rvo_zoek_gebied_landschap AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   l.identificatie,
   	   l.begin_geldigheid,
	   NULL as eind_geldigheid,
       l.begin_tijd,
       l.eind_tijd,
       l.naam,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_landschap typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_landschap_id = l.id) AS toegestane_beheer_typen,
       -- niet_subsidiabele_beheer_pakketten
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_niet_subsidiabele_beheer_pakketten_landschap pak
	      JOIN masterdata.dmn_beheer_pakket_landschap d ON (d.id = pak.beheer_pakket_id)
         WHERE pak.zoek_gebied_landschap_id = l.id) AS niet_subsidiabele_beheer_pakketten,  
       l.geom
 FROM imna.vm_prov_year_status_zoek_gebied_landschap s
 JOIN imna.zoek_gebied_landschap l ON ( l.id = s.zoek_gebied_landschap_id);

 ALTER TABLE imna.v_rvo_zoek_gebied_landschap
  OWNER TO anlb;
  
  -- View: imna.v_rvo_zoek_gebied_water

-- DROP VIEW imna.v_rvo_zoek_gebied_water;

CREATE OR REPLACE VIEW imna.v_rvo_zoek_gebied_water AS 
SELECT (SELECT code FROM masterdata.dmn_provincie_code where id = s.provincie_id) as provincie,
	   s.subsidie_jaar,
	   (SELECT code FROM masterdata.dmn_status_plan where id = s.status_id) as status,
	   a.identificatie,
   	   a.begin_geldigheid,
	   NULL as eind_geldigheid,
       a.begin_tijd,
       a.eind_tijd,
      (SELECT code FROM masterdata.dmn_natuur_type_water WHERE id = a.water_natuur_type_id) as water_natuur_type,
       a.naam,
       a.deel_gebied_naam,
       -- toegestane_beheer_functies
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_functies_water fun
	      JOIN masterdata.dmn_beheer_functie d ON (d.id = fun.beheer_functie_id)
         WHERE fun.zoek_gebied_water_id = a.id) AS toegestane_beheer_functies,
       -- toegestane_beheer_typen
       (SELECT STRING_AGG (d.code , 
	                       ';'
			               ORDER BY d.code)
	      FROM imna.zoek_gebied_toegestane_beheer_typen_water typ
	      JOIN masterdata.dmn_beheer_type d ON (d.id = typ.beheer_type_id)
         WHERE typ.zoek_gebied_water_id = a.id) AS toegestane_beheer_typen,
       a.geom
 FROM imna.vm_prov_year_status_zoek_gebied_water s
 JOIN imna.zoek_gebied_water a ON ( a.id = s.zoek_gebied_water_id);

 ALTER TABLE imna.v_rvo_zoek_gebied_water
  OWNER TO anlb;