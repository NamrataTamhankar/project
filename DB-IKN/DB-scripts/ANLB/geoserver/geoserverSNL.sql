\echo "Starting deployment of GeoServer"

\i geoserver/generic-create-schema.sql
\i geoserver/bes_creation.sql
\i geoserver/vrn_creation.sql
\i geoserver/pnl_creation.sql
\i geoserver/nbp_creation.sql
\i geoserver/cnl_creation.sql
\i geoserver/W2312_031_Change_VRN_current_table_year_to_2022.sql
\i geoserver/IMNA-10928-update-ambitie.sql
\i geoserver/W2406_002_S025_Change__NBP_current_table_ontwerp_year_to_2025.sql
\i geoserver/IMNA-17169_NBP_BES_current_layer_year_switch.sql
\i geoserver/IMNA-18662_Change_VRN_current_table_year_to_2023.sql
\i geoserver/create_gt_pk_metadata.sql
\i geoserver/IMNA-19686_Create_Geoserver_SNL_views_metadata.sql
\i geoserver/SNL-286_NBP_current_layer_year_switch_design_2026.sql
\i geoserver/SNL-583_NBP_current_layer_year_switch_definitive_2026.sql
\i geoserver/SNL-289_BES_current_layer_year_switch_2025.sql
\i geoserver/SNL-3905_NBP_current_layer_year_switch_design_2027.sql
\i geoserver/SNL-4558_Change_VRN_current_table_year_to_2024.sql