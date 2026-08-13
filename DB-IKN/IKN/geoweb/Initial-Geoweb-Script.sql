\echo "Starting deployment of Geoweb schema for IKN automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS geoweb
    AUTHORIZATION ikn;

GRANT ALL ON SCHEMA geoweb TO ikn;

GRANT USAGE ON SCHEMA geoweb TO ikn_readonly;

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.ikn_upload
(
	id bigint NOT NULL,
	informatie_kaart_aanlevering_id bigint NULL,
	bronhouder_id bigint NOT NULL,
	beleid_naam_id bigint NULL,
	bron_type_id bigint NOT NULL,
	upload_date timestamp NOT NULL,
	user_id varchar(50) NOT NULL,
	contains_errors boolean NOT NULL,
	status varchar(40) NOT NULL,
	type_run varchar(40) NOT NULL
);

ALTER TABLE geoweb.ikn_upload
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoweb.ikn_upload_files
(
	ikn_upload_id bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL    -- Will contain the type of file. This can be:  	- Originele FGDB (Original FGDB) 	- Gerepareerde FGDB (Repaired FGDB) 	- Validatie Rapport (Validation Report) 	- Validatie FGDB (Validation FGDB)
);

ALTER TABLE geoweb.ikn_upload_files
    OWNER to ikn;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload','PK_ikn_upload',
'ALTER TABLE geoweb.ikn_upload ADD CONSTRAINT PK_ikn_upload
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_ikn_upload_dmn_beleid_naam ON geoweb.ikn_upload (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_ikn_upload_dmn_bron_type ON geoweb.ikn_upload (bron_type_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_ikn_upload_dmn_bronhouder ON geoweb.ikn_upload (bronhouder_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_ikn_upload_informatie_kaart_aanlevering ON geoweb.ikn_upload (informatie_kaart_aanlevering_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload_files','PK_ikn_upload_files',
'ALTER TABLE geoweb.ikn_upload_files ADD CONSTRAINT PK_ikn_upload_files
	PRIMARY KEY (ikn_upload_id,sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_ikn_upload_files_ikn_upload ON geoweb.ikn_upload_files (ikn_upload_id ASC);

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload','FK_ikn_upload_dmn_beleid_naam',
'ALTER TABLE geoweb.ikn_upload ADD CONSTRAINT FK_ikn_upload_dmn_beleid_naam
	FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload','FK_ikn_upload_dmn_bron_type',
'ALTER TABLE geoweb.ikn_upload ADD CONSTRAINT FK_ikn_upload_dmn_bron_type
	FOREIGN KEY (bron_type_id) REFERENCES masterdata.dmn_bron_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload','FK_ikn_upload_dmn_bronhouder',
'ALTER TABLE geoweb.ikn_upload ADD CONSTRAINT FK_ikn_upload_dmn_bronhouder
	FOREIGN KEY (bronhouder_id) REFERENCES masterdata.dmn_bronhouder (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload','FK_ikn_upload_informatie_kaart_aanlevering',
'ALTER TABLE geoweb.ikn_upload ADD CONSTRAINT FK_ikn_upload_informatie_kaart_aanlevering
	FOREIGN KEY (informatie_kaart_aanlevering_id) REFERENCES imna.informatie_kaart_aanlevering (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','ikn_upload_files','FK_ikn_upload_files_ikn_upload',
'ALTER TABLE geoweb.ikn_upload_files ADD CONSTRAINT FK_ikn_upload_files_ikn_upload
	FOREIGN KEY (ikn_upload_id) REFERENCES geoweb.ikn_upload (id) ON DELETE No Action ON UPDATE No Action
;');


/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN geoweb.ikn_upload_files.file_type
	IS 'Will contain the type of file. This can be:  	- Originele FGDB (Original FGDB) 	- Gerepareerde FGDB (Repaired FGDB) 	- Validatie Rapport (Validation Report) 	- Validatie FGDB (Validation FGDB)'
;

GRANT SELECT ON ALL TABLES IN SCHEMA etl TO ikn_readonly;