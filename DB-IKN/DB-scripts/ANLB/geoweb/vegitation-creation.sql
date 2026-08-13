\echo "Starting deployment of GeoWeb - Vegitation creation"


/* GRANT USAGE ON SCHEMA */
GRANT USAGE ON SCHEMA geoweb TO ndvh_geoweb;
;

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.ndvh_vegetatie_upload
(
	id bigint NOT NULL,
	vegetatie_kartering_package_id bigint NULL,
	bronhouder_id bigint NULL,
	upload_date timestamp NOT NULL,
	user_id varchar(50) NOT NULL,
	contains_errors boolean NOT NULL,
	status varchar(40) NOT NULL
)
;
ALTER TABLE geoweb.ndvh_vegetatie_upload
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoweb.ndvh_vegetatie_upload_files
(
	ndvh_vegetatie_upload_id bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL
)
;
ALTER TABLE geoweb.ndvh_vegetatie_upload_files
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_vegetatie_upload','PK_ndvh_vegetatie_upload',
'ALTER TABLE geoweb.ndvh_vegetatie_upload ADD CONSTRAINT PK_ndvh_vegetatie_upload
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_ndvh_vegetatie_upload_dmn_bronhouder_vegetatie ON geoweb.ndvh_vegetatie_upload (bronhouder_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_ndvh_vegetatie_upload_vegetatie_kartering_package ON geoweb.ndvh_vegetatie_upload (vegetatie_kartering_package_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_vegetatie_upload_files','PK_ndvh_vegetatie_upload_files',
'ALTER TABLE geoweb.ndvh_vegetatie_upload_files ADD CONSTRAINT PK_ndvh_vegetatie_upload_files
	PRIMARY KEY (ndvh_vegetatie_upload_id,sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_ndvh_vegetatie_upload_files_ndvh_vegetatie_upload ON geoweb.ndvh_vegetatie_upload_files (ndvh_vegetatie_upload_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_vegetatie_upload','FK_ndvh_vegetatie_upload_dmn_bronhouder_vegetatie',
'ALTER TABLE geoweb.ndvh_vegetatie_upload ADD CONSTRAINT FK_ndvh_vegetatie_upload_dmn_bronhouder_vegetatie
	FOREIGN KEY (bronhouder_id) REFERENCES masterdata.dmn_bronhouder_vegetatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_vegetatie_upload','FK_ndvh_vegetatie_upload_vegetatie_kartering_package',
'ALTER TABLE geoweb.ndvh_vegetatie_upload ADD CONSTRAINT FK_ndvh_vegetatie_upload_vegetatie_kartering_package
	FOREIGN KEY (vegetatie_kartering_package_id) REFERENCES imna.vegetatie_kartering_package (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_vegetatie_upload_files','FK_ndvh_vegetatie_upload_files_ndvh_vegetatie_upload',
'ALTER TABLE geoweb.ndvh_vegetatie_upload_files ADD CONSTRAINT FK_ndvh_vegetatie_upload_files_ndvh_vegetatie_upload
	FOREIGN KEY (ndvh_vegetatie_upload_id) REFERENCES geoweb.ndvh_vegetatie_upload (id) ON DELETE No Action ON UPDATE No Action
;');

GRANT SELECT ON geoweb.ndvh_vegetatie_upload TO ndvh_geoweb;
GRANT SELECT, INSERT ON geoweb.ndvh_vegetatie_upload_files TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad
;