\echo "Starting deployment of GeoServer - Habitat Creation"

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoserver.ndvh_habitat
(
	identificatie varchar(200) NOT NULL,    -- = habitat_package.identificatie + ' - ' + habitat.identificatie
	n2000 varchar(110) NULL,    -- natura2000.gebied + ' - ' + natura200.naam
	package_bronhouder varchar(100) NULL,    -- habitat_package.package_bronhouder -> dmn_bronhouder.description
	package_versie varchar(20) NOT NULL,    -- habitat_package.package_versie-> dmn_habitat_package_versie.code
	opmerking text NULL,    -- habitat.opmerking
	veldsituatie_datum date NULL,    -- habitat.veldsituatie_datum converted to date
	habitat_types text NULL,    -- query habitat_type_bedekking_t0 ordered by bedekkings_percentage per record write a line with: habitat_type -> dmn_habitat_type.code + '-' + habitat_type ->  dmn_habitat_type.description + ', ' + habitat_type.bedekkings_percentage + '%, ' +  habitat_type.bedekkings_oppervlakte + 'm2, ' + habitat_type ->  dmn_habitat_kwaliteit.description + ';' + linefeed
	kwaliteit varchar(50) NULL,    -- When type <> 100% H0000 and H9999 = habitat_bedekking_kwaliteit -> dmn_kwaliteit.codethen take the lowest When type = 100% H0000 or H9999 = 'U'
	layer_nr integer NOT NULL,    -- nr	layer type 0	Dominant Habitat type group 1	1000 to 1FFF 2	2000 to 2FFF 3	3000 to 3FFF 4	4000 to 4FFF 5	5000 to 5FFF  6	6000 to 6FFF 7	7000 to 7FFF 9	9000 to 9FFF 10	Habitat Quality
	legend_code varchar(20) NULL,    -- Main Habitat type group for layer 0 code	legend 1	Zee- en getijdennatuur 2	Duinen en zandverstuivingen 3	Stilstaande en stromende zoete wateren 4	Vochtige en droge heide 5	Jeneverbesstruweel  6	Graslanden 7	Hoogveen en moeras 9	Bossen 0000	Geen habitattype 9999       Onbekend  For layer 1 to 9 Max percentage Habitat type within the group. Drop the the variant.  For layer 10 Lowest existing quality without H0000/H9999 in order G/M/O If only H0000 or H9999 exists then N
	geo_package_url varchar(1024) NULL,    -- Parameter "GeoWebNDVHGetPublicFileURL" + natura_2000.nummer + '-' + dmn_habitat_package_type.code  '-' +  dmn_habitat_package_versie.code + '.zip'
	verantwoordings_document_url varchar(1024) NULL,    -- habitat_documentatie.document_uri where verantwoordings_document = true
	geom geometry(polygon) NOT NULL,
	gebied_nr integer NOT NULL,    -- reference to N2000 area for quick update of the map
	habitat_id bigint NULL
)
;
ALTER TABLE geoserver.ndvh_habitat
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoserver.ndvh_habitat_package
(
	identificatie varchar(100) NOT NULL,    -- = habitat_package.identificatie
	n2000 varchar(110) NULL,    -- natura2000.nummer+ ' - ' + natura200.naam
	package_bronhouder varchar(100) NULL,    -- habitat_package.package_bronhouder -> dmn_bronhouder.description
	package_versie varchar(20) NULL,    -- habitat_package.package_versie-> dmn_habitat_package_versie.code
	package_naam varchar(100) NULL,    -- habitat_package.package_naam
	toelichting text NULL,    -- habitat_package.toelichting
	geo_package_url varchar(1024) NULL,    -- Parameter "GeoWebNDVHGetPublicFileURL" + natura_2000.nummer + '-' + dmn_habitat_package_type.code  '-' +  dmn_habitat_package_versie.code + '.zip'
	verantwoordings_document_url varchar(1024) NULL,    -- habitat_documentatie.document_uri where verantwoordings_document = true
	geom geometry(polygon) NULL,
	gebied_nr integer NULL,
	package_id bigint NULL
)
;
ALTER TABLE geoserver.ndvh_habitat_package
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','ndvh_habitat','PK_ndvh_habitat',
'ALTER TABLE geoserver.ndvh_habitat ADD CONSTRAINT PK_ndvh_habitat
	PRIMARY KEY (identificatie,layer_nr)
;');

