\echo "Starting deployment of GeoServer - Bes Creation"

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoserver.imna_bes_beschikking
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	beheer_jaar integer NOT NULL,
	identificatie varchar(50) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid varchar(50) NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	contract_nummer varchar(50) NULL,
	datum_beschikking timestamp NULL,
	status_aanvraag_subsidie varchar(20) NULL,
	status_aanvraag_subsidie_desc varchar(100) NULL,
	type_regeling varchar(20) NULL,
	type_regeling_desc varchar(100) NULL,
	beheer_type varchar(20) NULL,
	beheer_type_desc varchar(100) NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_bes_beschikking
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_bes_beschikking_rapportage
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	beheer_jaar integer NOT NULL,
	identificatie varchar(50) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid varchar(50) NULL
)
;

ALTER TABLE geoserver.imna_bes_beschikking_rapportage
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_bes_beschikking','PK_imna_bes_beschikking',
'ALTER TABLE geoserver.imna_bes_beschikking ADD CONSTRAINT PK_imna_bes_beschikking
	PRIMARY KEY (provincie,beheer_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_bes_beschikking_jaar ON geoserver.imna_bes_beschikking (beheer_jaar ASC)
;

DROP INDEX IF EXISTS "IMNa_bes_beschikking_geom";

CREATE INDEX IF NOT EXISTS INDX_imna_bes_beschikking_geom ON geoserver.imna_bes_beschikking USING gist (geom)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_bes_beschikking_rapportage','PK_imna_bes_beschikking_rapportage',
'ALTER TABLE geoserver.imna_bes_beschikking_rapportage ADD CONSTRAINT PK_imna_bes_beschikking_rapportage
	PRIMARY KEY (provincie,beheer_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_bes_rapportage_jaar ON geoserver.imna_bes_beschikking_rapportage (beheer_jaar ASC)
;

/* Create Views */

CREATE OR REPLACE VIEW geoserver.snl_bes_upload AS
 SELECT snl_bes_upload.id,
        snl_bes_upload.beschikking_rapportage_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_bes_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
            WHERE dmn_provincie_code.id = snl_bes_upload.provincie_id) AS provincie_desc,		
		snl_bes_upload.beschikking_beheer_jaar,
        snl_bes_upload.upload_date,
        snl_bes_upload.user_id,
		snl_bes_upload.type_run,
        snl_bes_upload.status,
		((((( SELECT parameters.value
			   FROM masterdata.parameters
			  WHERE parameters.name::text = 'GeoWebBESGetFileURL'::text))::text) || snl_bes_upload.id) || '/'::text) || 
		 ((( SELECT snl_bes_upload_files.file_name
			   FROM geoweb.snl_bes_upload_files
			  WHERE snl_bes_upload_files.file_type::text = 'Bestanden Bundel'::text 
			    AND snl_bes_upload_files.snl_bes_upload_id = snl_bes_upload.id
			  LIMIT 1))::text) AS zipfile_url,		
	    NULL::geometry AS geom
   FROM geoweb.snl_bes_upload;

ALTER TABLE geoserver.snl_bes_upload
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_bes_upload TO anlb_sqlpad;

CREATE OR REPLACE VIEW geoserver.snl_bes_upload_files AS
 SELECT snl_bes_upload.id,
        snl_bes_upload.beschikking_rapportage_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_bes_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_bes_upload.provincie_id) AS provincie_desc,	  
        snl_bes_upload.upload_date,
        snl_bes_upload.user_id,
        snl_bes_upload_files.file_name,
		snl_bes_upload_files.file_type,
        ((((( SELECT parameters.value
                FROM masterdata.parameters
               WHERE parameters.name::text = 'GeoWebBESGetFileURL'::text))::text) || snl_bes_upload.id) || '/'::text) || snl_bes_upload_files.file_name::text AS file_url,
	     NULL::geometry AS geom
    FROM geoweb.snl_bes_upload
    JOIN geoweb.snl_bes_upload_files ON snl_bes_upload.id = snl_bes_upload_files.snl_bes_upload_id;

ALTER TABLE geoserver.snl_bes_upload_files
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_bes_upload_files TO anlb_sqlpad;
;

CREATE OR REPLACE VIEW geoserver.v_imna_bes_beschikking_current
 AS
 SELECT * FROM geoserver.imna_bes_beschikking
 WHERE beheer_jaar = 2023;

ALTER TABLE geoserver.v_imna_bes_beschikking_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_bes_beschikking_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_bes_beschikking_current TO anlb_sqlpad;  

;

GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;