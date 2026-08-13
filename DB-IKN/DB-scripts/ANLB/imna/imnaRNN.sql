\echo "Starting deployment of RNN"

\i imna/generic-create-schema.sql

\i imna/RNN-creation.sql
\i imna/RNN-2500-Add-bronhouder_id_to_dossier.sql
\i imna/RNN-2536-Add-identificatie-to-soorten-per-beheertype.sql
\i imna/RNN-2933-Add-imna-views-for-combined-use.sql
\i imna/RNN-2930-Add-maatlat-version-to-dossier.sql

