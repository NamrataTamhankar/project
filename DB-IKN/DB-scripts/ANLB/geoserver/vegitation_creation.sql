\echo "Starting deployment of GeoServer - Vegitation Creation"

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoserver.ndvh_vegetatie_package
(
	identificatie varchar(100) NOT NULL,
	package_naam text NULL,
	begin_tijd timestamp NULL,
	package_bronhouder varchar(100) NULL,
	geo_package_url varchar(1024) NULL,
	geom geometry(polygon) NOT NULL
)
;
ALTER TABLE geoserver.ndvh_vegetatie_package
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','ndvh_vegetatie_package','PK_ndvh_vegetatie_package',
'ALTER TABLE geoserver.ndvh_vegetatie_package ADD CONSTRAINT PK_ndvh_vegetatie_package
	PRIMARY KEY (identificatie)
;');

/* Create Views */

-- View: geoserver.ndvh_vegetatie_package_list

-- DROP VIEW geoserver.ndvh_vegetatie_package_list;

CREATE OR REPLACE VIEW geoserver.ndvh_vegetatie_package_list AS
 SELECT 
    p.package_naam,
    p.package_inwinner,
	( SELECT dmn_bronhouder_vegetatie.code
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = p.package_bronhouder_id) AS package_bronhouder_code,
    ( SELECT dmn_bronhouder_vegetatie.description
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = p.package_bronhouder_id) AS package_bronhouder_desc,
   ( SELECT dmn_package_kwaliteit.code
           FROM masterdata.dmn_package_kwaliteit
          WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id) AS package_kwaliteit_code,
    ( SELECT dmn_package_kwaliteit.description
           FROM masterdata.dmn_package_kwaliteit
          WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id) AS package_kwaliteit_desc,
    ( SELECT dmn_protocol.code
           FROM masterdata.dmn_protocol
          WHERE dmn_protocol.id = p.vegetatie_karterings_protocol_id) AS protocol_code,
    ( SELECT dmn_protocol.description
           FROM masterdata.dmn_protocol
          WHERE dmn_protocol.id = p.vegetatie_karterings_protocol_id) AS protocol_desc,
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
	p.package_kwaliteit_door,
	p.package_kwaliteit_op,   
         CASE
            WHEN (EXISTS ( SELECT 1
               FROM imna.vegetatie_kartering_package v
              WHERE v.identificatie = p.identificatie AND v.vast_gesteld = true AND v.begin_geldigheid < p.begin_geldigheid)) AND p.vast_gesteld = false THEN 'Ja'::text
            ELSE 'Nee'::text
        END AS niewer_dan_vast_gesteld,
        CASE
            WHEN (( SELECT dmn_package_kwaliteit.code
               FROM masterdata.dmn_package_kwaliteit
              WHERE dmn_package_kwaliteit.id = p.package_kwaliteit_id)) <> 'N'::bpchar THEN 'Ja'::text
            ELSE 'Nee'::text
        END AS is_beoordeeld,
	(SELECT value FROM masterdata.parameters WHERE name = 'GeoWebNDVHVegetatieGetCachedFileURL')|| 
	p.identificatie || '-' || 
	TO_CHAR(p.begin_geldigheid, 'YYYYMMDDHH24MISS') ||
	'.zip' AS geo_package_url,
	p.identificatie,
	p.id AS vegetatie_karterings_package_id,
	(SELECT id FROM geoweb.ndvh_vegetatie_upload WHERE ndvh_vegetatie_upload.vegetatie_kartering_package_id = p.id LIMIT 1) AS upload_id,
    p.package_geometrie AS geom
   FROM imna.vegetatie_kartering_package p;

ALTER TABLE geoserver.ndvh_vegetatie_package_list
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_vegetatie_package_list TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_vegetatie_package_list TO anlb_sqlpad;
;

-- DROP VIEW IF EXISTS geoserver.ndvh_vegetatie_upload CASCADE;

CREATE OR REPLACE VIEW geoserver.ndvh_vegetatie_upload AS
 SELECT ndvh_vegetatie_upload.id,
    ndvh_vegetatie_upload.vegetatie_kartering_package_id,
	 ( SELECT vegetatie_kartering_package.package_naam
           FROM imna.vegetatie_kartering_package
          WHERE vegetatie_kartering_package.id = ndvh_vegetatie_upload.vegetatie_kartering_package_id) AS vegetatie_kartering_package_naam,
    ( SELECT dmn_bronhouder_vegetatie.code
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = ndvh_vegetatie_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_vegetatie.description
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = ndvh_vegetatie_upload.bronhouder_id) AS bronhouder_desc,
    ndvh_vegetatie_upload.upload_date,
    ndvh_vegetatie_upload.user_id,
	ndvh_vegetatie_upload.status,
		((((( SELECT parameters.value
				FROM masterdata.parameters
			   WHERE parameters.name::text = 'GeoWebNDVHVegetatieGetFileURL'::text))::text) || ndvh_vegetatie_upload.id) || '/'::text) || 
		  ((( SELECT ndvh_vegetatie_upload_files.file_name
				FROM geoweb.ndvh_vegetatie_upload_files
			   WHERE ndvh_vegetatie_upload_files.file_type::text = 'Bestanden Bundel'::text AND ndvh_vegetatie_upload_files.ndvh_vegetatie_upload_id = ndvh_vegetatie_upload.id
			   LIMIT 1))::text) AS zipfile_url,		
	NULL::geometry AS geom
   FROM geoweb.ndvh_vegetatie_upload;

ALTER TABLE geoserver.ndvh_vegetatie_upload
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_vegetatie_upload TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_vegetatie_upload TO anlb_sqlpad;
;

-- View: geoserver.ndvh_vegetatie_upload_files

-- DROP VIEW geoserver.ndvh_vegetatie_upload_files;

CREATE OR REPLACE VIEW geoserver.ndvh_vegetatie_upload_files AS
 SELECT ndvh_vegetatie_upload.id,
    ndvh_vegetatie_upload.vegetatie_kartering_package_id,
	 ( SELECT vegetatie_kartering_package.package_naam
           FROM imna.vegetatie_kartering_package
          WHERE vegetatie_kartering_package.id = ndvh_vegetatie_upload.vegetatie_kartering_package_id) AS vegetatie_kartering_package_naam,
    ( SELECT dmn_bronhouder_vegetatie.code
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = ndvh_vegetatie_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder_vegetatie.description
           FROM masterdata.dmn_bronhouder_vegetatie
          WHERE dmn_bronhouder_vegetatie.id = ndvh_vegetatie_upload.bronhouder_id) AS bronhouder_desc,
    ndvh_vegetatie_upload.upload_date,
    ndvh_vegetatie_upload.user_id,
    ndvh_vegetatie_upload_files.file_name,
    ndvh_vegetatie_upload_files.file_type,
    ((((( SELECT parameters.value
           FROM masterdata.parameters
          WHERE parameters.name::text = 'GeoWebNDVHVegetatieGetFileURL'::text))::text) || ndvh_vegetatie_upload.id) || '/'::text) || ndvh_vegetatie_upload_files.file_name::text AS file_url,
	NULL::geometry AS geom
   FROM geoweb.ndvh_vegetatie_upload
     JOIN geoweb.ndvh_vegetatie_upload_files ON ndvh_vegetatie_upload.id = ndvh_vegetatie_upload_files.ndvh_vegetatie_upload_id;

ALTER TABLE geoserver.ndvh_vegetatie_upload_files
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_vegetatie_upload_files TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_vegetatie_upload_files TO anlb_sqlpad;

;
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad
;
