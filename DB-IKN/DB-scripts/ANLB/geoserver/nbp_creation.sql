\echo "Starting deployment of GeoServer - NBP Creation"

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_beheer_gebied
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	beheer_type varchar(20) NULL,
	beheer_type_desc varchar(100) NULL,
	subsidiabel varchar(3) NULL,
	voorzieningenbijdrage varchar(3) NULL,
	toezichtbijdrage varchar(3) NULL,
	bijdrage_vaarland varchar(3) NULL,
	bijdrage_gescheperde_schaapskuddes varchar(3) NULL,
	bijdrage_monitoring varchar(3) NULL,
	openstellings_bijdrage_type varchar(20) NULL,
	openstellings_bijdrage_type_desc varchar(100) NULL,
	indicatieve_verhouding_beheer_type text NULL,
	toegestane_beheer_paketten text NULL,
	niet_subsidiabele_beheer_paketten text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_beheer_gebied
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_beheer_gebied_ambitie
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	status_ehs varchar(20) NULL,
	status_ehs_desc varchar(100) NULL,
	beheer_type varchar(20) NULL,
	beheer_type_desc varchar(100) NULL,
	subsidiabel varchar(3) NULL,
	indicatieve_verhouding_beheer_typen text NULL,
	toegestane_beheer_paketten text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_beheer_gebied_ambitie
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_bijzonder_gebied
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	gebieds_code varchar(20) NULL,
	gebieds_code_desc varchar(100) NULL,
	gebieds_naam varchar(100) NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_bijzonder_gebied
    OWNER to anlb;
	
	
CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_deel_gebied
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	gebieds_naam varchar(100) NULL,
	beschrijving text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_deel_gebied
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_natuur_beheer_plan
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	datum_vaststelling timestamp NULL,
	plan_eigenaar varchar(20) NULL,
	plan_eigenaar_desc varchar(100) NULL,
	plan_verwijzing text NULL,
	beheer_gebied_status varchar(20) NULL,
	beheer_gebied_status_desc varchar(100) NULL,
	beheer_gebied_ambitie_status varchar(20) NULL,
	beheer_gebied_ambitie_status_desc varchar(100) NULL,
	bijzonder_gebied_status varchar(20) NULL,
	bijzonder_gebied_status_desc varchar(100) NULL,
	deel_gebied_status varchar(20) NULL,
	deel_gebied_status_desc varchar(100) NULL,
	zoek_gebied_landschap_status varchar(20) NULL,
	zoek_gebied_landschap_status_desc varchar(100) NULL,
	zoek_gebied_agrarisch_status varchar(20) NULL,
	zoek_gebied_agrarisch_status_desc varchar(100) NULL,
	zoek_gebied_water_status varchar(20) NULL,
	zoek_gebied_water_status_desc varchar(100) NULL,
	zoek_gebied_klimaat_status varchar(20) NULL,
	zoek_gebied_klimaat_status_desc varchar(100) NULL,
	document_link text NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_natuur_beheer_plan
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_zoek_gebied_agrarisch
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	agrarisch_natuur_type varchar(20) NULL,
	agrarisch_natuur_type_desc varchar(100) NULL,
	naam varchar(100) NULL,
	deel_gebied varchar(20) NULL,
	deel_gebied_desc varchar(100) NULL,
	toegestane_beheer_functies text NULL,
	toegestane_beheer_typen text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_agrarisch
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_zoek_gebied_klimaat
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	klimaat_natuur_type varchar(20) NULL,
	klimaat_natuur_type_desc varchar(100) NULL,
	naam varchar(100) NULL,
	deel_gebied varchar(20) NULL,
	deel_gebied_desc varchar(100) NULL,
	toegestane_beheer_functies text NULL,
	toegestane_beheer_typen text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_klimaat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_zoek_gebied_landschap
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	geom geometry NULL,
	toegestane_beheer_typen text NULL,
	niet_subsidiabele_beheer_pakketten text NULL,
	document_link text NULL,
	naam varchar(100) NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_landschap
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.imna_nbp_viewer_zoek_gebied_water
(
	provincie varchar(20) NOT NULL,
	provincie_desc varchar(100) NULL,
	subsidie_jaar integer NOT NULL,
	status varchar(20) NOT NULL,
	status_desc varchar(100) NULL,
	identificatie varchar(100) NOT NULL,
	begin_geldigheid timestamp NOT NULL,
	eind_geldigheid timestamp NULL,
	begin_tijd timestamp NULL,
	eind_tijd timestamp NULL,
	water_natuur_type varchar(20) NULL,
	water_natuur_type_desc varchar(100) NULL,
	naam varchar(100) NULL,
	deel_gebied varchar(20) NULL,
	deel_gebied_desc varchar(100) NULL,
	toegestane_beheer_functies text NULL,
	toegestane_beheer_typen text NULL,
	document_link text NULL,
	geom geometry NULL
)
;

ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_water
    OWNER to anlb;
	
