DROP VIEW IF EXISTS besi.v_gs_besi_species_group_kans_versie;
DROP VIEW IF EXISTS geoserver.besi_besi_species_group_kansen;
DROP VIEW IF EXISTS besi.v_gs_besi_species_group_kansen;
DROP VIEW IF EXISTS besi.v_gs_taxa_kans_versie;
DROP VIEW IF EXISTS geoserver.besi_taxa_kansen;
DROP VIEW IF EXISTS besi.v_gs_taxa_kansen;
DROP VIEW IF EXISTS geoweb.v_besi_soorten_en_adviezen;
DROP VIEW IF EXISTS geoweb.v_besi_dso_data;
DROP VIEW IF EXISTS geoweb.v_besi_beschermde_factor;
DROP VIEW IF EXISTS besi.v_gw_besi_star;
DROP VIEW IF EXISTS besi.v_gw_besi_star_besi_species_group;
DROP VIEW IF EXISTS besi.v_gw_besi_all_species_in_grid;
DROP VIEW IF EXISTS geoserver.besi_public_geotiff_files;


CREATE OR REPLACE VIEW besi.v_gs_besi_species_group_kans_versie
 AS
 SELECT k.besi_species_group_id,
    t.identity,
    t.name,
    t.scientific,
    k.versie,
    k.datum,
    k.omschrijving
   FROM besi.besi_species_group_kans_versie k
     JOIN besi.besi_species_group t ON t.id = k.besi_species_group_id
  WHERE (EXISTS ( SELECT 1
           FROM besi.besi_species_group t_1
          WHERE t_1.id = k.besi_species_group_id AND t_1.publish = true)) AND NOT (EXISTS ( SELECT 1
           FROM besi.besi_species_group_kans_versie kh
          WHERE kh.besi_species_group_id = k.besi_species_group_id AND kh.versie > k.versie));

ALTER TABLE besi.v_gs_besi_species_group_kans_versie
    OWNER TO anlb;


-- View: besi.v_gs_species_group_kansen

 CREATE OR REPLACE VIEW besi.v_gs_besi_species_group_kansen
 AS
 SELECT k.besi_species_group_id,
    t.identity,
    t.name,
    t.scientific,
    k.kans,
    g.geom
   FROM besi.besi_species_group_kansen_huidig k
   JOIN besi.basis_grid g ON g.id = k.grid_id
   JOIN besi.besi_species_group t ON t.id = k.besi_species_group_id
  WHERE k.kans > 0::numeric 
    AND (EXISTS ( SELECT 1
                    FROM besi.besi_species_group t_1
                   WHERE t_1.id = k.besi_species_group_id 
					 AND t_1.publish = true)) ; 
ALTER TABLE besi.v_gs_besi_species_group_kansen
    OWNER TO anlb;


CREATE OR REPLACE VIEW besi.v_gs_taxa_kans_versie
 AS
 SELECT k.taxa_id,
    t.identity,
    t.name,
    t.scientific,
    k.versie,
    k.datum,
    k.omschrijving
   FROM besi.taxa_kans_versie k
     JOIN ndff.taxa t ON t.id = k.taxa_id
  WHERE (EXISTS ( SELECT 1
           FROM besi.besi_taxa t_1
          WHERE t_1.taxa_id = k.taxa_id AND t_1.publish = true)) AND NOT (EXISTS ( SELECT 1
           FROM besi.taxa_kans_versie kh
          WHERE kh.taxa_id = k.taxa_id AND kh.versie > k.versie));

ALTER TABLE besi.v_gs_taxa_kans_versie
    OWNER TO anlb;

-- View: besi.v_gs_taxa_kansen

 CREATE OR REPLACE VIEW besi.v_gs_taxa_kansen
 AS
 SELECT k.taxa_id,
    t.identity,
    t.name,
    t.scientific,
    k.kans,
    g.geom
   FROM besi.taxa_kansen_huidig k
   JOIN besi.basis_grid g ON g.id = k.grid_id
   JOIN ndff.taxa t ON t.id = k.taxa_id
  WHERE k.kans > 0::numeric 
    AND (EXISTS ( SELECT 1
                    FROM besi.besi_taxa t_1
                   WHERE t_1.taxa_id = k.taxa_id 
					 AND t_1.publish = true)) ; 
ALTER TABLE besi.v_gs_taxa_kansen
    OWNER TO anlb;
	
