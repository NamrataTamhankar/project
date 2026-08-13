\echo "Starting deployment of GeoServer"

\i geoserver/generic-create-schema.sql
\i geoserver/RNN-2500_add_rnn_views_for_verwerkingen_and_dossiers.sql
\i geoserver/RNN-2933-replace-rnn-portal-vertigis-views.sql
\i geoserver/RNN-2930-Add-maatlat-version-to-dossier.sql