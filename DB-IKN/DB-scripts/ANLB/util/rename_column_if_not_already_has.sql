\echo "Creating function pg_temp.rename_column_if_needed"

CREATE OR REPLACE FUNCTION pg_temp.rename_column_if_needed(
    t_schema_name text,
    t_table_name text,
    t_old_column_name text,
    t_new_column_name text,
	t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    column_exists boolean;
    new_column_conflict boolean;
BEGIN
    -- Check if the old column exists
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = t_schema_name
          AND table_name = t_table_name
          AND column_name = t_old_column_name
    ) INTO column_exists;

    -- Check if new column name already exists
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = t_schema_name
          AND table_name = t_table_name
          AND column_name = t_new_column_name
    ) INTO new_column_conflict;

    IF NOT column_exists THEN
        RAISE NOTICE 'Column %.%.% does not exist. Skipping rename.', t_schema_name, t_table_name, t_old_column_name;
        RETURN;
    ELSIF new_column_conflict THEN
        RAISE NOTICE 'Column %.%.% already exists. Cannot rename to that.', t_schema_name, t_table_name, t_new_column_name;
        RETURN;
    END IF;

    -- Perform the rename
	EXECUTE t_alter_sql;

    RAISE NOTICE 'Renamed column %.%.% to %', t_schema_name, t_table_name, t_old_column_name, t_new_column_name;
END;
$$
LANGUAGE plpgsql;