CREATE OR REPLACE VIEW besi.v_gw_besi_star
 AS
  SELECT effect_werkzaamheid.werkzaamheid_id,
		effect_soort.taxa_id,
		taxa_kansen_huidig.grid_id
   FROM besi.effect_werkzaamheid
   JOIN besi.effect_soort ON effect_werkzaamheid.effect_id = effect_soort.effect_id
   JOIN besi.taxa_kansen_huidig ON taxa_kansen_huidig.taxa_id = effect_soort.taxa_id
   JOIN besi.besi_taxa ON besi_taxa.taxa_id = taxa_kansen_huidig.taxa_id 
  WHERE (EXISTS ( SELECT 1
                    FROM besi.besi_taxa
                   WHERE besi_taxa.taxa_id = effect_soort.taxa_id 
				     AND besi_taxa.valid_to IS NULL)) 
	AND (EXISTS ( SELECT 1
					FROM besi.taxa_rapport_text
					WHERE taxa_rapport_text.taxa_id = effect_soort.taxa_id)) 
	AND ((besi_taxa.selectie_kans is NULL AND taxa_kansen_huidig.kans > 0.75)
	OR (besi_taxa.selectie_kans is NOT NULL AND taxa_kansen_huidig.kans > besi_taxa.selectie_kans));

ALTER TABLE besi.v_gw_besi_star
    OWNER TO anlb;


CREATE OR REPLACE VIEW besi.v_gw_besi_star_besi_species_group
 AS
 SELECT effect_werkzaamheid.werkzaamheid_id,
		effect_besi_species_group.besi_species_group_id,
		besi_species_group_kansen_huidig.grid_id
   FROM besi.effect_werkzaamheid
   JOIN besi.effect_besi_species_group ON effect_werkzaamheid.effect_id = effect_besi_species_group.effect_id
   JOIN besi.besi_species_group_kansen_huidig ON besi_species_group_kansen_huidig.besi_species_group_id = effect_besi_species_group.besi_species_group_id
   JOIN besi.besi_species_group ON besi_species_group.id = besi_species_group_kansen_huidig.besi_species_group_id 
  WHERE (EXISTS ( SELECT 1
                    FROM besi.besi_species_group
                   WHERE besi_species_group.id = effect_besi_species_group.besi_species_group_id 
				     AND besi_species_group.valid_to IS NULL)) 
	AND (EXISTS ( SELECT 1
					FROM besi.besi_species_group_rapport_text
					WHERE besi_species_group_rapport_text.besi_species_group_id = effect_besi_species_group.besi_species_group_id)) 
	AND ((besi_species_group.selectie_kans is NULL AND besi_species_group_kansen_huidig.kans > 0.75)
	OR (besi_species_group.selectie_kans is NOT NULL AND besi_species_group_kansen_huidig.kans > besi_species_group.selectie_kans));


ALTER TABLE besi.v_gw_besi_star_besi_species_group
    OWNER TO anlb;


CREATE OR REPLACE VIEW besi.v_gw_besi_all_species_in_grid
 AS
 SELECT t.identity, t.name, t.scientific, 
	bt.valid_from, bt.valid_to, bt.publish, 
	tkh.grid_id, tkh.kans
  FROM besi.besi_taxa bt
  JOIN besi.taxa_kansen_huidig tkh on tkh.taxa_id = bt.taxa_id
  JOIN ndff.taxa t on t.id = bt.taxa_id
  WHERE bt.valid_to IS NULL
UNION
SELECT sg.identity, sg.name, sg.scientific, 
	sg.valid_from, sg.valid_to, sg.publish, 
	sgkh.grid_id, sgkh.kans
  FROM besi.besi_species_group sg
  JOIN besi.besi_species_group_kansen_huidig sgkh on sgkh.besi_species_group_id = sg.id
  WHERE sg.valid_to IS NULL;

ALTER TABLE besi.v_gw_besi_all_species_in_grid
    OWNER TO anlb;
	
	
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;





CREATE OR REPLACE VIEW geoserver.besi_public_geotiff_files AS
SELECT t.name as dutch_name, 
    t.scientific,
    g1.versie,
    g1.creation_date, 
    ( SELECT file_name
            FROM geoweb.besi_geotiff_files gf
           WHERE gf.taxa_id = g1.taxa_id 
           AND gf.versie = g1.versie
           AND LOWER(file_type) = 'zip' limit 1) AS file_name,
    ((((( SELECT parameters.value
			   FROM masterdata.parameters
			  WHERE parameters.name::text = 'GeoWebBesiPublicGeotiffGetFileURL'::text))::text)) || ''::text) || 
		 ((( SELECT file_name
            FROM geoweb.besi_geotiff_files gf
           WHERE gf.taxa_id = g1.taxa_id 
           AND gf.versie = g1.versie
           AND LOWER(file_type) = 'zip' limit 1))::text) AS zipfile_url,
	NULL::geometry AS geom
