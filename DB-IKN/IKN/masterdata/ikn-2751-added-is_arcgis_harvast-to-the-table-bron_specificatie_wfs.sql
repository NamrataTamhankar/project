ALTER TABLE masterdata.bron_specificatie_wfs ADD COLUMN IF NOT EXISTS is_arcgis_harvast bool NOT NULL DEFAULT false;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.set_object_eind_geldigheid
	IS 'Implemented in IKN-2751. ArcGIS is not wfs compatible. the count variable in the harvast url should be considered as the amount of items being fetched. However ArcGIS considers the count as too. For example &count=2000&startIndex=1000  will fetch from 1000 too 2000 items from the wfs. If this boolean is true, FME will harvest the ArcGIS way'
;