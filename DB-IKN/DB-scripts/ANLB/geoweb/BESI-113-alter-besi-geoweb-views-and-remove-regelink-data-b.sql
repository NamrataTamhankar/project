

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
	
	
-- Remove table object-ids from table geoweb.besi_report_request
ALTER TABLE IF EXISTS geoweb.besi_report_request DROP COLUMN IF EXISTS object_ids;

GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO besi_readonly;
GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO besi_geoweb;
GRANT SELECT ON TABLE geoweb.v_besi_beschermde_factor TO anlb_sqlpad;
	
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO besi_readonly;
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO besi_geoweb;
GRANT SELECT ON TABLE geoweb.v_besi_soorten_en_adviezen TO anlb_sqlpad;

GRANT SELECT ON TABLE geoweb.v_besi_dso_data TO besi_readonly;
GRANT SELECT ON geoweb.v_besi_dso_data TO besi_geoweb;
GRANT SELECT ON geoweb.v_besi_dso_data TO anlb_sqlpad;