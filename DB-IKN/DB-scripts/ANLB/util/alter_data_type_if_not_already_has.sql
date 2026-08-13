\echo "Creating function pg_temp.alter_data_type_if_not_already_has"

CREATE OR REPLACE FUNCTION pg_temp.alter_data_type_if_not_already_has (
	t_table_name text, t_column_name text, t_data_type_new text, t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    current_data_type text;
BEGIN
	-- Get the current data type
    SELECT data_type INTO current_data_type
    FROM information_schema.columns
    WHERE table_name = t_table_name
    AND column_name = t_column_name;
	
	-- look for our data type
	IF current_data_type = t_data_type_new
	THEN
		RAISE NOTICE 'data type % in table % in column % already exists, skipping',t_data_type_new, t_table_name,t_column_name;
	ELSE
		EXECUTE t_alter_sql;
		RAISE NOTICE 'data type in table % for column % altered to %', t_table_name,t_column_name, t_data_type_new;	
	END IF;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION pg_temp.alter_precision_if_not_already_has (
	t_table_name text, t_column_name text, t_data_type_new text, t_precision_new text, t_scale_new text, t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    current_data_type text;
	current_precision text;
	current_scale text;
BEGIN
	-- Get the current data type
    SELECT data_type INTO current_data_type
    FROM information_schema.columns
    WHERE table_name = t_table_name
    AND column_name = t_column_name;
	
	
	SELECT numeric_precision INTO current_precision
    FROM information_schema.columns
    WHERE table_name = t_table_name
    AND column_name = t_column_name;
	
	
	SELECT numeric_scale INTO current_scale
    FROM information_schema.columns
    WHERE table_name = t_table_name
    AND column_name = t_column_name;

	
	-- look for our data type
	IF current_data_type = t_data_type_new AND current_precision = t_precision_new AND current_scale = t_scale_new
	THEN
		RAISE NOTICE 'data type, precission and scale % in table % in column % already exists, skipping',t_data_type_new, t_table_name,t_column_name;
	ELSE
		EXECUTE t_alter_sql;
		RAISE NOTICE 'data type, precission and scale in table % for column % altered to %', t_table_name,t_column_name, t_data_type_new;	
	END IF;
END;
$$ LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION pg_temp.alter_column_varchar_max_length (
	t_table_name text, t_column_name text, t_data_varchar_length_new text, t_alter_sql text
)
RETURNS void AS
$$
DECLARE
    current_varchar_length text;
BEGIN
	-- Get the current data type
    SELECT character_maximum_length INTO current_varchar_length
    FROM information_schema.columns
    WHERE table_name = t_table_name
    AND column_name = t_column_name;
	
	-- look for our data type
	IF current_varchar_length = t_data_varchar_length_new
	THEN
		RAISE NOTICE 'Column % in table % already has max length of %, skipping.',t_column_name, t_table_name, t_data_varchar_length_new;
	ELSE
		EXECUTE t_alter_sql;
		RAISE NOTICE 'Max length in table % for column % altered to %', t_table_name,t_column_name, t_data_varchar_length_new;	
	END IF;
END;
$$ LANGUAGE 'plpgsql';