FROM geoweb.besi_geotiff g1
JOIN ndff.taxa t on t.id = g1.taxa_id
JOIN besi.besi_taxa bt on bt.taxa_id = g1.taxa_id
WHERE bt.publish = true
AND g1.versie = (SELECT max(g2.versie) FROM geoweb.besi_geotiff g2 WHERE g2.taxa_id = g1.taxa_id)
UNION
SELECT bt.name as dutch_name, 
    bt.scientific,
    g1.versie,
    g1.creation_date, 
    ( SELECT file_name
            FROM geoweb.besi_species_group_geotiff_files gf
           WHERE gf.besi_species_group_id = g1.besi_species_group_id 
           AND gf.versie = g1.versie
           AND LOWER(file_type) = 'zip' limit 1) AS file_name,
    ((((( SELECT parameters.value
               FROM masterdata.parameters
              WHERE parameters.name::text = 'GeoWebBesiPublicGeotiffGetFileURL'::text))::text)) || ''::text) || 
         ((( SELECT file_name
            FROM geoweb.besi_species_group_geotiff_files gf
           WHERE gf.besi_species_group_id = g1.besi_species_group_id 
           AND gf.versie = g1.versie
           AND LOWER(file_type) = 'zip' limit 1))::text) AS zipfile_url,
    NULL::geometry AS geom
FROM geoweb.besi_species_group_geotiff g1
JOIN besi.besi_species_group bt on bt.id = g1.besi_species_group_id
WHERE bt.publish = true
AND g1.versie = (SELECT max(g2.versie) FROM geoweb.besi_species_group_geotiff g2 WHERE g2.besi_species_group_id = g1.besi_species_group_id);
 
ALTER TABLE geoserver.besi_public_geotiff_files
    OWNER TO anlb;
 
GRANT ALL ON TABLE geoserver.besi_public_geotiff_files TO anlb;
GRANT SELECT ON TABLE geoserver.besi_public_geotiff_files TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.besi_public_geotiff_files TO besi_readonly;



CREATE OR REPLACE VIEW geoserver.besi_besi_species_group_kansen
 AS
 SELECT v_gs_besi_species_group_kansen.besi_species_group_id,
    v_gs_besi_species_group_kansen.identity,
    v_gs_besi_species_group_kansen.name,
    v_gs_besi_species_group_kansen.scientific,
    v_gs_besi_species_group_kansen.kans,
    v_gs_besi_species_group_kansen.geom
   FROM besi.v_gs_besi_species_group_kansen;

ALTER TABLE geoserver.besi_besi_species_group_kansen
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.besi_besi_species_group_kansen TO besi_readonly;

CREATE OR REPLACE VIEW geoserver.besi_taxa_kansen
 AS
 SELECT v_gs_taxa_kansen.taxa_id,
    v_gs_taxa_kansen.identity,
    v_gs_taxa_kansen.name,
    v_gs_taxa_kansen.scientific,
    v_gs_taxa_kansen.kans,
    v_gs_taxa_kansen.geom
   FROM besi.v_gs_taxa_kansen;

ALTER TABLE geoserver.besi_taxa_kansen
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.besi_taxa_kansen TO besi_readonly;


-- Alter the Geoweb views which are fetching Regelink data
CREATE OR REPLACE VIEW geoweb.v_besi_beschermde_factor
 AS
 SELECT DISTINCT r.id AS request_id,
    nt.name,
    nt.scientific AS scientific_name,
    df.description AS beschermende_factor_description,
    df.code AS beschermende_factor_code,
    k.versie AS kans_versie,
    k.datum AS kans_datum
   FROM geoweb.besi_report_request r
     JOIN besi.v_gw_besi_star s ON (s.grid_id = ANY (r.grid_ids)) AND s.werkzaamheid_id = r.werkzaamheid_id
     JOIN ndff.taxa nt ON nt.id = s.taxa_id
     JOIN besi.besi_taxa bt ON bt.taxa_id = s.taxa_id
     JOIN masterdata.dmn_beschermende_factor df ON df.id = bt.beschermende_factor_id
     JOIN besi.taxa_kans_versie k ON k.taxa_id = s.taxa_id
  WHERE NOT (EXISTS ( SELECT 1
           FROM besi.taxa_kans_versie kh
          WHERE kh.taxa_id = k.taxa_id AND kh.versie > k.versie))
