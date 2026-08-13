ALTER TABLE etl.etl_run 
	ALTER COLUMN "type" TYPE varchar (50),
	ALTER COLUMN user_login TYPE varchar (100),
	ALTER COLUMN email TYPE varchar (100),
	ALTER COLUMN status TYPE varchar (20);

ALTER TABLE etl.etl_run_params 
	ALTER COLUMN name TYPE varchar (100),
	ALTER COLUMN value_type TYPE varchar (10),
	ALTER COLUMN value_char TYPE varchar (1024);
	
ALTER TABLE etl.etl_run_files 
	ALTER COLUMN filename TYPE varchar (1024),
	ALTER COLUMN filetype TYPE varchar (100);	
	
ALTER TABLE etl.validation_results 
	ALTER COLUMN identificatie TYPE varchar (100),
	ALTER COLUMN layer TYPE varchar (100),
	ALTER COLUMN validation_rule TYPE varchar (100),
	ALTER COLUMN error_code TYPE varchar (20),
	ALTER COLUMN error_type TYPE varchar (10);	

ALTER TABLE etl.etl_run_log 
	ALTER COLUMN process TYPE varchar (100),
	ALTER COLUMN log_level TYPE varchar (10),
	ALTER COLUMN database TYPE varchar (20),
	ALTER COLUMN "schema" TYPE varchar (20),
	ALTER COLUMN "table" TYPE varchar (1024);		
		
	