\echo "Starting deployment of GeoWeb - RNN-2500"



/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.rnn_dossier_upload
(
	id bigint NOT NULL,    -- Same Id as etl id
	dossier_id bigint NULL,    -- Reference to dossier id
	bronhouder_id bigint NULL,    -- Reference to rnn bronhouder
	upload_date timestamp NOT NULL,    -- Date an upload was done
	user_id varchar(50) NOT NULL,    -- Id of the logged in user
	contains_errors boolean NOT NULL,    -- Boolean if the upload contained errors
	status varchar(40) NOT NULL    -- Status of the upload
);


ALTER TABLE geoweb.rnn_dossier_upload
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS geoweb.rnn_dossier_upload_files
(
	rnn_dossier_upload_id bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL
);

ALTER TABLE geoweb.rnn_dossier_upload_files
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','rnn_dossier_upload','PK_rnn_dossier_upload',
'ALTER TABLE geoweb.rnn_dossier_upload ADD CONSTRAINT PK_rnn_dossier_upload
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_rnn_dossier_upload_dmn_bronhouder_rnn ON geoweb.rnn_dossier_upload (bronhouder_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_rnn_dossier_upload_dossier ON geoweb.rnn_dossier_upload (dossier_id ASC);




SELECT pg_temp.create_constraint_if_not_exists ('geoweb','rnn_dossier_upload_files','PK_rnn_dossier_upload_files',
'ALTER TABLE geoweb.rnn_dossier_upload_files ADD CONSTRAINT PK_rnn_dossier_upload_files
	PRIMARY KEY (rnn_dossier_upload_id,sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_rnn_dossier_upload_files_rnn_dossier_upload ON geoweb.rnn_dossier_upload_files (rnn_dossier_upload_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','rnn_dossier_upload','FK_rnn_dossier_upload_dmn_bronhouder_rnn',
'ALTER TABLE geoweb.rnn_dossier_upload ADD CONSTRAINT FK_rnn_dossier_upload_dmn_bronhouder_rnn
	FOREIGN KEY (bronhouder_id) REFERENCES masterdata.dmn_bronhouder_rnn (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('geoweb','rnn_dossier_upload','FK_rnn_dossier_upload_dossier',
'ALTER TABLE geoweb.rnn_dossier_upload ADD CONSTRAINT FK_rnn_dossier_upload_dossier
	FOREIGN KEY (dossier_id) REFERENCES imna.dossier (id) ON DELETE No Action ON UPDATE No Action
;');


SELECT pg_temp.create_constraint_if_not_exists ('geoweb','rnn_dossier_upload_files','FK_rnn_dossier_upload_files_rnn_dossier_upload',
'ALTER TABLE geoweb.rnn_dossier_upload_files ADD CONSTRAINT FK_rnn_dossier_upload_files_rnn_dossier_upload
	FOREIGN KEY (rnn_dossier_upload_id) REFERENCES geoweb.rnn_dossier_upload (id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */


COMMENT ON TABLE geoweb.rnn_dossier_upload
	IS 'Table to store the uploads users have done. In this table there is also a reference to etl_id'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.id
	IS 'Same Id as etl id'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.dossier_id
	IS 'Reference to dossier id'
;


COMMENT ON COLUMN geoweb.rnn_dossier_upload.bronhouder_id
	IS 'Reference to rnn bronhouder'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.upload_date
	IS 'Date an upload was done'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.user_id
	IS 'Id of the logged in user'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.contains_errors
	IS 'Boolean if the upload contained errors'
;

COMMENT ON COLUMN geoweb.rnn_dossier_upload.status
	IS 'Status of the upload'
;

COMMENT ON TABLE geoweb.rnn_dossier_upload_files
	IS 'Files that are related to an upload'
;



GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad;