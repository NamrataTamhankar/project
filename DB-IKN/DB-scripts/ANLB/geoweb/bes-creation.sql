/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.snl_bes_upload
(
	id bigint NOT NULL,
	beschikking_rapportage_id bigint NULL,
	provincie_id bigint NOT NULL,
	beschikking_beheer_jaar integer NULL,
	upload_date timestamp NOT NULL,
	user_id varchar(50) NOT NULL,
	contains_errors boolean NOT NULL,
	type_run varchar(40) NOT NULL,
	status varchar(50) NOT NULL
)
;

ALTER TABLE geoweb.snl_bes_upload
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS geoweb.snl_bes_upload_files
(
	snl_bes_upload_id bigint NOT NULL,
	sequence bigint NOT NULL,
	file_name varchar(1024) NOT NULL,
	file_type varchar(50) NOT NULL
)
;

ALTER TABLE geoweb.snl_bes_upload_files
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','snl_bes_upload','PK_snl_bes_upload',
'ALTER TABLE geoweb.snl_bes_upload ADD CONSTRAINT PK_snl_bes_upload
	PRIMARY KEY (id)
;');

CREATE INDEX IF NOT EXISTS IXFK_snl_bes_upload_dmn_provincie_code ON geoweb.snl_bes_upload (provincie_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_snl_bes_upload_beschikking_rapportage ON geoweb.snl_bes_upload (beschikking_rapportage_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','snl_bes_upload_files','PK_snl_bes_upload_files',
'ALTER TABLE geoweb.snl_bes_upload_files ADD CONSTRAINT PK_snl_bes_upload_files
	PRIMARY KEY (snl_bes_upload_id,sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_snl_bes_upload_files_snl_nbp_upload ON geoweb.snl_bes_upload_files (snl_bes_upload_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','snl_bes_upload','FK_snl_bes_upload_beschikking_rapportage',
'ALTER TABLE geoweb.snl_bes_upload ADD CONSTRAINT FK_snl_bes_upload_beschikking_rapportage
	FOREIGN KEY (beschikking_rapportage_id) REFERENCES imna.beschikking_rapportage (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','snl_bes_upload','FK_snl_bes_upload_dmn_provincie_code',
'ALTER TABLE geoweb.snl_bes_upload ADD CONSTRAINT FK_snl_bes_upload_dmn_provincie_code
	FOREIGN KEY (provincie_id) REFERENCES masterdata.dmn_provincie_code (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','snl_bes_upload_files','FK_snl_bes_upload_files_snl_bes_upload',
'ALTER TABLE geoweb.snl_bes_upload_files ADD CONSTRAINT FK_snl_bes_upload_files_snl_bes_upload
	FOREIGN KEY (snl_bes_upload_id) REFERENCES geoweb.snl_bes_upload (id) ON DELETE No Action ON UPDATE No Action
;');

GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad;