UNION
SELECT DISTINCT r.id AS request_id,
    bt.name,
    bt.scientific AS scientific_name,
    df.description AS beschermende_factor_description,
    df.code AS beschermende_factor_code,
    k.versie AS kans_versie,
    k.datum AS kans_datum
   FROM geoweb.besi_report_request r
     JOIN besi.v_gw_besi_star_besi_species_group s ON (s.grid_id = ANY (r.grid_ids)) AND s.werkzaamheid_id = r.werkzaamheid_id
     JOIN besi.besi_species_group bt ON bt.id = s.besi_species_group_id
     JOIN masterdata.dmn_beschermende_factor df ON df.id = bt.beschermende_factor_id
     JOIN besi.besi_species_group_kans_versie k ON k.besi_species_group_id = s.besi_species_group_id
  WHERE NOT (EXISTS ( SELECT 1
           FROM besi.besi_species_group_kans_versie kh
          WHERE kh.besi_species_group_id = k.besi_species_group_id AND kh.versie > k.versie));
 
ALTER TABLE geoweb.v_besi_beschermde_factor
    OWNER TO anlb;

COMMENT ON VIEW geoweb.v_besi_beschermde_factor
	IS 'This view is being used when creating the report in Besi. This view contains the information for beschermde factor in the generated report'
;

CREATE OR REPLACE VIEW geoweb.v_besi_soorten_en_adviezen
 AS
 SELECT DISTINCT r.id AS request_id,
    t.name,
    a.description,
    rt.beschrijving_habitat AS report_text_beschrijving_habitat,
    rt.gevoeligheid AS report_text_gevoeligheid,
    rt.advies AS report_text_advies
   FROM geoweb.besi_report_request r
     JOIN besi.v_gw_besi_star s ON (s.grid_id = ANY (r.grid_ids)) AND s.werkzaamheid_id = r.werkzaamheid_id
     JOIN besi.taxa_rapport_text rt ON rt.taxa_id = s.taxa_id
     JOIN ndff.taxa t ON t.id = s.taxa_id
     JOIN besi.besi_taxa b ON b.taxa_id = s.taxa_id
     JOIN masterdata.dmn_animal_group a ON a.id = b.animal_group_id
UNION
 SELECT DISTINCT r.id AS request_id,
    t.name,
    a.description,
    rt.beschrijving_habitat AS report_text_beschrijving_habitat,
    rt.gevoeligheid AS report_text_gevoeligheid,
    rt.advies AS report_text_advies
   FROM geoweb.besi_report_request r
     JOIN besi.v_gw_besi_star_besi_species_group s ON (s.grid_id = ANY (r.grid_ids)) AND s.werkzaamheid_id = r.werkzaamheid_id
     JOIN besi.besi_species_group_rapport_text rt ON rt.besi_species_group_id = s.besi_species_group_id
     JOIN besi.besi_species_group t ON t.id = s.besi_species_group_id
     JOIN masterdata.dmn_animal_group a ON a.id = t.animal_group_id;
 
ALTER TABLE geoweb.v_besi_soorten_en_adviezen
    OWNER TO anlb;
	
COMMENT ON VIEW geoweb.v_besi_soorten_en_adviezen
	IS 'This view is being used when creating the report in Besi. This view contains the information for soorten en adviezen in the generated report'
;

