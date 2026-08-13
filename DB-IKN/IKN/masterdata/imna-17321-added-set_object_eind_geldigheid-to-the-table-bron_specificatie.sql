ALTER TABLE masterdata.bron_specificatie_wfs ADD COLUMN IF NOT EXISTS set_object_eind_geldigheid timestamp NULL;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.set_object_eind_geldigheid
	IS 'A bronhouder can set the end date of objects that do not have an end date for a particular policy in VertiGIS. The filled in date time value by user is stored in this column'
;