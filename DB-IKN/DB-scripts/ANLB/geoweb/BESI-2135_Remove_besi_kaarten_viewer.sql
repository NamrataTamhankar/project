--Remove 4 tables related to the geotiff files

-- The order is geoweb than geoserver, so geoserver.besi_public_geotiff_files has to drop first
DROP VIEW IF EXISTS geoserver.besi_public_geotiff_files;

DROP TABLE IF EXISTS geoweb.besi_geotiff_files;
DROP TABLE IF EXISTS geoweb.besi_geotiff;
DROP TABLE IF EXISTS geoweb.besi_species_group_geotiff_files;
DROP TABLE IF EXISTS geoweb.besi_species_group_geotiff;