CREATE OR REPLACE VIEW geoweb.v_besi_dso_data
 AS
  SELECT request_id, COALESCE(bool_or(CAST(Zoogdieren AS boolean)), false) AS Zoogdieren, COALESCE(bool_or(CAST(Vogels AS boolean)), false) AS Vogels,
  COALESCE(bool_or(CAST("Andere diersoort dan vogels of zoogdieren" AS boolean)), false) AS "Andere diersoort dan vogels of zoogdieren", COALESCE(bool_or(CAST(Planten AS boolean)), false) AS Planten, 
  COALESCE(bool_or(CAST(Jaarrond AS boolean)), false) AS Jaarrond, COALESCE(bool_or(CAST(Broedseizoen AS boolean)), false) AS Broedseizoen,
  COALESCE(bool_or(CAST(Vleermuizen AS boolean)), false) AS Vleermuizen, COALESCE(bool_or(CAST(Eekhoorn AS boolean)), false) AS Eekhoorn, COALESCE(bool_or(CAST(Steenmarter AS boolean)), false) AS Steenmarter,
  COALESCE(bool_or(CAST("Andere marterachtige dan steenmarter" AS boolean)), false) AS "Andere marterachtige dan steenmarter", COALESCE(bool_or(CAST("Overige zoogdieren" AS boolean)), false) AS "Overige zoogdieren"
  FROM(
	 SELECT 
		DISTINCT r.id AS request_id, 
		----------------------- Zoogdieren ----------------------
		CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(ag.code::text) = 'zd'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS zoogdieren,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(ag.code::text) = 'vo'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS vogels,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(ag.code::text) = 'ad'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Andere diersoort dan vogels of zoogdieren",
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(ag.code::text) = 'pl'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS planten,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_protected_nest pn ON pn.id = st1.protected_nest_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(pn.code::text) = 'jr'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS jaarrond,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_protected_nest pn ON pn.id = st1.protected_nest_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(pn.code::text) = 'bs'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS broedseizoen,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(mt.code::text) = 'vm'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS vleermuizen,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(mt.code::text) = 'eh'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS eekhoorn,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(mt.code::text) = 'sm'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS steenmarter,
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(mt.code::text) = 'am'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Andere marterachtige dan steenmarter",
                CASE
                    WHEN (( SELECT count(st1.taxa_id) AS count
                       FROM besi.besi_taxa st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.taxa_id = s.taxa_id AND lower(mt.code::text) = 'oz'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Overige zoogdieren"
           FROM geoweb.besi_report_request r
             JOIN besi.v_gw_besi_star s ON (s.grid_id = ANY (r.grid_ids)) AND s.werkzaamheid_id = r.werkzaamheid_id
        UNION
         SELECT DISTINCT r.id AS request_id,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.id = s.besi_species_group_id AND lower(ag.code::text) = 'zd'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS zoogdieren,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.id = s.besi_species_group_id AND lower(ag.code::text) = 'vo'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS vogels,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.id = s.besi_species_group_id AND lower(ag.code::text) = 'ad'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Andere diersoort dan vogels of zoogdieren",
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_animal_group ag ON ag.id = st1.animal_group_id
                      WHERE st1.id = s.besi_species_group_id AND lower(ag.code::text) = 'pl'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS planten,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_protected_nest pn ON pn.id = st1.protected_nest_id
                      WHERE st1.id = s.besi_species_group_id AND lower(pn.code::text) = 'jr'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS jaarrond,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_protected_nest pn ON pn.id = st1.protected_nest_id
                      WHERE st1.id = s.besi_species_group_id AND lower(pn.code::text) = 'bs'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS broedseizoen,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.id = s.besi_species_group_id AND lower(mt.code::text) = 'vm'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS vleermuizen,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.id = s.besi_species_group_id AND lower(mt.code::text) = 'eh'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS eekhoorn,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.id = s.besi_species_group_id AND lower(mt.code::text) = 'sm'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS steenmarter,
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.id = s.besi_species_group_id AND lower(mt.code::text) = 'am'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Andere marterachtige dan steenmarter",
                CASE
                    WHEN (( SELECT count(st1.id) AS count
                       FROM besi.besi_species_group st1
                         LEFT JOIN masterdata.dmn_mammal_type mt ON mt.id = st1.mammal_type_id
                      WHERE st1.id = s.besi_species_group_id AND lower(mt.code::text) = 'oz'::text)) > 0 THEN 'true'::text
                    ELSE 'false'::text
                END AS "Overige zoogdieren"
           FROM geoweb.besi_report_request r
	JOIN besi.v_gw_besi_star_besi_species_group s ON s.grid_id = ANY (r.grid_ids) AND s.werkzaamheid_id = r.werkzaamheid_id) AS foo
  GROUP BY request_id;

ALTER TABLE geoweb.v_besi_dso_data
    OWNER TO anlb;
	


GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO besi_readonly;
GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO besi_geoweb;
GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO anlb_sqlpad;
	
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO besi_readonly;
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO besi_geoweb;
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO anlb_sqlpad;

GRANT SELECT ON TABLE geoweb.v_besi_dso_data TO besi_readonly;
GRANT SELECT ON geoweb.v_besi_dso_data TO besi_geoweb;
GRANT SELECT ON geoweb.v_besi_dso_data TO anlb_sqlpad;


GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;