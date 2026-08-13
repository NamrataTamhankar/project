\echo "Starting deployment of masterdata - Updating Masterdata link table views"


-- View: masterdata.all_link_table_data
DROP VIEW IF EXISTS masterdata.all_link_table_features;
DROP VIEW IF EXISTS masterdata.all_link_table_data;

DO $$
DECLARE
    link_tables RECORD;
	view_sql TEXT;
BEGIN  
	view_sql = 'CREATE OR REPLACE VIEW masterdata.all_link_table_data AS';
	
	FOR link_tables IN  SELECT tables.table_schema, 
							   tables.table_name,
							   (SELECT column_name
								  FROM information_schema.columns
								 WHERE columns.table_schema = tables.table_schema
								   AND columns.table_name = tables.table_name
								   AND ordinal_position = 1) as column_1,
								(SELECT ccu.table_name AS foreign_table_name
								  FROM information_schema.table_constraints AS tc 
								  JOIN information_schema.key_column_usage AS kcu
									ON tc.constraint_name = kcu.constraint_name
								   AND tc.table_schema = kcu.table_schema
								  JOIN information_schema.constraint_column_usage AS ccu
									ON ccu.constraint_name = tc.constraint_name
								  WHERE tc.constraint_type = 'FOREIGN KEY'
									AND tc.table_schema=tables.table_schema
									AND tc.table_name=tables.table_name
									AND ccu.table_schema = 'masterdata'
									AND kcu.column_name = (SELECT column_name
															 FROM information_schema.columns
															WHERE columns.table_schema = tables.table_schema
															  AND columns.table_name = tables.table_name
															  AND ordinal_position = 1) LIMIT 1) as domain_table_1,
							   (SELECT column_name
								  FROM information_schema.columns
								 WHERE columns.table_schema = tables.table_schema
								   AND columns.table_name = tables.table_name
								   AND ordinal_position = 2) as column_2,
							   (SELECT ccu.table_name AS foreign_table_name
								  FROM information_schema.table_constraints AS tc 
								  JOIN information_schema.key_column_usage AS kcu
									ON tc.constraint_name = kcu.constraint_name
								   AND tc.table_schema = kcu.table_schema
								  JOIN information_schema.constraint_column_usage AS ccu
									ON ccu.constraint_name = tc.constraint_name
							     WHERE tc.constraint_type = 'FOREIGN KEY'
								   AND tc.table_schema=tables.table_schema
								   AND tc.table_name=tables.table_name
								   AND ccu.table_schema = 'masterdata'
								   AND kcu.column_name = (SELECT column_name
														    FROM information_schema.columns
														   WHERE columns.table_schema = tables.table_schema
															 AND columns.table_name = tables.table_name
															 AND ordinal_position = 2) LIMIT 1) as domain_table_2
						FROM information_schema.tables
						WHERE table_schema = 'masterdata' 
						  AND table_name LIKE 'lnk_table%' 
						  AND table_name <> 'lnk_table_beheergebied_type' 									 
						  AND table_name <> 'lnk_table_ambitiegebied_type' 									   
						UNION 
						SELECT table_schema, 
							   table_name,
							   '' as column1,
							   '' as domain_table_1,
							   '' as column2,
							   '' as domain_table_2
						   FROM information_schema.tables
						  WHERE (table_schema = 'ndff' AND table_name = 'abundance_schema')
							 OR (table_schema = 'synbiosys' AND table_name = 'vegetatie_type_schema')
    LOOP 
		CASE 
			WHEN link_tables.table_name = 'abundance_schema'  
				THEN view_sql = view_sql || 
				'    SELECT tbl1.id AS id1,
						    tbl1."identity"::character varying AS code1,
						    tbl1.description AS description1,
						    tbl2.id AS id2,
						    tbl2."identity"::character varying AS code2,
						    tbl2.description AS description2,
						    NULL::timestamp without time zone AS valid_from,
						    NULL::timestamp without time zone AS valid_to,
						    ''abundance_code''::text AS lnk_table
					   FROM ndff.abundance_code tbl1
					   JOIN ndff.abundance_schema tbl2 ON tbl2.id = tbl1.abundance_schema_id    
					UNION';
			WHEN link_tables.table_name = 'vegetatie_type_schema'  
				THEN view_sql = view_sql || 
				'    SELECT tbl1.id AS id1,
							tbl1.uri AS code1,
							tbl1.ned_naam AS description1,
							tbl2.id AS id2,
							tbl2.uri AS code2,
							tbl2.omschrijving AS description2,
							NULL::timestamp without time zone AS valid_from,
							NULL::timestamp without time zone AS valid_to,
						   ''vegetatie_type''::text AS lnk_table
					   FROM synbiosys.vegetatie_type tbl1
					   JOIN synbiosys.vegetatie_type_schema tbl2 ON tbl2.id = tbl1.vegetatie_type_schema_id	
					UNION';
			ELSE view_sql = view_sql || 
			'    SELECT ' || link_tables.column_1 || ' AS id1,
				 (SELECT code 
				    FROM masterdata.' || link_tables.domain_table_1 || '
				   WHERE id = ' || link_tables.column_1 || ') AS code1,
				 (SELECT description
				    FROM masterdata.' || link_tables.domain_table_1 || '
				   WHERE id = ' || link_tables.column_1 || ') AS description1, ' ||
				  link_tables.column_2 || ' AS id2,
				 (SELECT code 
				    FROM masterdata.' || link_tables.domain_table_2 || '
				   WHERE id = ' || link_tables.column_2 || ') AS code2,
				 (SELECT description
				    FROM masterdata.' || link_tables.domain_table_2 || '
				   WHERE id = ' || link_tables.column_2 || ') AS description2, 
				 valid_from,
				 valid_to,
				''' || link_tables.table_name || '''::text AS lnk_table
				FROM masterdata.'|| link_tables.table_name || ' 			
			    UNION';
		END CASE;
    END LOOP;
	-- remove the last UNION
	view_sql = LEFT(view_sql,(LENGTH(view_sql) - LENGTH('UNION')));
	view_sql = view_sql || ';';
	EXECUTE view_sql;
END $$;

ALTER TABLE masterdata.all_link_table_data
    OWNER TO anlb;

GRANT SELECT ON TABLE masterdata.all_link_table_data TO anlb_sqlpad;

;
COMMENT ON VIEW masterdata.all_link_table_data
	IS 'This view selects all the values from all the link tables in the masterdata schema'
;

-- View: masterdata.all_link_table_features

-- DROP VIEW masterdata.all_link_table_features;

CREATE OR REPLACE VIEW masterdata.all_link_table_features
 AS
 SELECT all_link_table_data.id1,
 	all_link_table_data.code1,
	all_link_table_data.description1,
    all_link_table_data.id2,
	all_link_table_data.code2,
	all_link_table_data.description2,
    all_link_table_data.valid_from,
    all_link_table_data.valid_to,
    all_link_table_data.lnk_table,
    link_table_feature.link_table,
    link_table_feature.feature,
    link_table_feature.attribute_id_1,
    link_table_feature.attribute_id_2
   FROM masterdata.all_link_table_data
     JOIN masterdata.link_table_feature ON all_link_table_data.lnk_table = link_table_feature.link_table::text;

ALTER TABLE masterdata.all_link_table_features
    OWNER TO anlb;

COMMENT ON VIEW masterdata.all_link_table_features
	IS 'This table links the features with the link tables. The attributes being used in the features are also mentioned'
;

GRANT SELECT ON TABLE masterdata.all_link_table_features TO anlb_sqlpad;