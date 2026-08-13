\echo "Starting deployment of IMNA"

\i imna/generic-create-schema.sql
\i imna/NDVH-Habitat-IMNA-creation.sql
\i imna/NDVH-Vegetatie-IMNA-creation.sql

\i imna/IMNA-12039-NDVH-Vegetatie-Drop-SoortKatering_BedekkingsPercentage.sql
\i imna/IMNA-11955-NDVH-Vegetatie-Alter-Lokale_toevoeging.sql
\i imna/IMNA-11881-NDVH-Vegetatie-Transfer-schema_opname_soort.sql
\i imna/IMNA-13368-NDVH-Vegetatie-toevoegingsklasse-optional.sql
\i imna/IMNA-15670-NDVH-Vegetatie-Vegetatie-opname-waarnemer-optional.sql