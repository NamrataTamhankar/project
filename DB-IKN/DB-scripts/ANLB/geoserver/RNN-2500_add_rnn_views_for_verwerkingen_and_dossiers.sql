\echo "RNN-2500 Adding views for VertiGIS for Verwerkingsrapportage and dossiers"

-- View: geoserver.rnn_dossier_list

-- DROP VIEW geoserver.rnn_dossier_list;

CREATE OR REPLACE VIEW geoserver.rnn_dossier_list AS
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

ALTER TABLE geoserver.rnn_dossier_list
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_dossier_list TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_dossier_list TO rnn_vertigis;


DROP VIEW IF EXISTS geoserver.rnn_dossier_upload CASCADE;

CREATE OR REPLACE VIEW geoserver.rnn_dossier_upload AS
 SELECT rnn_dossier_upload.id,
    rnn_dossier_upload.dossier_id,
    ( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = rnn_dossier_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = rnn_dossier_upload.bronhouder_id) AS bronhouder_desc,
    rnn_dossier_upload.upload_date,
    rnn_dossier_upload.user_id,
	rnn_dossier_upload.contains_errors,
	rnn_dossier_upload.status,
	((((( SELECT parameters.value
				FROM masterdata.parameters
			   WHERE parameters.name::text = 'VertiGISRNNGetFileURL'::text))::text) || rnn_dossier_upload.id) || '/'::text) || 
		  ((( SELECT rnn_dossier_upload_files.file_name
				FROM geoweb.rnn_dossier_upload_files
			   WHERE rnn_dossier_upload_files.file_type::text = 'Bestanden Bundel'::text AND rnn_dossier_upload_files.rnn_dossier_upload_id = rnn_dossier_upload.id
			   LIMIT 1))::text) AS zipfile_url,			 
	NULL::geometry AS geom
   FROM geoweb.rnn_dossier_upload;

ALTER TABLE geoserver.rnn_dossier_upload
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_dossier_upload TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_dossier_upload TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_dossier_upload TO rnn_vertigis;



-- View: geoserver.rnn_dossier_upload_files

-- DROP VIEW geoserver.rnn_dossier_upload_files;

CREATE OR REPLACE VIEW geoserver.rnn_dossier_upload_files AS
 SELECT rnn_dossier_upload.id,
    rnn_dossier_upload.dossier_id,
    ( SELECT dmn_bronhouder_rnn.code
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = rnn_dossier_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_rnn.description
           FROM masterdata.dmn_bronhouder_rnn
          WHERE dmn_bronhouder_rnn.id = rnn_dossier_upload.bronhouder_id) AS bronhouder_desc,
    rnn_dossier_upload.upload_date,
    rnn_dossier_upload.user_id,
    rnn_dossier_upload_files.file_name,
    rnn_dossier_upload_files.file_type,
    ((((( SELECT parameters.value
           FROM masterdata.parameters
          WHERE parameters.name::text = 'VertiGISRNNGetFileURL'::text))::text) || rnn_dossier_upload.id) || '/'::text) || rnn_dossier_upload_files.file_name::text AS file_url,
	NULL::geometry AS geom
   FROM geoweb.rnn_dossier_upload
     JOIN geoweb.rnn_dossier_upload_files ON rnn_dossier_upload.id = rnn_dossier_upload_files.rnn_dossier_upload_id;

ALTER TABLE geoserver.rnn_dossier_upload_files
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.rnn_dossier_upload_files TO anlb;
GRANT SELECT ON TABLE geoserver.rnn_dossier_upload_files TO anlb_sqlpad;
GRANT SELECT ON TABLE geoserver.rnn_dossier_upload_files TO rnn_vertigis;
