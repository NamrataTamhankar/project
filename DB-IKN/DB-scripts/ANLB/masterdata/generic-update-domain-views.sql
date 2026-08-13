\echo "Updating Masterdata domain views"


/* Create Views */

-- View: masterdata.all_domains
DROP VIEW IF EXISTS masterdata.all_domain_features;
DROP VIEW IF EXISTS masterdata.all_domains;

DO $$
DECLARE
    domain_tables RECORD;
	view_sql TEXT;
BEGIN  
	view_sql = 'CREATE OR REPLACE VIEW masterdata.all_domains AS';
	
	FOR domain_tables IN SELECT table_schema, table_name
						   FROM information_schema.tables
						  WHERE (table_schema = 'masterdata' AND table_name LIKE 'dmn_%')
							 OR (table_schema = 'ndff' AND table_name = 'abundance_schema')
							 OR (table_schema = 'synbiosys' AND table_name = 'vegetatie_type_schema')
							 OR (table_schema = 'synbiosys' AND table_name = 'vegetatie_type')
    LOOP 
		CASE 
			WHEN domain_tables.table_name = 'abundance_schema'  
				THEN view_sql = view_sql || 
				'    SELECT id,
							identity as code,
							name as description,
							''1900-01-01 00:00:00''::timestamp without time zone as valid_from,
							''2100-01-01 00:00:00''::timestamp without time zone as valid_to,
							''abundance_schema'' AS dmn
						FROM ndff.abundance_schema	
						UNION';
			WHEN domain_tables.table_name = 'vegetatie_type_schema'  
				THEN view_sql = view_sql || 
				'    SELECT	id,
							uri as code,
							omschrijving as description,
							''1900-01-01 00:00:00''::timestamp without time zone as valid_from,
							''2100-01-01 00:00:00''::timestamp without time zone as valid_to,
							''vegetatie_type_schema'' AS dmn
						FROM synbiosys.vegetatie_type_schema	
						UNION';
			WHEN domain_tables.table_name = 'vegetatie_type'
				THEN view_sql = view_sql || 
				'    SELECT	id,
							uri as code,
							ned_naam as description,
							''1900-01-01 00:00:00''::timestamp without time zone as valid_from,
							''2100-01-01 00:00:00''::timestamp without time zone as valid_to,
							''vegetatie_type'' AS dmn
						FROM synbiosys.vegetatie_type	
						UNION';
			ELSE view_sql = view_sql || 
			'     SELECT id,
				   code,
				   description,
		           valid_from,
		           valid_to,
		' || '''' || domain_tables.table_name || ''' AS dmn' || '
			FROM ' || domain_tables.table_schema || '.' || domain_tables.table_name || '
			UNION';
		END CASE;
    END LOOP;
	-- remove the last UNION
	view_sql = LEFT(view_sql,(LENGTH(view_sql) - LENGTH('UNION')));
	view_sql = view_sql || ';';
	EXECUTE view_sql;
END $$;


ALTER TABLE masterdata.all_domains
  OWNER TO anlb;
GRANT SELECT ON TABLE masterdata.all_domains TO anlb_sqlpad  
;

-- View: masterdata.all_domain_features

-- DROP VIEW masterdata.all_domain_features;

CREATE OR REPLACE VIEW masterdata.all_domain_features AS 
 SELECT all_domains.id,
    all_domains.code,
    all_domains.description,
    all_domains.valid_from,
    all_domains.valid_to,
    all_domains.dmn,
    domain_feature.domain,
    domain_feature.feature,
    domain_feature.attribute
   FROM masterdata.all_domains
     JOIN masterdata.domain_feature ON all_domains.dmn = domain_feature.domain;

ALTER TABLE masterdata.all_domain_features
  OWNER TO anlb;

GRANT SELECT ON TABLE masterdata.all_domain_features TO anlb_sqlpad;
