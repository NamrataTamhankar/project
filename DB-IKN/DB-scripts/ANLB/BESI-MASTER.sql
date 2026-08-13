\echo "Starting deployment of Besi"

\i util/add_constraint_if_not_exists_function.sql

-- Because of the order of the scripts that are being called and we dont want to use cascade. These scripts will be executed first to prevent errors
\i geoweb/BESI-113-alter-besi-geoweb-views-and-remove-regelink-data-a.sql
\i besi/BESI-113-remove-regelink-tables.sql
\i masterdata/BESI-113-remove-regelink-functie-table.sql

\i etl/etl.sql
\i masterdata/masterdataBesi.sql
\i dso/dso.sql
\i besi/besi.sql
\i geoweb/geowebBesi.sql
\i geoserver/geoserverBesi.sql

