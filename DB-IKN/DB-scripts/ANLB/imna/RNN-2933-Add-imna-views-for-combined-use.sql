

/* CREATE OR REPLACE VIEW imna.v_rnn_dossier_list AS
	SELECT d.id as dossier_id,
    d.identificatie,
	d.dossier_naam,
	d.beschikkingsjaar,
    d.vegetatiekarteringsjaar,
	d.beoordelaar,
	d.beoordelaar_email_adres,
	d.eigenaar,
	d.datum_beoordeling,
	d.object_begin_tijd,
	d.object_eind_tijd,
	d.toelichting,
	( SELECT dossier_beoordelings_gebied.identificatie
           FROM imna.dossier_beoordelings_gebied
          WHERE dossier_beoordelings_gebied.dossier_id = d.id) AS beoordelings_gebied_identificatie,
	( SELECT dossier_beoordelings_gebied.gebiedsnaam
           FROM imna.dossier_beoordelings_gebied
          WHERE dossier_beoordelings_gebied.dossier_id = d.id) AS beoordelings_gebied_naam,
	( SELECT dossier_beoordelings_gebied.beschrijving
           FROM imna.dossier_beoordelings_gebied
          WHERE dossier_beoordelings_gebied.dossier_id = d.id) AS beoordelings_gebied_beschrijving,
    ( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_desc,
	(SELECT id FROM geoweb.rnn_dossier_upload WHERE rnn_dossier_upload.dossier_id = d.id LIMIT 1) AS upload_id,
    NULL::geometry AS geom
   FROM imna.dossier d;

ALTER TABLE imna.v_rnn_dossier_list
    OWNER TO anlb;

GRANT ALL ON TABLE imna.v_rnn_dossier_list TO anlb;
GRANT SELECT ON TABLE imna.v_rnn_dossier_list TO anlb_sqlpad; */





