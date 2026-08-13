\echo "Starting deployment of GeoServer"

\i geoserver/generic-create-schema.sql
\i geoserver/natura_2000_creation.sql
\i geoserver/habitat_creation.sql
\i geoserver/vegitation_creation.sql
\i geoserver/IMNA-13735_switch_vegetation_package_geom.sql
\i geoserver/IMNA-15699_habitat_t2_creation.sql
\i geoserver/create_gt_pk_metadata.sql
\i geoserver/IMNA-19684_Create_Geoserver_NDVH_views_metadata.sql
\i geoserver/NDVH-613_habitat_tc_version_creation.sql
\i geoserver/NDVH-4616-IDX_ndvh_habitat_veldsituatie_datum.sql