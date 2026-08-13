\echo "Starting deployment of masterdata RNN specific"

\i masterdata/generic-create-schema.sql
\i masterdata/generic-create-tables.sql
\i masterdata/specific-create-domain-tables-RNN.sql
\i masterdata/generic-update-domain-views.sql
\i masterdata/IMNA-19477-Add-rnn-soort-groep-voor-telling.sql
\i masterdata/RNN-360-add-sub-domain-table-for-expert-judgement.sql
\i masterdata/RNN-2500-Add-permissions-to-rnn-vertigis.sql
