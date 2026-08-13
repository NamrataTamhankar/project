\echo "Starting deployment of ANLB besi"

\i besi/Initial-Besi-Script.sql

\i besi/imna-12831-add-3-domain-tables-for-dso-integration-Besi.sql
\i besi/IMNA-13667-add-regelink-tables.sql
\i besi/IMNA-13669-create-star-table-for-regelink.sql
\i besi/IMNA-16661-Remove-Sovon-History.sql
\i besi/BESI-203-Remove-Kwantiel-and-dichtheid.sql
\i besi/BESI-1981-Add-dsoapi-user-and-permissions.sql
\i besi/BESI-1960-Add-logging-tables-for-dso-api.sql
\i besi/BESI-2611-add-maatregelenblad-to-besi.sql