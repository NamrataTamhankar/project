\echo "GeoServer - inserting SNL metadata in table gt_pk_metadata"


\echo "snl_cbp_beheer_eenheden"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_cbp_beheer_eenheden','geoserver_id',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_cbp_collectief_beheer_plan"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_cbp_collectief_beheer_plan','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_cbp_collectief_beheer_plan','subsidie_jaar',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_cbp_collectief_beheer_plan','plan_naam',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_beheer_gebied_agrarisch"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_agrarisch','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_agrarisch','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_agrarisch','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_agrarisch','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_beheer_gebied_ambitie"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;	
\echo "snl_nbp_beheer_gebied_ambitie_agrarisch"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_agrarisch','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_agrarisch','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_agrarisch','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_agrarisch','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;	
\echo "snl_nbp_beheer_gebied_ambitie_landschap"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_landschap','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_landschap','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_landschap','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_landschap','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;		
\echo "snl_nbp_beheer_gebied_ambitie_natuur"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_natuur','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_natuur','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_natuur','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_ambitie_natuur','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_beheer_gebied_landschap"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_landschap','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_landschap','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_landschap','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_landschap','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_beheer_gebied_natuur"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_natuur','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_natuur','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_natuur','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_beheer_gebied_natuur','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_bijzonder_gebied"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_bijzonder_gebied','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_bijzonder_gebied','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_bijzonder_gebied','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_bijzonder_gebied','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_deel_gebied"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_deel_gebied','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_deel_gebied','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_deel_gebied','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_deel_gebied','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_natuur_beheer_plan"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_natuur_beheer_plan','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_natuur_beheer_plan','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_natuur_beheer_plan','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_natuur_beheer_plan','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_zoek_gebied_agrarisch"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_agrarisch','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_agrarisch','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_agrarisch','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_agrarisch','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_zoek_gebied_ambitie_landschap"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_ambitie_landschap','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_ambitie_landschap','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_ambitie_landschap','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_ambitie_landschap','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_zoek_gebied_landschap"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_landschap','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_landschap','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_landschap','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_landschap','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "snl_nbp_zoek_gebied_water"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_water','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_water','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_water','subsidie_jaar',2, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','snl_nbp_zoek_gebied_water','identificatie',3, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_bes_beschikking_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_bes_beschikking_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_bes_beschikking_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_beheer_gebied_ambitie_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_ambitie_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_ambitie_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_ambitie_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_beheer_gebied_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_beheer_gebied_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_deel_gebied_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_deel_gebied_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_deel_gebied_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_deel_gebied_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_zoek_gebied_agrarisch_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_agrarisch_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_agrarisch_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_agrarisch_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_zoek_gebied_klimaat_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_klimaat_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_klimaat_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_klimaat_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_nbp_viewer_zoek_gebied_water_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_water_current','provincie',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_water_current','status',1, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_nbp_viewer_zoek_gebied_water_current','identificatie',2, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_vrn_gebied_inrichting_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_inrichting_current','bron_houder',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_inrichting_current','identificatie',1, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_vrn_gebied_natuur_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_natuur_current','bron_houder',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_natuur_current','identificatie',1, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_vrn_gebied_verwerving_current"	
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_verwerving_current','bron_houder',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_gebied_verwerving_current','identificatie',1, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "v_imna_vrn_natuur_netwerk_nederland_current"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_natuur_netwerk_nederland_current','bron_houder',0, 'assigned') 
ON CONFLICT DO NOTHING;
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','v_imna_vrn_natuur_netwerk_nederland_current','identificatie',1, 'assigned') 
ON CONFLICT DO NOTHING;