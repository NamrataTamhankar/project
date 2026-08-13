\echo "Starting deployment of GeoWeb - Habitat creation"


/* GRANT USAGE ON SCHEMA */
GRANT USAGE ON SCHEMA geoweb TO ndvh_geoweb;
;

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.ndvh_habitat_upload
(
	id bigint NOT NULL,
	habitat_package_id bigint NULL,
	bronhouder_id bigint NULL,
	habitat_package_version_id bigint NULL,
	habitat_package_type_id bigint NULL,
	upload_date timestamp NOT NULL,
	user_id varchar(50) NOT NULL,
	contains_errors boolean NOT NULL,
	status varchar(40) NOT NULL
)
;
ALTER TABLE geoweb.ndvh_habitat_upload
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoweb.ndvh_habitat_upload_files
(
	ndvh_habitat_upload_id bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL    -- Will contain the type of file. This can be:  	- Originele FGDB (Original FGDB) 	- Gerepareerde FGDB (Repaired FGDB) 	- Validatie Rapport (Validation Report) 	- Validatie FGDB (Validation FGDB) 	- Verantwoordingsdocument (Accountability Document) 	- Additioneel Document (Additional Document)
)
;
ALTER TABLE geoweb.ndvh_habitat_upload_files
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload','PK_ndvh_habitat_upload',
'ALTER TABLE geoweb.ndvh_habitat_upload ADD CONSTRAINT PK_ndvh_habitat_upload
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_ndvh_habitat_upload_dmn_bronhouder ON geoweb.ndvh_habitat_upload (bronhouder_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_ndvh_habitat_upload_dmn_habitat_package_type ON geoweb.ndvh_habitat_upload (habitat_package_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_ndvh_habitat_upload_dmn_habitat_package_versie ON geoweb.ndvh_habitat_upload (habitat_package_version_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_ndvh_habitat_upload_habitat_package ON geoweb.ndvh_habitat_upload (habitat_package_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload_files','PK_ndvh_habitat_upload_files',
'ALTER TABLE geoweb.ndvh_habitat_upload_files ADD CONSTRAINT PK_ndvh_habitat_upload_files
	PRIMARY KEY (ndvh_habitat_upload_id,sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_ndvh_habitat_upload_files_ndvh_habitat_upload ON geoweb.ndvh_habitat_upload_files (ndvh_habitat_upload_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload','FK_ndvh_habitat_upload_dmn_bronhouder',
'ALTER TABLE geoweb.ndvh_habitat_upload ADD CONSTRAINT FK_ndvh_habitat_upload_dmn_bronhouder
	FOREIGN KEY (bronhouder_id) REFERENCES masterdata.dmn_bronhouder (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload','FK_ndvh_habitat_upload_dmn_habitat_package_type',
'ALTER TABLE geoweb.ndvh_habitat_upload ADD CONSTRAINT FK_ndvh_habitat_upload_dmn_habitat_package_type
	FOREIGN KEY (habitat_package_type_id) REFERENCES masterdata.dmn_habitat_package_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload','FK_ndvh_habitat_upload_dmn_habitat_package_versie',
'ALTER TABLE geoweb.ndvh_habitat_upload ADD CONSTRAINT FK_ndvh_habitat_upload_dmn_habitat_package_versie
	FOREIGN KEY (habitat_package_version_id) REFERENCES masterdata.dmn_habitat_package_versie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload','FK_ndvh_habitat_upload_habitat_package',
'ALTER TABLE geoweb.ndvh_habitat_upload ADD CONSTRAINT FK_ndvh_habitat_upload_habitat_package
	FOREIGN KEY (habitat_package_id) REFERENCES imna.habitat_package (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ndvh_habitat_upload_files','FK_ndvh_habitat_upload_files_ndvh_habitat_upload',
'ALTER TABLE geoweb.ndvh_habitat_upload_files ADD CONSTRAINT FK_ndvh_habitat_upload_files_ndvh_habitat_upload
	FOREIGN KEY (ndvh_habitat_upload_id) REFERENCES geoweb.ndvh_habitat_upload (id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN geoweb.ndvh_habitat_upload_files.file_type
	IS 'Will contain the type of file. This can be:  	- Originele FGDB (Original FGDB) 	- Gerepareerde FGDB (Repaired FGDB) 	- Validatie Rapport (Validation Report) 	- Validatie FGDB (Validation FGDB) 	- Verantwoordingsdocument (Accountability Document) 	- Additioneel Document (Additional Document)'
;

GRANT SELECT, INSERT ON geoweb.ndvh_habitat_upload_files TO ndvh_geoweb;
GRANT SELECT ON geoweb.ndvh_habitat_upload TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad
;