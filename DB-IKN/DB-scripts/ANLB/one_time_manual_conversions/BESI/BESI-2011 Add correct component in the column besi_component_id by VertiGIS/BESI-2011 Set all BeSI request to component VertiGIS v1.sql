SELECT * FROM masterdata.dmn_besi_component WHERE code = 'BeSIWebsite'
SELECT * FROM geoweb.besi_report_request WHERE besi_component_id IS NULL;

UPDATE geoweb.besi_report_request 
SET besi_component_id = (SELECT id FROM masterdata.dmn_besi_component WHERE code = 'BeSIWebsite')
WHERE besi_component_id IS NULL;