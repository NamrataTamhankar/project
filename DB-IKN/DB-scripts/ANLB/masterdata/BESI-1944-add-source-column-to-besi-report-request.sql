\echo "Deploying Besi-1944 Adding extra column to besi report request table to keep track of the source"

CREATE TABLE IF NOT EXISTS masterdata.dmn_besi_component
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata_seq'::text)::regclass),
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_besi_component
    OWNER to anlb;
	
GRANT SELECT ON TABLE masterdata.dmn_besi_component TO besi_readonly;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_besi_component','PK_dmn_besi_component',
'ALTER TABLE masterdata.dmn_besi_component ADD CONSTRAINT PK_dmn_besi_component
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_besi_component','UN_dmn_besi_component',
'ALTER TABLE masterdata.dmn_besi_component ADD CONSTRAINT UN_dmn_besi_component UNIQUE (code)
;');


COMMENT ON TABLE masterdata.dmn_besi_component
	IS 'This domain table is maintained by the Domain sheet. It contains information about the creator of the request. At this moment in time that would be dso, or VertiGIS Besi.'
;

GRANT SELECT ON masterdata.dmn_besi_component TO besi_geoweb;
GRANT SELECT ON masterdata.dmn_besi_component TO anlb_sqlpad;