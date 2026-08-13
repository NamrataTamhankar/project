\echo "Starting deployment of NDVH"

\i util/add_constraint_if_not_exists_function.sql
\i etl/etl.sql
\i synbiosys/synbiosys.sql
\i ndff/ndff.sql
\i masterdata/masterdataNDVH.sql
\i natura_2000/natura_2000.sql
\i imna/imnaNDVH.sql
\i geoweb/geowebNDVH.sql
\i geoserver/geoserverNDVH.sql
