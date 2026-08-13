\echo "Starting deployment of masterdata snl specific"

\i masterdata/generic-create-schema.sql
\i masterdata/generic-create-tables.sql
\i masterdata/specific-create-domain-tables-Besi.sql
\i masterdata/generic-update-domain-views.sql


\i masterdata/imna-12831-add-3-domain-tables-for-dso-integration-Besi.sql
\i masterdata/IMNA-12891-add-ignore_xsd_element_validation-to-feature-layer.sql
\i masterdata/IMNA-13667-add-1-domain-table-for-regelink-functies.sql
\i masterdata/BESI-1944-add-source-column-to-besi-report-request.sql
\i masterdata/BESI-1981-Add-dsoapi-user-and-permissions.sql