\echo "Creating function rename_primary_key_if_needed"

CREATE OR REPLACE FUNCTION pg_temp.rename_primary_key_if_needed(
    t_schema_name text,
    t_table_name text,
    t_new_pk_name text,
	t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    current_pk_name text;
    conflict_exists boolean;
BEGIN
    -- Find the current PK constraint name
    SELECT constraint_name
    INTO current_pk_name
    FROM information_schema.table_constraints
    WHERE table_schema = t_schema_name
      AND table_name = t_table_name
      AND constraint_type = 'PRIMARY KEY';

    -- If no PK found, raise notice and exit
    IF current_pk_name IS NULL THEN
        RAISE NOTICE 'No primary key constraint found on %.%', t_schema_name, t_table_name;
        RETURN;
    END IF;

    -- Check if the new constraint name already exists on this table
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = t_schema_name
          AND table_name = t_table_name
          AND constraint_name = LOWER(t_new_pk_name)
    ) INTO conflict_exists;

    IF conflict_exists THEN
        RAISE NOTICE 'Constraint name % already exists on %.%', t_new_pk_name, t_schema_name, t_table_name;
        RETURN;
    END IF;

    -- Rename the PK constraint
    EXECUTE t_alter_sql;

    RAISE NOTICE 'Primary key constraint on %.% renamed from % to %',
        t_schema_name, t_table_name, current_pk_name, t_new_pk_name;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION pg_temp.rename_index_if_needed(
    t_schema_name text,
    t_old_index_name text,
    t_new_index_name text,
	t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    exists_old boolean;
    exists_new boolean;
BEGIN
    -- Check if old index exists
    SELECT EXISTS (
        SELECT 1 FROM pg_indexes
        WHERE schemaname = t_schema_name
          AND LOWER(indexname) = LOWER(t_old_index_name)
    ) INTO exists_old;

    IF NOT exists_old THEN
        RAISE NOTICE 'Index "%" does not exist in schema "%", skipping rename.', t_old_index_name, t_schema_name;
        RETURN;
    END IF;

    -- Check if new index name already exists
    SELECT EXISTS (
        SELECT 1 FROM pg_indexes
        WHERE schemaname = t_schema_name
          AND LOWER(indexname) = LOWER(t_new_index_name)
    ) INTO exists_new;

    IF exists_new THEN
        RAISE NOTICE 'Index name "%" already exists in schema "%", cannot rename.', t_new_index_name, t_schema_name;
        RETURN;
    END IF;

    -- Rename the index
	EXECUTE t_alter_sql;

    RAISE NOTICE 'Index renamed from "%" to "%" in schema "%".', t_old_index_name, t_new_index_name, t_schema_name;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION pg_temp.rename_foreign_key_constraint_if_needed(
    t_schema_name text,
    t_table_name text,
    t_old_fk_name text,
    t_new_fk_name text,
	t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    exists_old boolean;
    exists_new boolean;
BEGIN
    -- Check if the old foreign key constraint exists on the specified table
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_schema = t_schema_name
          AND table_name = t_table_name
          AND LOWER(constraint_name) = LOWER(t_old_fk_name)
          AND constraint_type = 'FOREIGN KEY'
    ) INTO exists_old;

    IF NOT exists_old THEN
        RAISE NOTICE 'Foreign key constraint "%" does not exist on table "%.%" - skipping rename.', t_old_fk_name, t_schema_name, t_table_name;
        RETURN;
    END IF;

    -- Check if the new foreign key constraint name already exists on the table
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_schema = t_schema_name
          AND table_name = t_table_name
          AND LOWER(constraint_name) = LOWER(t_new_fk_name)
          AND constraint_type = 'FOREIGN KEY'
    ) INTO exists_new;

    IF exists_new THEN
        RAISE NOTICE 'Foreign key constraint name "%" already exists on table "%.%" - cannot rename.', t_new_fk_name, t_schema_name, t_table_name;
        RETURN;
    END IF;

    -- Execute the rename
    EXECUTE t_alter_sql;

    RAISE NOTICE 'Foreign key constraint renamed from "%" to "%" on table "%.%"', t_old_fk_name, t_new_fk_name, t_schema_name, t_table_name;
END;
$$
LANGUAGE plpgsql;