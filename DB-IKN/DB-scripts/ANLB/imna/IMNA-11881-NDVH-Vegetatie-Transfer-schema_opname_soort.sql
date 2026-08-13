\echo "IMNA-11881 Transfer abundantie_schaal_schema_opname_soort_id"

DO
$$
BEGIN
    -- Look for our constraint
    IF EXISTS (SELECT 1 
				 FROM information_schema.columns 
				WHERE table_schema='imna' 
				  AND table_name='vegetatie_kartering_package' 
				  AND column_name='abundantie_schaal_schema_opname_soort_id')
    THEN
        EXECUTE '
			DROP INDEX IF EXISTS imna.ixfk_vegetatie_opname_vegetatie_kartering_package;
			
			ALTER TABLE imna.vegetatie_opname 
				ADD CONSTRAINT FK_vegetatie_opname_vegetatie_kartering_package
				FOREIGN KEY (package_id) REFERENCES imna.vegetatie_kartering_package (id) ON DELETE No Action ON UPDATE No Action
			;
			CREATE INDEX IXFK_vegetatie_opname_vegetatie_kartering_package ON imna.vegetatie_opname (package_id ASC);
			
			ALTER TABLE imna.vegetatie_opname 
				ADD CONSTRAINT FK_vegetatie_opname_abundance_schema_opname_soort
				FOREIGN KEY (abundantie_schaal_schema_opname_soort_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action;
			
			CREATE INDEX IXFK_vegetatie_opname_abundance_schema_opname_soort ON imna.vegetatie_opname (abundantie_schaal_schema_opname_soort_id ASC);				
			
			DROP INDEX IF EXISTS imna.ixfk_vegetatie_kartering_package_abundance_schema_opname_soort;
		
			ALTER TABLE IF EXISTS imna.vegetatie_kartering_package 
				DROP COLUMN IF EXISTS abundantie_schaal_schema_opname_soort_id;
			
		';
		RAISE NOTICE 'Transfered abundantie_schaal_schema_opname_soort_id';
    END IF;
END;
$$ LANGUAGE 'plpgsql';