/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_beheer_gebied','PK_imna_nbp_viewer_beheer_gebied',
'ALTER TABLE geoserver.imna_nbp_viewer_beheer_gebied ADD CONSTRAINT PK_imna_nbp_viewer_beheer_gebied
	PRIMARY KEY (provincie,identificatie,begin_geldigheid,subsidie_jaar,status)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_subsidiejaar ON geoserver.imna_nbp_viewer_beheer_gebied (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_status ON geoserver.imna_nbp_viewer_beheer_gebied (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_status_jaar ON geoserver.imna_nbp_viewer_beheer_gebied (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_beheer_gebied_ambitie','PK_imna_nbp_viewer_beheer_gebied_ambitie',
'ALTER TABLE geoserver.imna_nbp_viewer_beheer_gebied_ambitie ADD CONSTRAINT PK_imna_nbp_viewer_beheer_gebied_ambitie
	PRIMARY KEY (provincie,identificatie,begin_geldigheid,subsidie_jaar,status)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_ambitie_subsidiejaar ON geoserver.imna_nbp_viewer_beheer_gebied_ambitie (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_ambitie_status ON geoserver.imna_nbp_viewer_beheer_gebied_ambitie (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_beheer_gebied_ambitie_status_jaar ON geoserver.imna_nbp_viewer_beheer_gebied_ambitie (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_bijzonder_gebied','PK_imna_nbp_viewer_bijzonder_gebied',
'ALTER TABLE geoserver.imna_nbp_viewer_bijzonder_gebied ADD CONSTRAINT PK_imna_nbp_viewer_bijzonder_gebied
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_bijzonder_gebied_subsidiejaar ON geoserver.imna_nbp_viewer_bijzonder_gebied (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_bijzonder_gebied_status ON geoserver.imna_nbp_viewer_bijzonder_gebied (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_bijzonder_gebied_status_jaar ON geoserver.imna_nbp_viewer_bijzonder_gebied (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_deel_gebied','PK_imna_nbp_viewer_deel_gebied',
'ALTER TABLE geoserver.imna_nbp_viewer_deel_gebied ADD CONSTRAINT PK_imna_nbp_viewer_deel_gebied
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_deel_gebied_subsidiejaar ON geoserver.imna_nbp_viewer_deel_gebied (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_deel_gebied_status ON geoserver.imna_nbp_viewer_deel_gebied (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_deel_gebied_status_jaar ON geoserver.imna_nbp_viewer_deel_gebied (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_natuur_beheer_plan','PK_imna_nbp_viewer_natuur_beheer_plan',
'ALTER TABLE geoserver.imna_nbp_viewer_natuur_beheer_plan ADD CONSTRAINT PK_imna_nbp_viewer_natuur_beheer_plan
	PRIMARY KEY (status,identificatie,begin_geldigheid,provincie,subsidie_jaar)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_natuur_beheer_plan_subsidiejaar ON geoserver.imna_nbp_viewer_natuur_beheer_plan (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_natuur_beheer_plan_status ON geoserver.imna_nbp_viewer_natuur_beheer_plan (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_natuur_beheer_plan_status_jaar ON geoserver.imna_nbp_viewer_natuur_beheer_plan (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_zoek_gebied_agrarisch','PK_imna_nbp_viewer_zoek_gebied_agrarisch',
'ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_agrarisch ADD CONSTRAINT PK_imna_nbp_viewer_zoek_gebied_agrarisch
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_agrarisch_subsidiejaar ON geoserver.imna_nbp_viewer_zoek_gebied_agrarisch (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_agrarisch_status ON geoserver.imna_nbp_viewer_zoek_gebied_agrarisch (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_agrarisch_status_jaar ON geoserver.imna_nbp_viewer_zoek_gebied_agrarisch (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_zoek_gebied_klimaat','PK_imna_nbp_viewer_zoek_gebied_klimaat',
'ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_klimaat ADD CONSTRAINT PK_imna_nbp_viewer_zoek_gebied_klimaat
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_klimaat_subsidiejaar ON geoserver.imna_nbp_viewer_zoek_gebied_klimaat (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_klimaat_status ON geoserver.imna_nbp_viewer_zoek_gebied_klimaat (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_klimaat_status_jaar ON geoserver.imna_nbp_viewer_zoek_gebied_klimaat (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_zoek_gebied_landschap','PK_imna_nbp_viewer_zoek_gebied_landschap',
'ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_landschap ADD CONSTRAINT PK_imna_nbp_viewer_zoek_gebied_landschap
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_landschap_subsidiejaar ON geoserver.imna_nbp_viewer_zoek_gebied_landschap (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_landschap_status ON geoserver.imna_nbp_viewer_zoek_gebied_landschap (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_landschap_status_jaar ON geoserver.imna_nbp_viewer_zoek_gebied_landschap (status ASC,subsidie_jaar ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','imna_nbp_viewer_zoek_gebied_water','PK_imna_nbp_viewer_zoek_gebied_water',
'ALTER TABLE geoserver.imna_nbp_viewer_zoek_gebied_water ADD CONSTRAINT PK_imna_nbp_viewer_zoek_gebied_water
	PRIMARY KEY (provincie,subsidie_jaar,status,identificatie,begin_geldigheid)
;');

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_water_subsidiejaar ON geoserver.imna_nbp_viewer_zoek_gebied_water (subsidie_jaar ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_water_status ON geoserver.imna_nbp_viewer_zoek_gebied_water (status ASC)
;

CREATE INDEX IF NOT EXISTS INDX_vwr_zoek_gebied_water_status_jaar ON geoserver.imna_nbp_viewer_zoek_gebied_water (status ASC,subsidie_jaar ASC)
;

/* Create Views */



CREATE OR REPLACE VIEW geoserver.snl_nbp_upload AS
 SELECT snl_nbp_upload.id,
        snl_nbp_upload.natuur_beheer_plan_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_nbp_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
            WHERE dmn_provincie_code.id = snl_nbp_upload.provincie_id) AS provincie_desc,
        ( SELECT dmn_status_plan.code
            FROM masterdata.dmn_status_plan
           WHERE dmn_status_plan.id = snl_nbp_upload.plan_status_id) AS plan_status_code,
        ( SELECT dmn_status_plan.description
            FROM masterdata.dmn_status_plan
            WHERE dmn_status_plan.id = snl_nbp_upload.plan_status_id) AS plan_status_desc,			
		snl_nbp_upload.plan_subsidie_jaar,
        snl_nbp_upload.upload_date,
        snl_nbp_upload.user_id,
		snl_nbp_upload.type_run,
        snl_nbp_upload.status,
		((((( SELECT parameters.value
			   FROM masterdata.parameters
			  WHERE parameters.name::text = 'GeoWebNBPGetFileURL'::text))::text) || snl_nbp_upload.id) || '/'::text) || 
		 ((( SELECT snl_nbp_upload_files.file_name
			   FROM geoweb.snl_nbp_upload_files
			  WHERE snl_nbp_upload_files.file_type::text = 'Bestanden Bundel'::text 
			    AND snl_nbp_upload_files.snl_nbp_upload_id = snl_nbp_upload.id
			  LIMIT 1))::text) AS zipfile_url,		
	    NULL::geometry AS geom
   FROM geoweb.snl_nbp_upload;

ALTER TABLE geoserver.snl_nbp_upload
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_nbp_upload TO anlb_sqlpad;

CREATE OR REPLACE VIEW geoserver.snl_nbp_upload_files AS
 SELECT snl_nbp_upload.id,
        snl_nbp_upload.natuur_beheer_plan_id,
        ( SELECT dmn_provincie_code.code
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_nbp_upload.provincie_id) AS provincie_code,
        ( SELECT dmn_provincie_code.description
            FROM masterdata.dmn_provincie_code
           WHERE dmn_provincie_code.id = snl_nbp_upload.provincie_id) AS provincie_desc,	  
        snl_nbp_upload.upload_date,
        snl_nbp_upload.user_id,
        snl_nbp_upload_files.file_name,
		snl_nbp_upload_files.file_type,
        ((((( SELECT parameters.value
                FROM masterdata.parameters
               WHERE parameters.name::text = 'GeoWebNBPGetFileURL'::text))::text) || snl_nbp_upload.id) || '/'::text) || snl_nbp_upload_files.file_name::text AS file_url,
	     NULL::geometry AS geom
    FROM geoweb.snl_nbp_upload
    JOIN geoweb.snl_nbp_upload_files ON snl_nbp_upload.id = snl_nbp_upload_files.snl_nbp_upload_id;

ALTER TABLE geoserver.snl_nbp_upload_files
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.snl_nbp_upload_files TO anlb_sqlpad;

CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_agrarisch AS 
 SELECT v_zoek_gebied_agrarisch.provincie,
    v_zoek_gebied_agrarisch.status,
    v_zoek_gebied_agrarisch.status_desc,
    v_zoek_gebied_agrarisch.subsidie_jaar,
    v_zoek_gebied_agrarisch.identificatie,
    v_zoek_gebied_agrarisch.naam,
    v_zoek_gebied_agrarisch.agrarisch_natuur_type,
    v_zoek_gebied_agrarisch.deel_gebied_naam,
    v_zoek_gebied_agrarisch.toegestane_beheer_typen,
    v_zoek_gebied_agrarisch.toegestane_beheer_clusters,
    v_zoek_gebied_agrarisch.toegestane_beheer_functies,
    v_zoek_gebied_agrarisch.geometry
   FROM "PNL".v_zoek_gebied_agrarisch
  WHERE ((v_zoek_gebied_agrarisch.status = 2) OR (v_zoek_gebied_agrarisch.status = 3));
;

ALTER TABLE geoserver.snl_nbp_zoek_gebied_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_ambitie_landschap AS 
 SELECT v_zoek_gebied_ambitie_landschap.provincie,
    v_zoek_gebied_ambitie_landschap.status,
    v_zoek_gebied_ambitie_landschap.status_desc,
    v_zoek_gebied_ambitie_landschap.subsidie_jaar,
    v_zoek_gebied_ambitie_landschap.identificatie,
    v_zoek_gebied_ambitie_landschap.naam,
    v_zoek_gebied_ambitie_landschap.toegestane_beheer_typen,
    v_zoek_gebied_ambitie_landschap.geometry
   FROM "PNL".v_zoek_gebied_ambitie_landschap
  WHERE ((v_zoek_gebied_ambitie_landschap.status = 2) OR (v_zoek_gebied_ambitie_landschap.status = 3));
;

ALTER TABLE geoserver.snl_nbp_zoek_gebied_ambitie_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_landschap AS 
 SELECT v_zoek_gebied_landschap.provincie,
    v_zoek_gebied_landschap.status,
    v_zoek_gebied_landschap.status_desc,
    v_zoek_gebied_landschap.subsidie_jaar,
    v_zoek_gebied_landschap.identificatie,
    v_zoek_gebied_landschap.naam,
    v_zoek_gebied_landschap.toegestane_beheer_typen,
    v_zoek_gebied_landschap.niet_subsidiabele_beheer_pakketten,
    v_zoek_gebied_landschap.geometry
   FROM "PNL".v_zoek_gebied_landschap
  WHERE ((v_zoek_gebied_landschap.status = 2) OR (v_zoek_gebied_landschap.status = 3));
;

ALTER TABLE geoserver.snl_nbp_zoek_gebied_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW geoserver.snl_nbp_zoek_gebied_water AS 
 SELECT v_zoek_gebied_water.provincie,
    v_zoek_gebied_water.status,
    v_zoek_gebied_water.status_desc,
    v_zoek_gebied_water.subsidie_jaar,
    v_zoek_gebied_water.identificatie,
    v_zoek_gebied_water.naam,
    v_zoek_gebied_water.water_natuur_type,
    v_zoek_gebied_water.deel_gebied_naam,
    v_zoek_gebied_water.toegestane_beheer_typen,
    v_zoek_gebied_water.toegestane_beheer_clusters,
    v_zoek_gebied_water.toegestane_beheer_functies,
    v_zoek_gebied_water.geometry
   FROM "PNL".v_zoek_gebied_water
  WHERE ((v_zoek_gebied_water.status = 2) OR (v_zoek_gebied_water.status = 3));
  
ALTER TABLE geoserver.snl_nbp_zoek_gebied_water
    OWNER TO anlb;

DROP VIEW IF EXISTS geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current;

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_beheer_gebied_ambitie
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb_sqlpad;  

DROP VIEW IF EXISTS geoserver.v_imna_nbp_viewer_beheer_gebied_current;

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_beheer_gebied_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_beheer_gebied
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_deel_gebied_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_deel_gebied
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current TO anlb_sqlpad;  

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_agrarisch
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current TO anlb_sqlpad;  

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_klimaat
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_water_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_water
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current TO anlb_sqlpad; 

GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;