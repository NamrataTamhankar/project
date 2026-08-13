\echo "Creating function pg_temp.rename_table_if_needed"

CREATE OR REPLACE FUNCTION pg_temp.rename_table_if_needed(
	t_schema_name text,
    t_old_table text,
    t_new_table text,
	t_alter_sql text
)
RETURNS void AS 
$$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.tables 
        WHERE table_schema = t_schema_name 
          AND table_name = t_old_table
    ) AND NOT EXISTS (
        SELECT 1 
        FROM information_schema.tables 
        WHERE table_schema = t_schema_name 
          AND table_name = t_new_table
    ) 
	THEN
		EXECUTE t_alter_sql;
		RAISE NOTICE 'Table name %.% has been altered to table name %', t_schema_name, t_old_table, t_new_table;
	ELSE
		RAISE NOTICE 'Skipping renaming: Either table %.% does not exist or new table name % already exists', t_schema_name, t_old_table, t_new_table;
    END IF;
END;
$$ LANGUAGE plpgsql;