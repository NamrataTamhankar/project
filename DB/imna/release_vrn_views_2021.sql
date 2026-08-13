CREATE OR REPLACE VIEW imna.v_gs_resterende_inrichtings_ambitie AS 
 SELECT ( SELECT btrim((dmn_provincie_code.code)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = g.bron_houder_id)) AS bron_houder,
    ( SELECT btrim((dmn_provincie_code.description)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = g.bron_houder_id)) AS bron_houder_desc,
    p.rapportage_jaar,
    btrim((g.identificatie)::text) AS identificatie,
    g.begin_geldigheid,
    NULL::text AS eind_geldigheid,
    g.resterende_inrichtings_ambitie
   FROM (imna.vm_prov_year_resterende_inrichtings_ambitie p
     JOIN imna.resterende_inrichtings_ambitie g ON ((g.id = p.resterende_inrichtings_ambitie_id)));
	 
CREATE OR REPLACE VIEW imna.v_gs_gebied_verwerving AS 
 SELECT ( SELECT btrim((dmn_provincie_code.code)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = g.bron_houder_id)) AS bron_houder,
    ( SELECT btrim((dmn_provincie_code.description)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = g.bron_houder_id)) AS bron_houder_desc,
    p.rapportage_jaar,
    btrim((g.identificatie)::text) AS identificatie,
    g.begin_geldigheid,
    NULL::text AS eind_geldigheid,
    g.begin_tijd,
    g.eind_tijd,
    ( SELECT btrim((dmn_type_beheerder_en_eigenaar.code)::text) AS btrim
           FROM masterdata.dmn_type_beheerder_en_eigenaar
          WHERE (dmn_type_beheerder_en_eigenaar.id = g.type_eigenaar_id)) AS type_eigenaar,
    ( SELECT btrim((dmn_type_beheerder_en_eigenaar.description)::text) AS btrim
           FROM masterdata.dmn_type_beheerder_en_eigenaar
          WHERE (dmn_type_beheerder_en_eigenaar.id = g.type_eigenaar_id)) AS type_eigenaar_desc,
    g.contract_nummer,
    g.relatie_nummer,
    g.geom
   FROM (imna.vm_prov_year_gebied_verwerving p
     JOIN imna.gebied_verwerving g ON ((g.id = p.gebied_verwerving_id)));	 
	 
	 
	 