\echo "Starting deployment of IKN"

\i util/add_constraint_if_not_exists_function.sql
\i etl/etl.sql
\i masterdata/masterdata.sql
\i imna/imna.sql
\i geoweb/geoweb.sql
\i geoserver/geoserver.sql
