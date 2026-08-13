\echo "Starting deployment of ETL schema for ANLB automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS etl
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA etl TO anlb;

--GRANT USAGE ON SCHEMA etl TO ;
GRANT USAGE ON SCHEMA etl TO anlb_sqlpad;

/* Create Sequence if not exists */
CREATE SEQUENCE IF NOT EXISTS etl.etl_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE etl.etl_seq
    OWNER TO anlb;

/* Create Tables */

CREATE TABLE IF NOT EXISTS etl.etl_run
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),    -- primary key
	type varchar(50) NOT NULL,    -- the type of run. For instance  	- validate_nbp 	- validate_vrn 	- submit_nbp 	- submit_vrn 	- submit_deposition 	- submit_area_request 	- submit_year_data 	- delete_nbp 	- hide_nbp 	- unhide_nbp
	user_login varchar(100) NULL,    -- user login (according to LDAP) who made the request
	email varchar(100) NULL,    -- user email address (according to LDAP) who made the request
	time_submitted timestamp NULL,
	time_start timestamp NOT NULL,    -- start date/time of the run
	time_end timestamp NULL,    -- end date/time of the run
	status varchar(20) NULL    -- status of the run  	- running 	- completed-errors 	- completed-warnings 	- completed-done 	- failed
)
;

ALTER TABLE etl.etl_run
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.etl_run_files
(
	etl_id bigint NOT NULL,    -- id of the etl run
	sequence bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),
	filename varchar(1024) NOT NULL,    -- name of the file attached for the run
	filetype varchar(100) NOT NULL    -- Denotes the purpose of the file. For instance :  	- FGDB 	- MainPlanDocument 	- Other   etc. 
)
;

ALTER TABLE etl.etl_run_files
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.etl_run_geometries_staging
(
	etl_id bigint NOT NULL,
	layer char(100) NOT NULL,
	identificatie char(100) NOT NULL,
	geom geometry NOT NULL
)
;

ALTER TABLE etl.etl_run_geometries_staging
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.etl_run_log
(
	etl_id bigint NOT NULL,    -- id of the etl run
	sequence bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),
	process varchar(100) NOT NULL,
	log_time timestamp NOT NULL,    -- date / time of the event that is being logged
	log_level varchar(10) NOT NULL,    -- level of the event:  	- info 	- warning 	- error
	log_message text NULL,    -- detail information about the event that is being logged
	database varchar(20) NULL,    -- in case of messages that specify what table has been updated: the relevant database
	schema varchar(20) NULL,
	"table" varchar(1024) NULL,    -- in case of messages that specify what table has been updated: the relevant table
	record_count bigint NULL    -- in case of messages that specify what table has been updated: the amount of records updated
)
;

ALTER TABLE etl.etl_run_log
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.etl_run_params
(
	etl_id bigint NOT NULL,    -- id of the etl run
	sequence bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),
	name varchar(100) NOT NULL,    -- name of the parameter
	value_type varchar(10) NOT NULL,    -- data type of the value of the parameter. can be:  	- char 	- time 	- int 	- bool
	value_char varchar(1024) NULL,    -- char value of the parameter if value_type = char
	value_datetime timestamp NULL,    -- char value of the parameter if value_type = time
	value_int integer NULL,    -- char value of the parameter if value_type = int
	value_bool boolean NULL    -- char value of the parameter if value_type = bool
)
;

ALTER TABLE etl.etl_run_params
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.validation_geometry_issues
(
	etl_id bigint NOT NULL,    -- id of the etl run
	sequence bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),
	identificatie varchar(100) NULL,    -- identification of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	begin_geldigheid timestamp NULL,    -- begin_geldigheid of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	layer varchar(100) NULL,    -- map layer to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	validation_rule varchar(100) NOT NULL,    -- name of the validation rule. This should be a name from a list of rules according to the GLP
	error_code varchar(20) NOT NULL,    -- error code  of the validation. This should be a code from a list of rules according to the GLP
	error_type varchar(10) NOT NULL,    -- level of the error code: values can be  	- info 	- warning 	- error
	error_message text NULL,    -- the error message with its detail description
	corrected boolean NOT NULL,    -- indicates if the validation fault was corrected automatically
	geom geometry NULL    -- geometry of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
)
;

