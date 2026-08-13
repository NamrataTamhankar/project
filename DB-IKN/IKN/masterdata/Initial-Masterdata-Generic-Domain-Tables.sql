CREATE TABLE IF NOT EXISTS masterdata.domain_feature
(
	domain char(100) NOT NULL,
	feature char(100) NOT NULL,
	attribute char(100) NOT NULL
);

ALTER TABLE masterdata.domain_feature
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.feature_layer
(
	feature char(100) NOT NULL,
	layer char(100) NOT NULL,
	geo_validation boolean NOT NULL,
	self_overlap_validation boolean NOT NULL,
	multipart_validation boolean NOT NULL,
	date_range_validation boolean NOT NULL,
	identificatie_validation boolean NOT NULL
);

ALTER TABLE masterdata.feature_layer
    OWNER to ikn;
	
	
CREATE TABLE IF NOT EXISTS masterdata.mandatory_attributes
(
	feature char(100) NOT NULL,
	attribute char(100) NOT NULL
);

ALTER TABLE masterdata.mandatory_attributes
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.parameters
(
	name varchar(50) NOT NULL,
	value varchar(1024) NOT NULL
);

ALTER TABLE masterdata.parameters
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.provinces
(
	code char(2) NOT NULL,
	drupal_role char(50) NOT NULL,
	program char(10) NOT NULL,
	name char(50) NOT NULL
);

ALTER TABLE masterdata.provinces
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS masterdata.specific_attribute_types
(
	feature varchar(100) NOT NULL,
	attribute varchar(100) NOT NULL,
	type varchar(20) NOT NULL,
	length bigint NULL
);

ALTER TABLE masterdata.specific_attribute_types
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.translations
(
	nl varchar(255) NOT NULL,
	en varchar(255) NOT NULL
);

ALTER TABLE masterdata.translations
    OWNER to ikn;

/* Create Primary Keys, Indexes, Uniques, Checks */


SELECT pg_temp.create_constraint_if_not_exists ('masterdata','feature_layer','PK_feature_layer',
'ALTER TABLE masterdata.feature_layer ADD CONSTRAINT PK_feature_layer
	PRIMARY KEY (feature,layer)
;');



SELECT pg_temp.create_constraint_if_not_exists ('masterdata','specific_attribute_types','PK_specific_attribute_types',
'ALTER TABLE masterdata.specific_attribute_types ADD CONSTRAINT PK_specific_attribute_types
	PRIMARY KEY (feature,attribute)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','translations','PK_translations',
'ALTER TABLE masterdata.translations ADD CONSTRAINT PK_translations
	PRIMARY KEY (nl)
;');

/* Create Foreign Key Constraints */



SELECT pg_temp.create_constraint_if_not_exists ('masterdata','mandatory_attributes','PK_mandatory_attributes',
'ALTER TABLE masterdata.mandatory_attributes ADD CONSTRAINT PK_mandatory_attributes
	PRIMARY KEY (feature,attribute)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','parameters','PK_parameters',
'ALTER TABLE masterdata.parameters ADD CONSTRAINT PK_parameters
	PRIMARY KEY (name)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','provinces','PK_provinces',
'ALTER TABLE masterdata.provinces ADD CONSTRAINT PK_provinces
	PRIMARY KEY (code,program)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','provinces','UN_provincies_program_role',
'ALTER TABLE masterdata.provinces ADD CONSTRAINT UN_provincies_program_role UNIQUE (program,drupal_role)
;');