CREATE INDEX IF NOT EXISTS IDX_ndvh_habitat_package_versie ON geoserver.ndvh_habitat (package_versie ASC)
;

CREATE INDEX IF NOT EXISTS IDX_ndvh_habitat_layer_nr ON geoserver.ndvh_habitat (layer_nr ASC)
;

CREATE INDEX IF NOT EXISTS IDX_ndvh_habitat_gebied_nr ON geoserver.ndvh_habitat (gebied_nr ASC)
;

CREATE INDEX IF NOT EXISTS IDX_ndvh_habitat_legend_code ON geoserver.ndvh_habitat (legend_code ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','ndvh_habitat_package','PK_ndvh_habitat_package',
'ALTER TABLE geoserver.ndvh_habitat_package ADD CONSTRAINT PK_ndvh_habitat_package
	PRIMARY KEY (identificatie)
;');

CREATE INDEX IF NOT EXISTS IDX_habitat_package_versie ON geoserver.ndvh_habitat_package (package_versie ASC)
;

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN geoserver.ndvh_habitat.identificatie
	IS '= habitat_package.identificatie + '' - '' + habitat.identificatie'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.n2000
	IS 'natura2000.gebied + '' - '' + natura200.naam'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.package_bronhouder
	IS 'habitat_package.package_bronhouder -> dmn_bronhouder.description'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.package_versie
	IS 'habitat_package.package_versie-> dmn_habitat_package_versie.code'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.opmerking
	IS 'habitat.opmerking'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.veldsituatie_datum
	IS 'habitat.veldsituatie_datum converted to date'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.habitat_types
	IS 'query habitat_type_bedekking_t0 ordered by bedekkings_percentage per record write a line with: habitat_type -> dmn_habitat_type.code + ''-'' + habitat_type ->  dmn_habitat_type.description + '', '' + habitat_type.bedekkings_percentage + ''%, '' +  habitat_type.bedekkings_oppervlakte + ''m2, '' + habitat_type ->  dmn_habitat_kwaliteit.description + '';'' + linefeed'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.kwaliteit
	IS 'When type <> 100% H0000 and H9999 = habitat_bedekking_kwaliteit -> dmn_kwaliteit.codethen take the lowest When type = 100% H0000 or H9999 = ''U'''
;

COMMENT ON COLUMN geoserver.ndvh_habitat.layer_nr
	IS 'nr	layer type 0	Dominant Habitat type group 1	1000 to 1FFF 2	2000 to 2FFF 3	3000 to 3FFF 4	4000 to 4FFF 5	5000 to 5FFF  6	6000 to 6FFF 7	7000 to 7FFF 9	9000 to 9FFF 10	Habitat Quality'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.legend_code
	IS 'Main Habitat type group for layer 0 code	legend 1	Zee- en getijdennatuur 2	Duinen en zandverstuivingen 3	Stilstaande en stromende zoete wateren 4	Vochtige en droge heide 5	Jeneverbesstruweel  6	Graslanden 7	Hoogveen en moeras 9	Bossen 0000	Geen habitattype 9999       Onbekend  For layer 1 to 9 Max percentage Habitat type within the group. Drop the the variant.  For layer 10 Lowest existing quality without H0000/H9999 in order G/M/O If only H0000 or H9999 exists then N'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.geo_package_url
	IS 'Parameter "GeoWebNDVHGetPublicFileURL" + natura_2000.nummer + ''-'' + dmn_habitat_package_type.code  ''-'' +  dmn_habitat_package_versie.code + ''.zip'''
;

COMMENT ON COLUMN geoserver.ndvh_habitat.verantwoordings_document_url
	IS 'habitat_documentatie.document_uri where verantwoordings_document = true'
;

COMMENT ON COLUMN geoserver.ndvh_habitat.gebied_nr
	IS 'reference to N2000 area for quick update of the map'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.identificatie
	IS '= habitat_package.identificatie'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.n2000
	IS 'natura2000.nummer+ '' - '' + natura200.naam'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.package_bronhouder
	IS 'habitat_package.package_bronhouder -> dmn_bronhouder.description'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.package_versie
	IS 'habitat_package.package_versie-> dmn_habitat_package_versie.code'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.package_naam
	IS 'habitat_package.package_naam'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.toelichting
	IS 'habitat_package.toelichting'
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.geo_package_url
	IS 'Parameter "GeoWebNDVHGetPublicFileURL" + natura_2000.nummer + ''-'' + dmn_habitat_package_type.code  ''-'' +  dmn_habitat_package_versie.code + ''.zip'''
;

COMMENT ON COLUMN geoserver.ndvh_habitat_package.verantwoordings_document_url
	IS 'habitat_documentatie.document_uri where verantwoordings_document = true'
;

/* Create Views */

-- DROP VIEW IF EXISTS geoserver.ndvh_habibat_upload CASCADE;

CREATE OR REPLACE VIEW geoserver.ndvh_habibat_upload AS
 SELECT ndvh_habitat_upload.id,
    ndvh_habitat_upload.habitat_package_id,
    ( SELECT dmn_bronhouder.code
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ndvh_habitat_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder.description
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ndvh_habitat_upload.bronhouder_id) AS bronhouder_desc,
    ( SELECT dmn_habitat_package_versie.code
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = ndvh_habitat_upload.habitat_package_version_id) AS package_versie_code,
    ( SELECT dmn_habitat_package_versie.description
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = ndvh_habitat_upload.habitat_package_version_id) AS package_versie_desc,
    ( SELECT dmn_habitat_package_type.code
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = ndvh_habitat_upload.habitat_package_type_id) AS package_type_code,
    ( SELECT dmn_habitat_package_type.description
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = ndvh_habitat_upload.habitat_package_type_id) AS package_type_desc,
    ndvh_habitat_upload.upload_date,
    ndvh_habitat_upload.user_id,
	ndvh_habitat_upload.status,
	((((( SELECT parameters.value
				FROM masterdata.parameters
			   WHERE parameters.name::text = 'GeoWebNDVHGetFileURL'::text))::text) || ndvh_habitat_upload.id) || '/'::text) || 
		  ((( SELECT ndvh_habitat_upload_files.file_name
				FROM geoweb.ndvh_habitat_upload_files
			   WHERE ndvh_habitat_upload_files.file_type::text = 'Bestanden Bundel'::text AND ndvh_habitat_upload_files.ndvh_habitat_upload_id = ndvh_habitat_upload.id
			   LIMIT 1))::text) AS zipfile_url,			 
	NULL::geometry AS geom
   FROM geoweb.ndvh_habitat_upload;

ALTER TABLE geoserver.ndvh_habibat_upload
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habibat_upload TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habibat_upload TO anlb_sqlpad;
;

-- View: geoserver.ndvh_habibat_upload_files

-- DROP VIEW geoserver.ndvh_habibat_upload_files;

CREATE OR REPLACE VIEW geoserver.ndvh_habibat_upload_files AS
 SELECT ndvh_habitat_upload.id,
    ndvh_habitat_upload.habitat_package_id,
    ( SELECT dmn_bronhouder.code
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ndvh_habitat_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder.description
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ndvh_habitat_upload.bronhouder_id) AS bronhouder_desc,
    ( SELECT dmn_habitat_package_versie.code
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = ndvh_habitat_upload.habitat_package_version_id) AS package_versie_code,
    ( SELECT dmn_habitat_package_versie.description
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = ndvh_habitat_upload.habitat_package_version_id) AS package_versie_desc,
    ( SELECT dmn_habitat_package_type.code
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = ndvh_habitat_upload.habitat_package_type_id) AS package_type_code,
    ( SELECT dmn_habitat_package_type.description
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = ndvh_habitat_upload.habitat_package_type_id) AS package_type_desc,
    ndvh_habitat_upload.upload_date,
    ndvh_habitat_upload.user_id,
    ndvh_habitat_upload_files.file_name,
    ndvh_habitat_upload_files.file_type,
    ((((( SELECT parameters.value
           FROM masterdata.parameters
          WHERE parameters.name::text = 'GeoWebNDVHGetFileURL'::text))::text) || ndvh_habitat_upload.id) || '/'::text) || ndvh_habitat_upload_files.file_name::text AS file_url,
	NULL::geometry AS geom
   FROM geoweb.ndvh_habitat_upload
     JOIN geoweb.ndvh_habitat_upload_files ON ndvh_habitat_upload.id = ndvh_habitat_upload_files.ndvh_habitat_upload_id;

ALTER TABLE geoserver.ndvh_habibat_upload_files
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habibat_upload_files TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habibat_upload_files TO anlb_sqlpad;

;

-- View: geoserver.ndvh_habitat_package_list

-- DROP VIEW geoserver.ndvh_habitat_package_list;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_package_list AS
 SELECT ( SELECT natura_2000.nummer
           FROM natura_2000.natura_2000
          WHERE natura_2000.id = p.gebied_id) AS n2000_nr,
    ( SELECT natura_2000.naam
           FROM natura_2000.natura_2000
          WHERE natura_2000.id = p.gebied_id) AS n2000_name,
    p.package_naam,
    p.package_inwinner,
    ( SELECT dmn_habitat_package_versie.code
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = p.package_versie_id) AS package_versie_code,
    ( SELECT dmn_habitat_package_versie.description
           FROM masterdata.dmn_habitat_package_versie
          WHERE dmn_habitat_package_versie.id = p.package_versie_id) AS package_versie_desc,
    ( SELECT dmn_habitat_package_type.code
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = p.package_type_id) AS package_type_code,
    ( SELECT dmn_habitat_package_type.description
           FROM masterdata.dmn_habitat_package_type
          WHERE dmn_habitat_package_type.id = p.package_type_id) AS package_type_desc,
    p.begin_geldigheid,
    p.eind_geldigheid,
    p.ingediend_door,
        CASE
            WHEN p.vast_gesteld = true THEN 'Ja'::text
            WHEN p.vast_gesteld = false THEN 'Nee'::text
            ELSE NULL::text
        END AS vast_gesteld,
    p.vast_gesteld_door,
    p.vast_gesteld_op,
    ( SELECT dmn_package_kwaliteit.code
           FROM masterdata.dmn_package_kwaliteit
          WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id) AS package_kwaliteit_code,
    ( SELECT dmn_package_kwaliteit.description
           FROM masterdata.dmn_package_kwaliteit
          WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id) AS package_kwaliteit_desc,
	p.package_kwaliteit_door,
	p.package_kwaliteit_op,
    p.package_volgnummer,
    ( SELECT dmn_bronhouder.code
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = p.package_bronhouder_id) AS package_bronhouder_code,
    ( SELECT dmn_bronhouder.description
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = p.package_bronhouder_id) AS package_bronhouder_desc,
    ( SELECT natura_2000.begin_geldigheid
           FROM natura_2000.natura_2000
          WHERE natura_2000.id = p.gebied_id) AS n2000_begin_geldigheid,
        CASE
            WHEN (EXISTS ( SELECT 1
               FROM imna.habitat_package v
              WHERE v.gebied_id = p.gebied_id AND v.package_versie_id = p.package_versie_id AND v.vast_gesteld = true AND v.begin_geldigheid < p.begin_geldigheid)) AND p.vast_gesteld = false THEN 'Ja'::text
            ELSE 'Nee'::text
        END AS niewer_dan_vast_gesteld,
        CASE
            WHEN (( SELECT dmn_package_kwaliteit.code
               FROM masterdata.dmn_package_kwaliteit
              WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id)) <> 'N'::bpchar THEN 'Ja'::text
            ELSE 'Nee'::text
        END AS is_beoordeeld,
	(SELECT value FROM masterdata.parameters WHERE name = 'GeoWebNDVHGetCachedFileURL')|| 
	(SELECT natura_2000.nummer FROM natura_2000.natura_2000 WHERE natura_2000.id = p.gebied_id)|| '-' ||
	(SELECT dmn_habitat_package_type.code FROM masterdata.dmn_habitat_package_type WHERE dmn_habitat_package_type.id = p.package_type_id) || '-' ||
	(SELECT dmn_habitat_package_versie.code FROM masterdata.dmn_habitat_package_versie WHERE dmn_habitat_package_versie.id = p.package_versie_id) || '-' ||
	p.package_volgnummer ||
	'.zip' AS geo_package_url,	
	p.id AS habitat_package_id,
	(SELECT id FROM geoweb.ndvh_habitat_upload WHERE ndvh_habitat_upload.habitat_package_id = p.id LIMIT 1) AS upload_id,
    p.package_geometrie AS geom
   FROM imna.habitat_package p;

ALTER TABLE geoserver.ndvh_habitat_package_list
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_package_list TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_package_list TO anlb_sqlpad;
;

-- View: geoserver.ndvh_habitat_package_t0

-- DROP VIEW geoserver.ndvh_habitat_package_t0;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_package_t0 AS
SELECT *
  FROM geoserver.ndvh_habitat_package
 WHERE package_versie = 'T0';
   
ALTER TABLE geoserver.ndvh_habitat_package_t0
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_package_t0 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_package_t0 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_package_t1

-- DROP VIEW geoserver.ndvh_habitat_package_t1;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_package_t1 AS
SELECT *
  FROM geoserver.ndvh_habitat_package
 WHERE package_versie = 'T1';
   
ALTER TABLE geoserver.ndvh_habitat_package_t1
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_package_t1 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_package_t1 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_1000

-- DROP VIEW geoserver.ndvh_habitat_t0_1000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_1000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 1;
   
ALTER TABLE geoserver.ndvh_habitat_t0_1000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_1000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_1000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_2000

-- DROP VIEW geoserver.ndvh_habitat_t0_2000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_2000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 2;
   
ALTER TABLE geoserver.ndvh_habitat_t0_2000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_2000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_2000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_3000

-- DROP VIEW geoserver.ndvh_habitat_t0_3000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_3000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 3;
   
ALTER TABLE geoserver.ndvh_habitat_t0_3000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_3000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_3000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_4000

-- DROP VIEW geoserver.ndvh_habitat_t0_4000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_4000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 4;
   
ALTER TABLE geoserver.ndvh_habitat_t0_4000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_4000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_4000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_5000

-- DROP VIEW geoserver.ndvh_habitat_t0_5000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_5000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 5;
   
ALTER TABLE geoserver.ndvh_habitat_t0_5000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_5000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_5000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_6000

-- DROP VIEW geoserver.ndvh_habitat_t0_6000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_6000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 6;
   
ALTER TABLE geoserver.ndvh_habitat_t0_6000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_6000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_6000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_7000

-- DROP VIEW geoserver.ndvh_habitat_t0_7000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_7000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 7;
   
ALTER TABLE geoserver.ndvh_habitat_t0_7000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_7000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_7000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_9000

-- DROP VIEW geoserver.ndvh_habitat_t0_9000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_9000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 9;
   
ALTER TABLE geoserver.ndvh_habitat_t0_9000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_9000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_9000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_all

-- DROP VIEW geoserver.ndvh_habitat_t0_all;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_all AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 0;
   
ALTER TABLE geoserver.ndvh_habitat_t0_all
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_all TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_all TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t0_kwal

-- DROP VIEW geoserver.ndvh_habitat_t0_kwal;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t0_kwal AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T0'
   AND layer_nr = 10;
   
ALTER TABLE geoserver.ndvh_habitat_t0_kwal
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t0_kwal TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t0_kwal TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_1000

-- DROP VIEW geoserver.ndvh_habitat_t1_1000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_1000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 1;
   
ALTER TABLE geoserver.ndvh_habitat_t1_1000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_1000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_1000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_2000

-- DROP VIEW geoserver.ndvh_habitat_t1_2000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_2000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 2;
   
ALTER TABLE geoserver.ndvh_habitat_t1_2000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_2000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_2000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_3000

-- DROP VIEW geoserver.ndvh_habitat_t1_3000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_3000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 3;
   
ALTER TABLE geoserver.ndvh_habitat_t1_3000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_3000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_3000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_4000

-- DROP VIEW geoserver.ndvh_habitat_t1_4000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_4000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 4;
   
ALTER TABLE geoserver.ndvh_habitat_t1_4000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_4000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_4000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_5000

-- DROP VIEW geoserver.ndvh_habitat_t1_5000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_5000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 5;
   
ALTER TABLE geoserver.ndvh_habitat_t1_5000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_5000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_5000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_6000

-- DROP VIEW geoserver.ndvh_habitat_t1_6000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_6000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 6;
   
ALTER TABLE geoserver.ndvh_habitat_t1_6000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_6000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_6000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_7000

-- DROP VIEW geoserver.ndvh_habitat_t1_7000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_7000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 7;
   
ALTER TABLE geoserver.ndvh_habitat_t1_7000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_7000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_7000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_9000

-- DROP VIEW geoserver.ndvh_habitat_t1_9000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_9000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 9;
   
ALTER TABLE geoserver.ndvh_habitat_t1_9000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_9000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_9000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_all

-- DROP VIEW geoserver.ndvh_habitat_t1_all;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_all AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 0;
   
ALTER TABLE geoserver.ndvh_habitat_t1_all
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_all TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_all TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t1_kwal

-- DROP VIEW geoserver.ndvh_habitat_t1_kwal;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t1_kwal AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T1'
   AND layer_nr = 10;
   
ALTER TABLE geoserver.ndvh_habitat_t1_kwal
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t1_kwal TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t1_kwal TO anlb_sqlpad;   
;
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad
;