CREATE OR REPLACE VIEW imna.v_rnn_beoordelingsresultaat_beheertype AS
	SELECT  dbt_rel.dossier_id, 
	dbt.code AS beheertype_code,
    dbt.description AS beheertype_omschrijving,
	 ( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_desc,
		  
    -- overall kwaliteits score
    MAX(kb_tot.description) AS totaal_score,

	-- F&F Oordeel
	MAX(dkb.description::text) FILTER (WHERE dit.code::text = 'FloraEnFauna'::text) AS beoordeling_flora_en_fauna,
    MAX(eo.description::text) FILTER (WHERE dit.code::text = 'FloraEnFauna'::text) AS beoordeling_flora_en_fauna_expert,
    MAX(br.expert_score_uitleg::text) FILTER (WHERE dit.code::text = 'FloraEnFauna'::text) AS flora_en_fauna_expert_uitleg,
	
    -- Standplaatsfactoren Oordeel
    MAX(dkb.description) FILTER (WHERE dit.code = 'Standplaatsfactoren')        AS beoordeling_standplaatsfactoren,
    MAX(eo.description)  FILTER (WHERE dit.code = 'Standplaatsfactoren')        AS beoordeling_standplaatsfactoren_expert,
    MAX(br.expert_score_uitleg)  FILTER (WHERE dit.code = 'Standplaatsfactoren')        AS standplaatsfactoren_expert_uitleg,

	-- StructuurKenmerken Oordeel
    MAX(dkb.description) FILTER (WHERE dit.code = 'Structuurkenmerken')        AS beoordeling_structuur_kenmerken,
    MAX(eo.description)  FILTER (WHERE dit.code = 'Structuurkenmerken')        AS beoordeling_structuur_kenmerken_expert,
    MAX(br.expert_score_uitleg)  FILTER (WHERE dit.code = 'Structuurkenmerken')        AS structuur_kenmerken_expert_uitleg,

	-- Natuurlijkheid Oordeel
    MAX(dkb.description) FILTER (WHERE dit.code = 'Natuurlijkheid')        AS beoordeling_naturlijkheid,
    MAX(eo.description)  FILTER (WHERE dit.code = 'Natuurlijkheid')        AS beoordeling_naturlijkheid_expert,
    MAX(br.expert_score_uitleg)  FILTER (WHERE dit.code = 'Natuurlijkheid')        AS naturlijkheid_expert_uitleg,

	-- Ruimetelijke Condities Oordeel
    MAX(dkb.description) FILTER (WHERE dit.code = 'RuimetelijkeCond')        AS beoordeling_ruimtelijke_condities,
    MAX(eo.description)  FILTER (WHERE dit.code = 'RuimetelijkeCond')        AS beoordeling_ruimtelijke_condities_expert,
    MAX(br.expert_score_uitleg)  FILTER (WHERE dit.code = 'RuimetelijkeCond')        AS ruimtelijke_condities_expert_uitleg,
    
    -- kwalificerende kenmerken StandplaatsFactoren
    MAX(ROUND(tr.waarde, 2)) FILTER (WHERE dkk.code = 'OppHoog')        AS oppervlakte_hoog,
    MAX(ROUND(tr.waarde, 2)) FILTER (WHERE dkk.code = 'OppMidden')        AS oppervlakte_midden,
    MAX(ROUND(tr.waarde, 2)) FILTER (WHERE dkk.code = 'OppLaag')        AS oppervlakte_laag,
    MAX(ROUND(tr.waarde, 2)) FILTER (WHERE dkk.code = 'OppNietBerekend')        AS oppervlakte_niet_berekend,

	-- kwalificerende kenmerken Flora en Fauna
	MAX(ROUND(tr.waarde, 0)) FILTER (WHERE dkk.code::text = 'KwaliSoort'::text) AS kwalificerende_soorten,
    MAX(ROUND(tr.waarde, 0)) FILTER (WHERE dkk.code::text = 'KwaliSoortGroep'::text) AS kwalificerende_groepen,
    MAX(ROUND(tr.waarde, 0)) FILTER (WHERE dkk.code::text = 'Verspreiding'::text) AS verspreiding,
    MAX(ROUND(tr.waarde, 0)) FILTER (WHERE dkk.code::text = 'RodeLijstSoorten'::text) AS rode_lijst_soorten,
	
	NULL::geometry AS geom
    
    FROM imna.dossier_beheer_type dbt_rel
JOIN masterdata.dmn_beheer_type dbt 
    ON dbt.id = dbt_rel.beheer_type_id
JOIN imna.dossier d
	ON d.id = dbt_rel.dossier_id
LEFT JOIN imna.beheer_type_beoordelingsresultaat br
    ON br.dossier_id = dbt_rel.dossier_id
   AND br.beheer_type_id = dbt_rel.beheer_type_id
LEFT JOIN imna.beheer_type_tussenresultaat tr
    ON tr.dossier_id = dbt_rel.dossier_id
   AND tr.beheer_type_id = dbt_rel.beheer_type_id
LEFT JOIN masterdata.dmn_indicator_type dit
    ON dit.id = br.beoordelings_indicator_id
LEFT JOIN masterdata.dmn_kwaliteits_bepaling dkb
    ON dkb.id = br.kwaliteits_score_id
LEFT JOIN masterdata.dmn_kwaliteits_bepaling_expert_oordeel eo
    ON eo.id = br.expert_score_oordeel_id
LEFT JOIN masterdata.dmn_kwaliteits_bepaling kb_tot
    ON kb_tot.id = dbt_rel.kwaliteits_score
LEFT JOIN rnn.kwalificerende_kenmerk kk
    ON kk.id = tr.kwalificerende_kenmerk_id
LEFT JOIN masterdata.dmn_kwalificerende_kenmerk dkk
    ON dkk.id = kk.domain_kwalificerende_kenmerk_id	
GROUP BY 
    dbt_rel.dossier_id, 
    dbt.code,
    dbt.description,
	bronhouder_code,
	bronhouder_desc;


ALTER TABLE imna.v_rnn_beoordelingsresultaat_beheertype
    OWNER TO anlb;

GRANT ALL ON TABLE imna.v_rnn_beoordelingsresultaat_beheertype TO anlb;
GRANT SELECT ON TABLE imna.v_rnn_beoordelingsresultaat_beheertype TO anlb_sqlpad;




CREATE OR REPLACE VIEW imna.v_rnn_beoordelingsresultaat_beheergebied AS
	SELECT odbg.dossier_id,
	dbg.id AS beheergebied_id,
	dbg.identificatie,
	odbg.identificatie AS originele_identificatie, 
	( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_desc,
    dbt.code AS beheertype,
	dbt.description AS beheertype_omschrijving,
	odbg.officieel_beheer_gebied,
	dbg.is_vlak_bijgesneden,
    dkb.description AS standplaatsfactor_beoordeling,
    
   -- kwalificerende kenmerken StandplaatsFactoren
    MAX(ROUND(st.waarde, 2)) FILTER (WHERE dkk.code = 'OppHoog')        AS oppervlakte_hoog,
    MAX(ROUND(st.waarde, 2)) FILTER (WHERE dkk.code = 'OppMidden')        AS oppervlakte_midden,
    MAX(ROUND(st.waarde, 2)) FILTER (WHERE dkk.code = 'OppLaag')        AS oppervlakte_laag,
    MAX(ROUND(st.waarde, 2)) FILTER (WHERE dkk.code = 'OppNietBerekend')        AS oppervlakte_niet_berekend,
	dbg.geom AS geom
FROM imna.dossier_beheer_gebied dbg
JOIN imna.originele_dossier_beheer_gebied odbg 
    ON odbg.id = dbg.originele_beheer_gebied_id
JOIN masterdata.dmn_beheer_type dbt 
    ON dbt.id = odbg.beheer_type_id
JOIN imna.dossier d
	ON d.id = odbg.dossier_id
LEFT JOIN imna.beheer_gebied_standplaats_beoordeling sb
    ON sb.dossier_beheer_gebied_id = dbg.id
LEFT JOIN masterdata.dmn_kwaliteits_bepaling dkb
    ON dkb.id = sb.kwaliteits_score_id
LEFT JOIN imna.beheer_gebied_standplaats_tussenresultaat st
    ON st.dossier_beheer_gebied_id = dbg.id
LEFT JOIN rnn.kwalificerende_kenmerk kk
    ON kk.id = st.kwalificerende_kenmerk_id
LEFT JOIN masterdata.dmn_kwalificerende_kenmerk dkk
    ON dkk.id = kk.domain_kwalificerende_kenmerk_id
GROUP BY 
    odbg.dossier_id,
	dbg.id,
    dbg.identificatie, 
    odbg.identificatie,
	bronhouder_code,
	bronhouder_desc,
	odbg.officieel_beheer_gebied,
	dbg.is_vlak_bijgesneden,
    dbt.code,
    dbt.description,
    dkb.description,
    dbg.geom;

ALTER TABLE imna.v_rnn_beoordelingsresultaat_beheergebied
    OWNER TO anlb;

GRANT ALL ON TABLE imna.v_rnn_beoordelingsresultaat_beheergebied TO anlb;
GRANT SELECT ON TABLE imna.v_rnn_beoordelingsresultaat_beheergebied TO anlb_sqlpad;





CREATE OR REPLACE VIEW imna.v_rnn_beoordelingsresultaat_standplaatsfactoren AS
	SELECT owsf.dossier_id,
	wsf.id,
	wsf.identificatie,
	owsf.identificatie AS originele_identificatie, 
	dbg.identificatie AS beheergebied_identificatie,
	( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = d.dossier_bronhouder_id) AS bronhouder_desc,
	
    dbt.code AS beheertype,
	dbt.description AS beheertype_omschrijving,
	wsf.is_vlak_bijgesneden,
    owsf.gemiddelde_voorjaars_grondwaterstand AS gemiddelde_voorjaarsgrondwaterstand, 
	owsf.gemiddelde_voorjaars_grondwaterstand_opmerking AS gemiddelde_voorjaarsgrondwaterstand_opmerking,
    owsf.gemiddelde_laagste_grondwaterstand AS gemiddelde_laagste_grondwaterstand,
	owsf.gemiddelde_laagste_grondwaterstand_opmerking AS gemiddelde_laagste_grondwaterstand_opmerking,
    owsf.ph AS ph,
	owsf.ph_opmerking AS ph_opmerking,
	owsf.trofie AS trofie,
	owsf.trofie_opmerking AS trofie_opmerking,
    
    -- kwalificerende kenmerken StandplaatsFactoren
    MAX(kbtr.description) FILTER (WHERE dkk.code = 'GVG')        AS gemiddelde_voorjaarsgrondwaterstand_score,
    MAX(kbtr.description) FILTER (WHERE dkk.code = 'GLG')        AS gemiddelde_laagste_grondwaterstand_score,
    MAX(kbtr.description) FILTER (WHERE dkk.code = 'PH')        AS ph_waarde_score,
    MAX(kbtr.description) FILTER (WHERE dkk.code = 'Trofie')        AS trofiegraad_score,
    -- standplaatfactor beoordeling
    kbtb.description        AS standplaatsfactor_beoordeling,
    
    wsf.geom AS geom
FROM imna.waarneming_standplaats_factoren wsf
JOIN imna.originele_waarneming_standplaats_factoren owsf 
    ON owsf.id = wsf.originele_waarneming_standplaats_factoren_id
JOIN imna.dossier d
	ON d.id = owsf.dossier_id
JOIN imna.dossier_beheer_gebied dbg 
    ON dbg.id = wsf.dossier_beheergebied_id
JOIN imna.originele_dossier_beheer_gebied odbg 
    ON odbg.id = dbg.originele_beheer_gebied_id
JOIN masterdata.dmn_beheer_type dbt 
    ON dbt.id = odbg.beheer_type_id
LEFT JOIN imna.waarneming_standplaats_factor_tussenresultaat wsftr
    ON wsftr.waarneming_standplaatsfactoren_id = wsf.id
LEFT JOIN imna.waarneming_standplaats_factoren_beoordeling wsftb
    ON wsftb.waarneming_standplaatsfactoren_id = wsf.id
LEFT JOIN rnn.kwalificerende_kenmerk kk
    ON kk.id = wsftr.kwalificerende_kenmerk_id
LEFT JOIN masterdata.dmn_kwalificerende_kenmerk dkk
    ON dkk.id = kk.domain_kwalificerende_kenmerk_id
JOIN masterdata.dmn_kwaliteits_bepaling kbtr 
    ON kbtr.id = wsftr.kwaliteits_score_id
JOIN masterdata.dmn_kwaliteits_bepaling kbtb 
    ON kbtb.id = wsftb.kwaliteits_score_id
GROUP BY owsf.dossier_id,
	wsf.id,
    owsf.identificatie, 
    wsf.identificatie,
	dbg.identificatie,
	bronhouder_code,
	bronhouder_desc,
    dbt.code, 
    dbt.description,
	wsf.is_vlak_bijgesneden,
    owsf.gemiddelde_voorjaars_grondwaterstand, 
    owsf.gemiddelde_voorjaars_grondwaterstand_opmerking,
    owsf.gemiddelde_laagste_grondwaterstand, 
    owsf.gemiddelde_laagste_grondwaterstand_opmerking,
    owsf.ph, 
    owsf.ph_opmerking, 
    owsf.trofie, 
    owsf.trofie_opmerking,
    kbtb.description,
    wsf.geom;


ALTER TABLE imna.v_rnn_beoordelingsresultaat_standplaatsfactoren
    OWNER TO anlb;

GRANT ALL ON TABLE imna.v_rnn_beoordelingsresultaat_standplaatsfactoren TO anlb;
GRANT SELECT ON TABLE imna.v_rnn_beoordelingsresultaat_standplaatsfactoren TO anlb_sqlpad;
