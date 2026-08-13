\echo "IMNA-13368 Make lokale_toevoeging.toevoeging_klasse optional"

DO
$$
BEGIN
    -- Look for our constraint
    IF EXISTS (SELECT 1 
				 FROM information_schema.columns 
				WHERE table_schema='imna' 
				  AND table_name='lokale_toevoeging' 
				  AND column_name='toevoeging_klasse')
    THEN
        EXECUTE '
				 ALTER TABLE IF EXISTS imna.lokale_toevoeging 
				 ALTER COLUMN toevoeging_klasse DROP NOT NULL;
		';
		RAISE NOTICE 'Alter lokale_toevoeging.toevoeging_klasse DROP NOT NULL';
    END IF;
END;
$$ LANGUAGE 'plpgsql';

