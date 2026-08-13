\echo "Starting deployment of masterdata - create generic tables"

CREATE TABLE IF NOT EXISTS masterdata.mandatory_attributes
(
	feature char(100) NOT NULL,
	attribute char(100) NOT NULL
)
;

ALTER TABLE masterdata.mandatory_attributes
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.domain_feature
(
	domain char(100) NOT NULL,
	feature char(100) NOT NULL,
	attribute char(100) NOT NULL
)
;

ALTER TABLE masterdata.domain_feature
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.translations
(
	nl varchar(255) NOT NULL,
	en varchar(255) NOT NULL
)
;

ALTER TABLE masterdata.translations
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.parameters
(
	name varchar(50) NOT NULL,
	value varchar(1024) NOT NULL
)
;

ALTER TABLE masterdata.parameters
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.provinces
(
	code char(2) NOT NULL,
	drupal_role char(50) NOT NULL,
	program char(10) NOT NULL,
	name char(50) NOT NULL
)
;

ALTER TABLE masterdata.provinces
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.specific_attribute_types
(
	feature varchar(100) NOT NULL,
	attribute varchar(100) NOT NULL,
	type varchar(20) NOT NULL,
	length bigint NULL,
	format varchar(100) NULL
)
;

ALTER TABLE masterdata.specific_attribute_types
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.link_table_feature
(
	link_table varchar(100) NOT NULL,
	feature varchar(100) NOT NULL,
	attribute_id_1 varchar(100) NOT NULL,
	attribute_id_2 varchar(100) NOT NULL
)
;

ALTER TABLE masterdata.link_table_feature
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.features_overlap
(
	feature1 varchar(100) NOT NULL,
	feature2 varchar(100) NOT NULL,
	must_overlap_or_may_not_overlap boolean NOT NULL    -- when true layers must overlap when false layers may not overlap
)
;

ALTER TABLE masterdata.features_overlap
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS masterdata.feature_layer
(
	feature char(100) NOT NULL,
	layer char(100) NOT NULL,
	geo_validation boolean NOT NULL,
	self_overlap_validation boolean NOT NULL,
	multipart_validation boolean NOT NULL,
	date_range_validation boolean NOT NULL,
	identificatie_validation boolean NOT NULL
)
;

ALTER TABLE masterdata.feature_layer
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','mandatory_attributes','PK_mandatory_attributes',
'ALTER TABLE masterdata.mandatory_attributes ADD CONSTRAINT PK_mandatory_attributes
	PRIMARY KEY (feature,attribute)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','translations','PK_translations',
'ALTER TABLE masterdata.translations ADD CONSTRAINT PK_translations
	PRIMARY KEY (nl)
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

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','specific_attribute_types','PK_specific_attribute_types',
'ALTER TABLE masterdata.specific_attribute_types ADD CONSTRAINT PK_specific_attribute_types
	PRIMARY KEY (feature,attribute)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','features_overlap','PK_features_overlap',
'ALTER TABLE masterdata.features_overlap ADD CONSTRAINT PK_features_overlap
	PRIMARY KEY (feature1,feature2)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','feature_layer','PK_feature_layer',
'ALTER TABLE masterdata.feature_layer ADD CONSTRAINT PK_feature_layer
	PRIMARY KEY (feature,layer)
;');


/* Create Table Comments, Sequences for Autonumber Columns */


COMMENT ON COLUMN masterdata.features_overlap.must_overlap_or_may_not_overlap
	IS 'when true layers must overlap when false layers may not overlap'
;

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;