ALTER TABLE etl.validation_geometry_issues
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS etl.validation_results
(
	etl_id bigint NOT NULL,    -- id of the etl run
	sequence bigint NOT NULL   DEFAULT NEXTVAL(('etl_seq'::text)::regclass),
	identificatie varchar(100) NULL,    -- identification of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	begin_geldigheid timestamp NULL,    -- begin_geldigheid of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	layer varchar(100) NULL,    -- map layer to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
	validation_rule varchar(100) NOT NULL,    -- name of the validation rule. This should be a name from a list of rules according to the GLP
	error_code varchar(20) NOT NULL,    -- error code  of the validation. This should be a code from a list of rules according to the GLP
	error_type varchar(10) NOT NULL,    -- level of the error code: values can be  	- info 	- warning 	- error
	error_message text NULL,    -- the error message with its detail description
	corrected boolean NOT NULL,    -- indicates if the validation fault was corrected automatically
	geom geometry NULL    -- geometry of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors 
)
;


ALTER TABLE etl.validation_results
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run','PK_etl_run',
'ALTER TABLE etl.etl_run ADD CONSTRAINT PK_etl_run
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_files','PK_etl_run_files',
'ALTER TABLE etl.etl_run_files ADD CONSTRAINT PK_etl_run_files
	PRIMARY KEY (etl_id, sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_etl_run_files_etl_run ON etl.etl_run_files (etl_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_geometries_staging','PK_etl_run_geometries_staging',
'ALTER TABLE etl.etl_run_geometries_staging ADD CONSTRAINT PK_etl_run_geometries_staging
	PRIMARY KEY (etl_id, layer, identificatie)
;');


CREATE INDEX IF NOT EXISTS IXFK_etl_run_geometries_staging_etl_run ON etl.etl_run_geometries_staging (etl_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_log','PK_etl_run_log',
'ALTER TABLE etl.etl_run_log ADD CONSTRAINT PK_etl_run_log
	PRIMARY KEY (etl_id, sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_etl_run_log_etl_run ON etl.etl_run_log (etl_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_params','PK_etl_run_params',
'ALTER TABLE etl.etl_run_params ADD CONSTRAINT PK_etl_run_params
	PRIMARY KEY (etl_id, sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_etl_run_params_etl_run ON etl.etl_run_params (etl_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('etl','validation_geometry_issues','pk_valdation_geometry_issues',
'ALTER TABLE etl.validation_geometry_issues ADD CONSTRAINT pk_valdation_geometry_issues
	PRIMARY KEY (etl_id, sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_validation_geometry_issues_etl_run ON etl.validation_geometry_issues (etl_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('etl','validation_results','PK_validation_results',
'ALTER TABLE etl.validation_results ADD CONSTRAINT PK_validation_results
	PRIMARY KEY (etl_id, sequence)
;');

CREATE INDEX IF NOT EXISTS IXFK_valdation_results_etl_run ON etl.validation_results (etl_id ASC);

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_files','FK_etl_run_files_etl_run',
'ALTER TABLE etl.etl_run_files ADD CONSTRAINT FK_etl_run_files_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_geometries_staging','FK_etl_run_geometries_staging_etl_run',
'ALTER TABLE etl.etl_run_geometries_staging ADD CONSTRAINT FK_etl_run_geometries_staging_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_log','FK_etl_run_log_etl_run',
'ALTER TABLE etl.etl_run_log ADD CONSTRAINT FK_etl_run_log_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','etl_run_params','FK_etl_run_params_etl_run',
'ALTER TABLE etl.etl_run_params ADD CONSTRAINT FK_etl_run_params_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','validation_geometry_issues','FK_validation_geometry_issues_etl_run',
'ALTER TABLE etl.validation_geometry_issues ADD CONSTRAINT FK_validation_geometry_issues_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('etl','validation_results','FK_valdation_results_etl_run',
'ALTER TABLE etl.validation_results ADD CONSTRAINT FK_valdation_results_etl_run
	FOREIGN KEY (etl_id) REFERENCES etl.etl_run (id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN etl.etl_run.id
	IS 'primary key'
;

COMMENT ON COLUMN etl.etl_run.type
	IS 'the type of run. For instance  	- validate_nbp 	- validate_vrn 	- submit_nbp 	- submit_vrn 	- submit_deposition 	- submit_area_request 	- submit_year_data 	- delete_nbp 	- hide_nbp 	- unhide_nbp'
;

COMMENT ON COLUMN etl.etl_run.user_login
	IS 'user login (according to LDAP) who made the request'
;

COMMENT ON COLUMN etl.etl_run.email
	IS 'user email address (according to LDAP) who made the request'
;

COMMENT ON COLUMN etl.etl_run.time_start
	IS 'start date/time of the run'
;

COMMENT ON COLUMN etl.etl_run.time_end
	IS 'end date/time of the run'
;

COMMENT ON COLUMN etl.etl_run.status
	IS 'status of the run  	- running 	- completed-errors 	- completed-warnings 	- completed-done 	- failed'
;

COMMENT ON COLUMN etl.etl_run_files.etl_id
	IS 'id of the etl run'
;

COMMENT ON COLUMN etl.etl_run_files.filename
	IS 'name of the file attached for the run'
;

COMMENT ON COLUMN etl.etl_run_files.filetype
	IS 'Denotes the purpose of the file. For instance :  	- FGDB 	- MainPlanDocument 	- Other   etc. '
;

COMMENT ON COLUMN etl.etl_run_log.etl_id
	IS 'id of the etl run'
;

COMMENT ON COLUMN etl.etl_run_log.log_time
	IS 'date / time of the event that is being logged'
;

COMMENT ON COLUMN etl.etl_run_log.log_level
	IS 'level of the event:  	- info 	- warning 	- error'
;

COMMENT ON COLUMN etl.etl_run_log.log_message
	IS 'detail information about the event that is being logged'
;

COMMENT ON COLUMN etl.etl_run_log.database
	IS 'in case of messages that specify what table has been updated: the relevant database'
;

COMMENT ON COLUMN etl.etl_run_log."table"
	IS 'in case of messages that specify what table has been updated: the relevant table'
;

COMMENT ON COLUMN etl.etl_run_log.record_count
	IS 'in case of messages that specify what table has been updated: the amount of records updated'
;

COMMENT ON COLUMN etl.etl_run_params.etl_id
	IS 'id of the etl run'
;

COMMENT ON COLUMN etl.etl_run_params.name
	IS 'name of the parameter'
;

COMMENT ON COLUMN etl.etl_run_params.value_type
	IS 'data type of the value of the parameter. can be:  	- char 	- time 	- int 	- bool'
;

COMMENT ON COLUMN etl.etl_run_params.value_char
	IS 'char value of the parameter if value_type = char'
;

COMMENT ON COLUMN etl.etl_run_params.value_datetime
	IS 'char value of the parameter if value_type = time'
;

COMMENT ON COLUMN etl.etl_run_params.value_int
	IS 'char value of the parameter if value_type = int'
;

COMMENT ON COLUMN etl.etl_run_params.value_bool
	IS 'char value of the parameter if value_type = bool'
;

COMMENT ON COLUMN etl.validation_geometry_issues.etl_id
	IS 'id of the etl run'
;

COMMENT ON COLUMN etl.validation_geometry_issues.identificatie
	IS 'identification of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_geometry_issues.begin_geldigheid
	IS 'begin_geldigheid of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_geometry_issues.layer
	IS 'map layer to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_geometry_issues.validation_rule
	IS 'name of the validation rule. This should be a name from a list of rules according to the GLP'
;

COMMENT ON COLUMN etl.validation_geometry_issues.error_code
	IS 'error code  of the validation. This should be a code from a list of rules according to the GLP'
;

COMMENT ON COLUMN etl.validation_geometry_issues.error_type
	IS 'level of the error code: values can be  	- info 	- warning 	- error'
;

COMMENT ON COLUMN etl.validation_geometry_issues.error_message
	IS 'the error message with its detail description'
;

COMMENT ON COLUMN etl.validation_geometry_issues.corrected
	IS 'indicates if the validation fault was corrected automatically'
;

COMMENT ON COLUMN etl.validation_geometry_issues.geom
	IS 'geometry of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_results.etl_id
	IS 'id of the etl run'
;

COMMENT ON COLUMN etl.validation_results.identificatie
	IS 'identification of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_results.begin_geldigheid
	IS 'begin_geldigheid of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_results.layer
	IS 'map layer to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

COMMENT ON COLUMN etl.validation_results.validation_rule
	IS 'name of the validation rule. This should be a name from a list of rules according to the GLP'
;

COMMENT ON COLUMN etl.validation_results.error_code
	IS 'error code  of the validation. This should be a code from a list of rules according to the GLP'
;

COMMENT ON COLUMN etl.validation_results.error_type
	IS 'level of the error code: values can be  	- info 	- warning 	- error'
;

COMMENT ON COLUMN etl.validation_results.error_message
	IS 'the error message with its detail description'
;

COMMENT ON COLUMN etl.validation_results.corrected
	IS 'indicates if the validation fault was corrected automatically'
;

COMMENT ON COLUMN etl.validation_results.geom
	IS 'geometry of the object to which the validation pertains. can be null if the validation message is regarding a generic error like schema / file errors '
;

GRANT SELECT ON ALL TABLES IN SCHEMA etl TO anlb_sqlpad;