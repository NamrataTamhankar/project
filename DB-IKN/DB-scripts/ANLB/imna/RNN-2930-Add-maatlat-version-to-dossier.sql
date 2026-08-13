\echo "Deploying RNN-2930 Add column maatlat_versie to table dossier"

ALTER TABLE imna.dossier ADD COLUMN IF NOT EXISTS maatlat_versie varchar(100) NULL;



COMMENT ON COLUMN imna.dossier.maatlat_versie
	IS 'Contains the version of the maatlat which was used during the calculation'
;

-- Drop view that has dependancies to view v_rnn_dossier_list and drop v_rnn_dossier_list view
DROP VIEW IF EXISTS geoserver.rnn_dossier_list;
DROP VIEW IF EXISTS imna.v_rnn_dossier_list;
CREATE OR REPLACE VIEW imna.v_rnn_dossier_list AS
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
	d.maatlat_versie,
	(
		SELECT value 
		FROM masterdata.parameters
		WHERE name = 'RNNBij12MaatlatURL'
	) AS maatlat_url,
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
GRANT SELECT ON TABLE imna.v_rnn_dossier_list TO anlb_sqlpad;
