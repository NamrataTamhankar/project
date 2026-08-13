\echo "Deploying Besi-1944 Adding extra column to besi report request table to keep track of the source"

ALTER TABLE geoweb.besi_report_request ADD COLUMN IF NOT EXISTS besi_component_id bigint NULL;

CREATE INDEX IF NOT EXISTS IXFK_besi_report_request_dmn_besi_component ON geoweb.besi_report_request (besi_component_id ASC)
;

/* Create Foreign Key Constraints */


SELECT pg_temp.create_constraint_if_not_exists ('besi','besi_report_request','FK_besi_report_request_dmn_besi_component',
'ALTER TABLE geoweb.besi_report_request ADD CONSTRAINT FK_besi_report_request_dmn_besi_component
	FOREIGN KEY (besi_component_id) REFERENCES masterdata.dmn_besi_component (id) ON DELETE No Action ON UPDATE No Action
;');

COMMENT ON COLUMN geoweb.besi_report_request.besi_component_id
	IS 'Component that created the Report Request record'
;