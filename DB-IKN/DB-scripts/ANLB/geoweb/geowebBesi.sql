\echo "Starting deployment of GeoWeb for Besi"

\i geoweb/generic-create-schema.sql
\i geoweb/besi-creation.sql
\i geoweb/besi-imna-12833-add-view-besi.v_besi_dso_data.sql
\i geoweb/besi-imna-12867-add-animal-group-to-view-soorten-en-adviezen.sql
\i geoweb/besi-imna-13669-updating-besi-report-views.sql
\i geoweb/besi-imna-16497-only-showing-function-without-end-date.sql
\i geoweb/BESI-113-alter-besi-geoweb-views-and-remove-regelink-data-b.sql
\i geoweb/BESI-1944-add-column-to-besi-report-request-table.sql
\i geoweb/BESI-1981-Add-dsoapi-user-and-permissions.sql
\i geoweb/BESI-2135_Remove_besi_kaarten_viewer.sql
\i geoweb/BESI-2611_add_view_for_maatregelenblad.sql

