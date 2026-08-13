\echo "Starting deployment of GeoServer - VRN Creation"

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_gebied_inrichting
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	type_beheerder varchar(20) NULL,
	type_beheerder_desc varchar(100) NULL,
	contract_nummer integer NULL,
	relatie_nummer integer NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_vrn_gebied_inrichting
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_gebied_natuur
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	status_natuur varchar(20) NULL,
	status_natuur_desc varchar(100) NULL,
	type_beheerder varchar(20) NULL,
	type_beheerder_desc varchar(100) NULL,
	eenheid_nummer varchar(100) NULL,
	beheer_pakket varchar(20) NULL,
	beheer_pakket_desc varchar(100) NULL,
	contract_nummer integer NULL,
	relatie_nummer integer NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_vrn_gebied_natuur
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_gebied_verwerving
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	type_eigenaar varchar(20) NULL,
	type_eigenaar_desc varchar(100) NULL,
	contract_nummer integer NULL,
	relatie_nummer integer NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_vrn_gebied_verwerving
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_natuur_netwerk_nederland
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_vrn_natuur_netwerk_nederland
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_resterende_inrichtings_ambitie
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	resterende_inrichtings_ambitie integer NOT NULL
)
;

ALTER TABLE geoserver.imna_vrn_resterende_inrichtings_ambitie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_vrn_voortgangs_rapportage
(
	bron_houder varchar(20) NOT NULL,
	bron_houder_desc varchar(100) NULL,
	rapportage_jaar integer NOT NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NULL,
	eind_geldigheid timestamp NULL,
	opmerkingen text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_vrn_voortgangs_rapportage
    OWNER to anlb;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_gebied_inrichting','PK_imna_vrn_gebied_inrichting',
'ALTER TABLE geoserver.imna_vrn_gebied_inrichting ADD CONSTRAINT PK_imna_vrn_gebied_inrichting
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_vrn_inrichting_jaar ON geoserver.imna_vrn_gebied_inrichting (rapportage_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_gebied_natuur','PK_imna_vrn_gebied_natuur',
'ALTER TABLE geoserver.imna_vrn_gebied_natuur ADD CONSTRAINT PK_imna_vrn_gebied_natuur
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_vrn_natuur_jaar ON geoserver.imna_vrn_gebied_natuur (rapportage_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_gebied_verwerving','PK_imna_vrn_gebied_verwerving',
'ALTER TABLE geoserver.imna_vrn_gebied_verwerving ADD CONSTRAINT PK_imna_vrn_gebied_verwerving
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_iman_vrn_verwerving_jaar ON geoserver.imna_vrn_gebied_verwerving (rapportage_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_natuur_netwerk_nederland','PK_imna_vrn_natuur_netwerk_nederland',
'ALTER TABLE geoserver.imna_vrn_natuur_netwerk_nederland ADD CONSTRAINT PK_imna_vrn_natuur_netwerk_nederland
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_vrn_nnn_jaar ON geoserver.imna_vrn_natuur_netwerk_nederland (rapportage_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_resterende_inrichtings_ambitie','PK_imna_vrn_resterende_inrichtings_ambitie',
'ALTER TABLE geoserver.imna_vrn_resterende_inrichtings_ambitie ADD CONSTRAINT PK_imna_vrn_resterende_inrichtings_ambitie
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_vrn_rest_jaar ON geoserver.imna_vrn_resterende_inrichtings_ambitie (rapportage_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_vrn_voortgangs_rapportage','PK_imna_vrn_voortgangs_rapportage',
'ALTER TABLE geoserver.imna_vrn_voortgangs_rapportage ADD CONSTRAINT PK_imna_vrn_voortgangs_rapportage
	PRIMARY KEY (bron_houder,rapportage_jaar,identificatie)
;');

CREATE INDEX IF NOT EXISTS INDX_imna_vrn_voortgangs_rapportage_jaar ON geoserver.imna_vrn_voortgangs_rapportage (rapportage_jaar ASC)
;

/* Create Views */


CREATE OR REPLACE VIEW geoserver.snl_vrn_upload AS
 SELECT snl_vrn_upload.id,
        snl_vrn_upload.voortgangs_rapportage_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_vrn_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
            WHERE dmn_provincie_code.id = snl_vrn_upload.provincie_id) AS provincie_desc,		
		snl_vrn_upload.voortgangs_rapportage_jaar,
        snl_vrn_upload.upload_date,
        snl_vrn_upload.user_id,
		snl_vrn_upload.type_run,
        snl_vrn_upload.status,
		((((( SELECT parameters.value
			   FROM masterdata.parameters
			  WHERE parameters.name::text = 'GeoWebVRNGetFileURL'::text))::text) || snl_vrn_upload.id) || '/'::text) || 
		 ((( SELECT snl_vrn_upload_files.file_name
			   FROM geoweb.snl_vrn_upload_files
			  WHERE snl_vrn_upload_files.file_type::text = 'Bestanden Bundel'::text 
			    AND snl_vrn_upload_files.snl_vrn_upload_id = snl_vrn_upload.id
			  LIMIT 1))::text) AS zipfile_url,	
	    NULL::geometry AS geom
   FROM geoweb.snl_vrn_upload;

ALTER TABLE geoserver.snl_vrn_upload
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_vrn_upload TO anlb_sqlpad;

CREATE OR REPLACE VIEW geoserver.snl_vrn_upload_files AS
 SELECT snl_vrn_upload.id,
        snl_vrn_upload.voortgangs_rapportage_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_vrn_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_vrn_upload.provincie_id) AS provincie_desc,	  
        snl_vrn_upload.upload_date,
        snl_vrn_upload.user_id,
        snl_vrn_upload_files.file_name,
		snl_vrn_upload_files.file_type,
        ((((( SELECT parameters.value
                FROM masterdata.parameters
               WHERE parameters.name::text = 'GeoWebVRNGetFileURL'::text))::text) || snl_vrn_upload.id) || '/'::text) || snl_vrn_upload_files.file_name::text AS file_url,
	     NULL::geometry AS geom
    FROM geoweb.snl_vrn_upload
    JOIN geoweb.snl_vrn_upload_files ON snl_vrn_upload.id = snl_vrn_upload_files.snl_vrn_upload_id;

ALTER TABLE geoserver.snl_vrn_upload_files
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_vrn_upload_files TO anlb_sqlpad;

CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_inrichting_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_inrichting
 WHERE rapportage_jaar = 2021;

ALTER TABLE geoserver.v_imna_vrn_gebied_inrichting_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_inrichting_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_inrichting_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_natuur_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_natuur
 WHERE rapportage_jaar = 2021;

ALTER TABLE geoserver.v_imna_vrn_gebied_natuur_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_natuur_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_natuur_current TO anlb_sqlpad; 


CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_verwerving_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_verwerving
 WHERE rapportage_jaar = 2021;

ALTER TABLE geoserver.v_imna_vrn_gebied_verwerving_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_verwerving_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_verwerving_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_vrn_natuur_netwerk_nederland_current
 AS
 SELECT * FROM geoserver.imna_vrn_natuur_netwerk_nederland
 WHERE rapportage_jaar = 2021;

ALTER TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current TO anlb_sqlpad; 

GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;