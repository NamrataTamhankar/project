\echo "IMNA-6004 Make natuur_beheer_plan.deel_gebied_status_id optional"

DO
$$
BEGIN
    -- Look for our constraint
    IF EXISTS (SELECT 1 
				 FROM information_schema.columns 
				WHERE table_schema='imna' 
				  AND table_name='natuur_beheer_plan' 
				  AND column_name='deel_gebied_status_id')
    THEN
        EXECUTE '
				 ALTER TABLE IF EXISTS imna.natuur_beheer_plan 
				 ALTER COLUMN deel_gebied_status_id DROP NOT NULL;
				 COMMENT ON COLUMN imna.natuur_beheer_plan.deel_gebied_status_id
					IS ''DEPRECATED. Domain Id linking to the status of subarea layer of the plan'';
		';
		RAISE NOTICE 'Alter imna.natuur_beheer_plan .deel_gebied_status_id DROP NOT NULL';
    END IF;
END;
$$ LANGUAGE 'plpgsql';

