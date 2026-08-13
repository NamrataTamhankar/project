\echo "Starting deployment of RNN"

\i util/add_constraint_if_not_exists_function.sql
\i util/alter_data_type_if_not_already_has.sql
\i util/rename_table_if_not_already_has.sql
\i util/rename_constraint_if_not_already_has.sql
\i util/rename_column_if_not_already_has.sql
\i etl/etl.sql
\i masterdata/masterdataRNN.sql
\i ndff/ndff.sql
\i rnn/rnn.sql
\i imna/imnaRNN.sql
\i geoweb/geowebRNN.sql
\i geoserver/geoserverRNN.sql
