\echo "Starting deployment of masterdata for NDVH specific"

\i masterdata/generic-create-schema.sql
\i masterdata/generic-create-tables.sql
\i masterdata/specific-create-domain-tables-NDVH-Habitat.sql
\i masterdata/specific-create-domain-tables-NDVH-Vegetatie.sql
\i masterdata/generic-update-domain-views.sql
\i masterdata/generic-update-link-table-views.sql

\i masterdata/IMNA-12891-add-ignore_xsd_element_validation-to-feature-layer.sql
\i masterdata/NDVH-4602-add_natura_2000_overlap_table.sql
