\echo "Deploying RNN-2930 Add column maatlat_versie to v_rnn_dossier_list"

DROP VIEW IF EXISTS geoserver.rnn_dossier_list;

CREATE OR REPLACE VIEW geoserver.rnn_dossier_list AS
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
	d.maatlat_versie,
	d.maatlat_url,
    d.geom
   FROM imna.v_rnn_dossier_list d;


ALTER TABLE geoserver.rnn_dossier_list
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_dossier_list TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO rnn_vertigis;