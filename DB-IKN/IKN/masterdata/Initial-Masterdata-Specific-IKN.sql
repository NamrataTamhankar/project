/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.bron_specificatie
(
	beleid_naam_id bigint NOT NULL,    -- De aanduiding van het natuurbeleid in de informatiekaart natuur
	bronhouder_id bigint NOT NULL,    -- De overheidsorganisatie die het beleid heeft opgesteld
	bron_type_id bigint NOT NULL,    -- Source can be  	- WFS 	- FGDB 	- Other
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.bron_specificatie
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS masterdata.bron_specificatie_wfs
(
	beleid_naam_id bigint NOT NULL,    -- De aanduiding van het natuurbeleid in de informatiekaart natuur
	bronhouder_id bigint NOT NULL,    -- De overheidsorganisatie die het beleid heeft opgesteld
	metadata_url varchar(1024) NOT NULL,    -- The URL to the xml containing the metadata of this dataset as specified in v2.1.0 of the Dutch profile on the ISO 19115.
	wfs_end_point varchar(255) NOT NULL,    -- Link to the WFS endpoint where the source data can be harvested.
	feature_type varchar(255) NOT NULL,    -- The featuere type of the dataset in the WFS endpoint where the source data can be harvested.
	laatste_revisie timestamp NOT NULL,    -- Latest revision of the dataset that was processed into IKN
	changed_by_user boolean NOT NULL   DEFAULT false,    -- Indicates if the user manually changed the WFS specification.
	active boolean NOT NULL   DEFAULT false    -- indicates if this specific WFS source is currently active and data should be loaded from it
	--last_time_processed_with_error timestamp NULL    -- Indicates the last time the wfs data (fetching the data from the wfs and reading the metadata went fine) was processed incorrectly
);

ALTER TABLE masterdata.bron_specificatie_wfs
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.layer_metadata
(
	layer varchar(100) NOT NULL,
	metadata_id uuid NOT NULL,
	metadata_file varchar(1024) NOT NULL,
	domain_id bigint NULL
);

ALTER TABLE masterdata.layer_metadata
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS masterdata.beleid_naam_type
(
	beleid_naam_id bigint NOT NULL,    -- De aanduiding van het natuurbeleid in de informatiekaart natuur
	beleid_type_id bigint NOT NULL    -- De indeling in type natuurbeleid volgens de typering uit de codelijst beleidType
);

ALTER TABLE masterdata.beleid_naam_type
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_classificatie_1
(
	beleid_naam_id bigint NOT NULL,
	classificatie_1_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.lnk_table_classificatie_1
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_classificatie_2
(
	beleid_naam_id bigint NOT NULL,
	classificatie_2_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.lnk_table_classificatie_2
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS masterdata.lnk_table_classificatie_3
(
	beleid_naam_id bigint NOT NULL,
	classificatie_3_id bigint NOT NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
);

ALTER TABLE masterdata.lnk_table_classificatie_3
    OWNER to ikn;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','layer_metadata','PK_layer_metadata',
'ALTER TABLE masterdata.layer_metadata ADD CONSTRAINT PK_layer_metadata
	PRIMARY KEY (layer)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_1','PK_lnk_table_classificatie_1',
'ALTER TABLE masterdata.lnk_table_classificatie_1 ADD CONSTRAINT PK_lnk_table_classificatie_1
	PRIMARY KEY (beleid_naam_id,classificatie_1_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_1_dmn_beleid_naam ON masterdata.lnk_table_classificatie_1 (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_1_dmn_classificatie ON masterdata.lnk_table_classificatie_1 (classificatie_1_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_2','PK_lnk_table_classificatie_2',
'ALTER TABLE masterdata.lnk_table_classificatie_2 ADD CONSTRAINT PK_lnk_table_classificatie_2
	PRIMARY KEY (beleid_naam_id,classificatie_2_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_2_dmn_beleid_naam ON masterdata.lnk_table_classificatie_2 (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_2_dmn_classificatie ON masterdata.lnk_table_classificatie_2 (classificatie_2_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_3','PK_lnk_table_classificatie_3',
'ALTER TABLE masterdata.lnk_table_classificatie_3 ADD CONSTRAINT PK_lnk_table_classificatie_3
	PRIMARY KEY (beleid_naam_id,classificatie_3_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_3_dmn_beleid_naam ON masterdata.lnk_table_classificatie_3 (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_lnk_table_classificatie_3_dmn_classificatie ON masterdata.lnk_table_classificatie_3 (classificatie_3_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','beleid_naam_type','PK_beleid_naam_type',
'ALTER TABLE masterdata.beleid_naam_type ADD CONSTRAINT PK_beleid_naam_type
	PRIMARY KEY (beleid_naam_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_beleid_naam_type_dmn_beleid_naam ON masterdata.beleid_naam_type (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_beleid_naam_type_dmn_beleid_type ON masterdata.beleid_naam_type (beleid_type_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie','PK_bron_specificatie',
'ALTER TABLE masterdata.bron_specificatie ADD CONSTRAINT PK_bron_specificatie
	PRIMARY KEY (beleid_naam_id,bronhouder_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_bron_specificatie_dmn_beleid_naam ON masterdata.bron_specificatie (beleid_naam_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_bron_specificatie_dmn_bron_type ON masterdata.bron_specificatie (bron_type_id ASC);

CREATE INDEX IF NOT EXISTS IXFK_bron_specificatie_dmn_bronhouder ON masterdata.bron_specificatie (bronhouder_id ASC);

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie_wfs','PK_bron_specificatie_wfs',
'ALTER TABLE masterdata.bron_specificatie_wfs ADD CONSTRAINT PK_bron_specificatie_wfs
	PRIMARY KEY (beleid_naam_id,bronhouder_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_bron_specificatie_wfs_bron_specificatie ON masterdata.bron_specificatie_wfs (beleid_naam_id ASC,bronhouder_id ASC);


/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_1','FK_lnk_table_classificatie_1_dmn_beleid_naam',
'ALTER TABLE masterdata.lnk_table_classificatie_1 ADD CONSTRAINT FK_lnk_table_classificatie_1_dmn_beleid_naam
FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_1','FK_lnk_table_classificatie_1_dmn_classificatie',
'ALTER TABLE masterdata.lnk_table_classificatie_1 ADD CONSTRAINT FK_lnk_table_classificatie_1_dmn_classificatie
FOREIGN KEY (classificatie_1_id) REFERENCES masterdata.dmn_classificatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_2','FK_lnk_table_classificatie_2_dmn_beleid_naam',
'ALTER TABLE masterdata.lnk_table_classificatie_2 ADD CONSTRAINT FK_lnk_table_classificatie_2_dmn_beleid_naam
FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_2','FK_lnk_table_classificatie_2_dmn_classificatie',
'ALTER TABLE masterdata.lnk_table_classificatie_2 ADD CONSTRAINT FK_lnk_table_classificatie_2_dmn_classificatie
FOREIGN KEY (classificatie_2_id) REFERENCES masterdata.dmn_classificatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_3','FK_lnk_table_classificatie_3_dmn_beleid_naam',
'ALTER TABLE masterdata.lnk_table_classificatie_3 ADD CONSTRAINT FK_lnk_table_classificatie_3_dmn_beleid_naam
FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','lnk_table_classificatie_3','FK_lnk_table_classificatie_3_dmn_classificatie',
'ALTER TABLE masterdata.lnk_table_classificatie_3 ADD CONSTRAINT FK_lnk_table_classificatie_3_dmn_classificatie
FOREIGN KEY (classificatie_3_id) REFERENCES masterdata.dmn_classificatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','beleid_naam_type','FK_beleid_naam_type_dmn_beleid_naam',
'ALTER TABLE masterdata.beleid_naam_type ADD CONSTRAINT FK_beleid_naam_type_dmn_beleid_naam
FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','beleid_naam_type','FK_beleid_naam_type_dmn_beleid_type',
'ALTER TABLE masterdata.beleid_naam_type ADD CONSTRAINT FK_beleid_naam_type_dmn_beleid_type
FOREIGN KEY (beleid_type_id) REFERENCES masterdata.dmn_beleid_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie','FK_bron_specificatie_dmn_beleid_naam',
'ALTER TABLE masterdata.bron_specificatie ADD CONSTRAINT FK_bron_specificatie_dmn_beleid_naam
FOREIGN KEY (beleid_naam_id) REFERENCES masterdata.dmn_beleid_naam (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie','FK_bron_specificatie_dmn_bron_type',
'ALTER TABLE masterdata.bron_specificatie ADD CONSTRAINT FK_bron_specificatie_dmn_bron_type
FOREIGN KEY (bron_type_id) REFERENCES masterdata.dmn_bron_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie','FK_bron_specificatie_dmn_bronhouder',
'ALTER TABLE masterdata.bron_specificatie ADD CONSTRAINT FK_bron_specificatie_dmn_bronhouder
FOREIGN KEY (bronhouder_id) REFERENCES masterdata.dmn_bronhouder (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','bron_specificatie_wfs','FK_bron_specificatie_wfs_bron_specificatie',
'ALTER TABLE masterdata.bron_specificatie_wfs ADD CONSTRAINT FK_bron_specificatie_wfs_bron_specificatie
FOREIGN KEY (beleid_naam_id,bronhouder_id) REFERENCES masterdata.bron_specificatie (beleid_naam_id,bronhouder_id) ON DELETE No Action ON UPDATE No Action
;');


/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE masterdata.beleid_naam_type
	IS 'Masterdata table specifying the beleidType that is linked to the beleidNaam'
;

COMMENT ON COLUMN masterdata.beleid_naam_type.beleid_naam_id
	IS 'De aanduiding van het natuurbeleid in de informatiekaart natuur'
;

COMMENT ON COLUMN masterdata.beleid_naam_type.beleid_type_id
	IS 'De indeling in type natuurbeleid volgens de typering uit de codelijst beleidType'
;

COMMENT ON TABLE masterdata.bron_specificatie
	IS 'Masterdata table specifying the source per  	1. bronhouder 	2. beleidNaam   Source can be  	- WFS 	- FGDB 	- Other'
;

COMMENT ON COLUMN masterdata.bron_specificatie.beleid_naam_id
	IS 'De aanduiding van het natuurbeleid in de informatiekaart natuur'
;

COMMENT ON COLUMN masterdata.bron_specificatie.bronhouder_id
	IS 'De overheidsorganisatie die het beleid heeft opgesteld'
;

COMMENT ON COLUMN masterdata.bron_specificatie.bron_type_id
	IS 'Source can be  	- WFS 	- FGDB 	- Other'
;

COMMENT ON TABLE masterdata.bron_specificatie_wfs
	IS 'Masterdata table specifying the WFS source per  	1. bronhouder 	2. beleidNaam'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.beleid_naam_id
	IS 'De aanduiding van het natuurbeleid in de informatiekaart natuur'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.bronhouder_id
	IS 'De overheidsorganisatie die het beleid heeft opgesteld'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.metadata_url
	IS 'The URL to the xml containing the metadata of this dataset as specified in v2.1.0 of the Dutch profile on the ISO 19115.'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.wfs_end_point
	IS 'Link to the WFS endpoint where the source data can be harvested.'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.feature_type
	IS 'The featuere type of the dataset in the WFS endpoint where the source data can be harvested.'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.laatste_revisie
	IS 'Latest revision of the dataset that was processed into IKN'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.changed_by_user
	IS 'Indicates if the user manually changed the WFS specification.'
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.active
	IS 'indicates if this specific WFS source is currently active and data should be loaded from it'
;

--COMMENT ON COLUMN masterdata.bron_specificatie_wfs.last_time_processed_with_error
--	IS 'Indicates the last time the wfs data (fetching the data from the wfs and reading the metadata went fine) was processed incorrectly'
--;
