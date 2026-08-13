\echo "Starting deployment of masterdata snl specific"

\i masterdata/generic-create-schema.sql
\i masterdata/generic-create-tables.sql
\i masterdata/specific-create-domain-tables-SNL.sql
\i masterdata/specific-create-tables-SNL.sql
\i masterdata/IMNA-10928-dmn_status_nnn.sql
\i masterdata/generic-update-domain-views.sql
\i masterdata/generic-update-link-table-views.sql

\i masterdata/IMNA-12891-add-ignore_xsd_element_validation-to-feature-layer.sql
