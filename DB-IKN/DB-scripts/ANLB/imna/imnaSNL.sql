\echo "Starting deployment of IMNA"

\i imna/generic-create-schema.sql
\i imna/SNL-BES-IMNA-creation.sql
\i imna/SNL-NBP-IMNA-creation.sql
\i imna/SNL-VRN-IMNA-creation.sql
\i imna/IMNA-10928-update-ambitie.sql
\i imna/IMNA-19119-SNL-Update_View-bes_reports.sql
\i imna/IMNA-6004-SNL-NBP-Drop-null-constraint-on-column-deel_gebied_status_id.sql