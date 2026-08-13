--DROP VIEW IF EXISTS geoserver.rnn_dossier_list;

/* CREATE OR REPLACE VIEW geoserver.rnn_dossier_list AS
	SELECT d.dossier_id,
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
	d.beoordelings_gebied_identificatie,
	d.beoordelings_gebied_naam,
	d.beoordelings_gebied_beschrijving,
    d.bronhouder_code,
   	d.bronhouder_desc,
	d.upload_id,
    d.geom
   FROM imna.v_rnn_dossier_list d;

ALTER TABLE geoserver.rnn_dossier_list
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_dossier_list TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO rnn_vertigis; */



--DROP VIEW IF EXISTS geoserver.rnn_beoordelingsresultaat_beheer_type;

CREATE OR REPLACE VIEW geoserver.rnn_beoordelingsresultaat_beheer_type AS
	SELECT 
    v.dossier_id, 
    v.beheertype_code,
    v.beheertype_omschrijving,
    v.bronhouder_code,
    v.bronhouder_desc,
    v.totaal_score,
    v.beoordeling_flora_en_fauna AS flora_en_fauna_score,
    v.beoordeling_flora_en_fauna_expert AS flora_en_fauna_expert,
    v.beoordeling_standplaatsfactoren AS standplaatsfactoren,
    v.beoordeling_standplaatsfactoren_expert AS standplaatsfactoren_expert,
    v.beoordeling_structuur_kenmerken AS structuur_kenmerken,
    v.beoordeling_structuur_kenmerken_expert AS structuur_kenmerken_expert,
    v.beoordeling_naturlijkheid AS natuurlijkheid,
  	v.beoordeling_naturlijkheid_expert AS natuurlijkheid_expert,
    v.beoordeling_ruimtelijke_condities AS ruimetelijke_condities,
    v.beoordeling_ruimtelijke_condities_expert AS ruimetelijke_condities_expert,
	v.geom
FROM imna.v_rnn_beoordelingsresultaat_beheertype v;

ALTER TABLE geoserver.rnn_beoordelingsresultaat_beheer_type
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_beoordelingsresultaat_beheer_type TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_beheer_type TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_beheer_type TO rnn_vertigis;





--DROP VIEW IF EXISTS geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype;

CREATE OR REPLACE VIEW geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype
 AS
 SELECT v.dossier_id,
    v.beheertype_code AS beheertype,
    v.beheertype_omschrijving,
    v.bronhouder_code,
    v.bronhouder_desc,
    v.totaal_score AS totaalscore,
    v.beoordeling_flora_en_fauna AS flora_en_fauna,
    v.beoordeling_flora_en_fauna_expert AS flora_en_fauna_expert,
    v.flora_en_fauna_expert_uitleg AS flora_en_fauna_expert_uitleg,
    v.kwalificerende_soorten,
    v.kwalificerende_groepen,
    v.verspreiding,
    v.rode_lijst_soorten,
    v.geom
   FROM imna.v_rnn_beoordelingsresultaat_beheertype v;

ALTER TABLE geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_flora_en_fauna_beheertype TO rnn_vertigis;






--DROP VIEW IF EXISTS geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype;

CREATE OR REPLACE VIEW geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype AS
	SELECT  v.dossier_id, 
	v.beheertype_code AS beheertype,
    v.beheertype_omschrijving,
	v.bronhouder_code,
    v.bronhouder_desc,
    v.totaal_score AS totaalscore,
    v.beoordeling_standplaatsfactoren AS standplaatsfactoren,
    v.beoordeling_standplaatsfactoren_expert AS standplaatsfactoren_expert,
    v.standplaatsfactoren_expert_uitleg AS standplaatsfactoren_expert_uitleg,
    v.oppervlakte_hoog,
    v.oppervlakte_midden,
    v.oppervlakte_laag,
    v.oppervlakte_niet_berekend,
	v.geom
    FROM imna.v_rnn_beoordelingsresultaat_beheertype v;

ALTER TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheertype TO rnn_vertigis;






--DROP VIEW IF EXISTS geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied;

CREATE OR REPLACE VIEW geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied AS
	SELECT v.dossier_id,
	v.identificatie,
	v.originele_identificatie, 
	v.bronhouder_code,
    v.bronhouder_desc,
    v.beheertype,
	v.beheertype_omschrijving,
    v.standplaatsfactor_beoordeling AS beoordeling,
    v.oppervlakte_hoog,
    v.oppervlakte_midden,
    v.oppervlakte_laag,
    v.oppervlakte_niet_berekend,
	v.geom
FROM imna.v_rnn_beoordelingsresultaat_beheergebied v;

ALTER TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren_beheergebied TO rnn_vertigis;







--DROP VIEW IF EXISTS geoserver.rnn_beoordelingsresultaat_standplaatsfactoren;

CREATE OR REPLACE VIEW geoserver.rnn_beoordelingsresultaat_standplaatsfactoren AS
	SELECT v.dossier_id,
	v.identificatie,
	v.originele_identificatie, 
	v.bronhouder_code,
    v.bronhouder_desc,
    v.beheertype,
	v.beheertype_omschrijving,
    v.gemiddelde_voorjaarsgrondwaterstand, 
	v.gemiddelde_voorjaarsgrondwaterstand_opmerking,
    v.gemiddelde_laagste_grondwaterstand,
	v.gemiddelde_laagste_grondwaterstand_opmerking,
    v.ph,
	v.ph_opmerking,
	v.trofie,
	v.trofie_opmerking,
    v.gemiddelde_voorjaarsgrondwaterstand_score,
    v.gemiddelde_laagste_grondwaterstand_score,
    v.ph_waarde_score,
    v.trofiegraad_score,
    v.standplaatsfactor_beoordeling,
    v.geom
FROM imna.v_rnn_beoordelingsresultaat_standplaatsfactoren v;


ALTER TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_beoordelingsresultaat_standplaatsfactoren TO rnn_vertigis;





