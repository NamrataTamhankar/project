\echo "Starting deployment of SNL"

\i util/add_constraint_if_not_exists_function.sql
\i etl/etl.sql
\i masterdata/masterdataSNL.sql
\i cnl/cnl.sql
\i pnl/pnl.sql
\i imna/imnaSNL.sql
\i geoweb/geowebSNL.sql
\i geoserver/geoserverSNL.sql