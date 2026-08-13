\echo "Starting deployment of IKN masterdata"

\i masterdata/Initial-Masterdata-Generic-Create-Schema.sql
\i masterdata/Initial-Masterdata-Generic-Domain-Tables.sql
\i masterdata/initial-Masterdata-IKN-Domain-Tables.sql
\i masterdata/Initial-Masterdata-Specific-IKN.sql
\i masterdata/Initial-Masterdata-Generic-Update-Domain-views.sql

\i masterdata/imna-17321-added-set_object_eind_geldigheid-to-the-table-bron_specificatie.sql
\i masterdata/ikn-2751-added-is_arcgis_harvast-to-the-table-bron_specificatie_wfs.sql
