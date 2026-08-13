\echo "IMNA-15670 Make vegetatie_opname.waarnemer optional"

DO
$$
BEGIN
    IF EXISTS (SELECT 1 
				 FROM information_schema.columns 
				WHERE table_schema='imna' 
				  AND table_name='vegetatie_opname' 
				  AND column_name='waarnemer')
    THEN
        EXECUTE '
				 ALTER TABLE IF EXISTS imna.vegetatie_opname 
				 ALTER COLUMN waarnemer DROP NOT NULL;
		';
		RAISE NOTICE 'Alter vegetatie_opname.waarnemer DROP NOT NULL';
    END IF;
END;
$$ LANGUAGE 'plpgsql';