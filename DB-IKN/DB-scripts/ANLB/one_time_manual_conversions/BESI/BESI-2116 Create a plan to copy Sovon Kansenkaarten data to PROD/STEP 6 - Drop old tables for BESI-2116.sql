DROP TABLE geoweb.besi_geotiff_files_old;
DROP TABLE geoweb.besi_geotiff_old;
DROP TABLE geoweb.besi_species_group_geotiff_files_old;
DROP TABLE geoweb.besi_species_group_geotiff_old;

DROP TABLE besi.besi_species_group_kans_versie_old;
DROP TABLE besi.besi_species_group_kansen_huidig_old;
DROP TABLE besi.taxa_kans_versie_old;
DROP TABLE besi.taxa_kansen_huidig_old;





-- Remove permissions for 
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT table_schema, table_name
        FROM information_schema.tables
        WHERE table_schema = 'geoweb'
              AND table_type = 'BASE TABLE'
    LOOP
        EXECUTE format('REVOKE ALL PRIVILEGES ON TABLE %I.%I FROM %I',
                       r.table_schema, r.table_name, 'besi_readonly');
    END LOOP;
END
$$;

--Set permissions back
GRANT SELECT ON  geoweb.besi_geotiff TO besi_readonly;
GRANT SELECT ON  geoweb.besi_geotiff_files TO besi_readonly;
GRANT SELECT ON  geoweb.besi_report_request TO besi_readonly;
GRANT SELECT ON  geoweb.besi_species_group_geotiff TO besi_readonly;
GRANT SELECT ON  geoweb.besi_species_group_geotiff_files TO besi_readonly;