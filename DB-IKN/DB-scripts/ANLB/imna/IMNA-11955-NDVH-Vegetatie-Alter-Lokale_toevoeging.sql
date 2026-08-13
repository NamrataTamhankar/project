\echo "IMNA-11955 Alter colums on lokale_toevoeging"

ALTER TABLE IF EXISTS imna.lokale_toevoeging 
	DROP COLUMN IF EXISTS toevoeging_naam,
	DROP COLUMN IF EXISTS toevoeging_toelichting,
	DROP COLUMN IF EXISTS toevoeging_code,
	DROP COLUMN IF EXISTS toevoeging_code_naam,
	ADD COLUMN IF NOT EXISTS toevoeging_omschrijving text NOT NULL DEFAULT 'CONVERSION DEFAULT',    -- Omschrijving van de toevoeging / Explanation of the addition
	ADD COLUMN IF NOT EXISTS toevoeging_klasse text NOT NULL DEFAULT 'CONVERSION DEFAULT'    -- De bedekkingsklasse van de toevoeging / The coverage class pf the addition
;

DO
$$
BEGIN
    -- Look for our constraint
    IF EXISTS (SELECT 1 
				 FROM information_schema.columns 
				WHERE table_schema='imna' 
				  AND table_name='lokale_toevoeging' 
				  AND column_name='toevoeging_omschrijving')
    THEN
        EXECUTE '
			ALTER TABLE IF EXISTS imna.lokale_toevoeging 
				ALTER COLUMN toevoeging_omschrijving DROP DEFAULT;
				
			COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_omschrijving
				IS ''Omschrijving van de toevoeging / Explanation of the addition'';				
		';
		RAISE NOTICE 'Remove default from lokale_toevoeging.toevoeging_omschrijving';
    END IF;
END;
$$ LANGUAGE 'plpgsql';

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
				ALTER COLUMN toevoeging_klasse DROP DEFAULT;
			
			COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_klasse
				IS ''De bedekkingsklasse van de toevoeging / The coverage class pf the addition'';				
		';
		RAISE NOTICE 'Remove default from lokale_toevoeging.toevoeging_klasse';
    END IF;
END;
$$ LANGUAGE 'plpgsql';