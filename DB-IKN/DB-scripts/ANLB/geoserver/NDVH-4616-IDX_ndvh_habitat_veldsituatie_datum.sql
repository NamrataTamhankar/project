\echo "Starting deployment of GeoServer - adding index IDX_ndvh_habitat_veldsituatie_datum"

CREATE INDEX IF NOT EXISTS IDX_ndvh_habitat_veldsituatie_datum ON geoserver.ndvh_habitat (veldsituatie_datum ASC)
;