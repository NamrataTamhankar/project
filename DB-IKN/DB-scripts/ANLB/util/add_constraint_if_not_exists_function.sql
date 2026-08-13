\echo "Creating function pg_temp.create_constraint_if_not_exists"

CREATE OR REPLACE FUNCTION pg_temp.create_constraint_if_not_exists (
    t_schema_name text, t_table_name text, t_constraint_name text, t_constraint_sql text
) 
RETURNS void AS
$$
BEGIN
    -- Look for our constraint
    IF NOT EXISTS ( SELECT 1
                      FROM information_schema.constraint_column_usage 
                     WHERE constraint_schema = t_schema_name
					   AND table_name = t_table_name
                       AND constraint_name = LOWER(t_constraint_name)
					 UNION 
					SELECT 1 
					  FROM information_schema.table_constraints
					 WHERE table_name = t_table_name
                       AND constraint_name = LOWER(t_constraint_name))
    THEN
        EXECUTE t_constraint_sql;
		RAISE NOTICE 'constraint % % added',t_table_name,t_constraint_name;
	ELSE
		RAISE NOTICE 'constraint % % already exists, skipping',t_table_name,t_constraint_name;
    END IF;
END;
$$ LANGUAGE 'plpgsql';