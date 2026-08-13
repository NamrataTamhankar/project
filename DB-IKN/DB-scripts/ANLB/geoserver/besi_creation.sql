\echo "Starting deployment of GeoServer - Besi Creation"

GRANT USAGE ON SCHEMA geoserver TO besi_readonly;

/* Create Views */

-- View: geoserver.besi_besi_species_group_kansen

CREATE OR REPLACE VIEW geoserver.besi_besi_species_group_kansen
 AS
 SELECT v_gs_besi_species_group_kansen.besi_species_group_id,
    v_gs_besi_species_group_kansen.identity,
    v_gs_besi_species_group_kansen.name,
    v_gs_besi_species_group_kansen.scientific,
    v_gs_besi_species_group_kansen.kans,
    v_gs_besi_species_group_kansen.geom
   FROM besi.v_gs_besi_species_group_kansen;

ALTER TABLE geoserver.besi_besi_species_group_kansen
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.besi_besi_species_group_kansen TO besi_readonly;


-- View: geoserver.besi_besi_species_group_kwantiel

--CREATE OR REPLACE VIEW geoserver.besi_besi_species_group_kwantiel
-- AS
-- SELECT v_gs_besi_species_group_kwantiel.besi_species_group_id,
--    v_gs_besi_species_group_kwantiel.identity,
--    v_gs_besi_species_group_kwantiel.name,
--    v_gs_besi_species_group_kwantiel.scientific,
--    v_gs_besi_species_group_kwantiel.kwantiel,
--    v_gs_besi_species_group_kwantiel.geom
--   FROM besi.v_gs_besi_species_group_kwantiel;
--
--ALTER TABLE geoserver.besi_besi_species_group_kwantiel
--    OWNER TO anlb;
--
--GRANT SELECT ON TABLE geoserver.besi_besi_species_group_kwantiel TO besi_readonly;


-- View: geoserver.besi_taxa_kansen

CREATE OR REPLACE VIEW geoserver.besi_taxa_kansen
 AS
 SELECT v_gs_taxa_kansen.taxa_id,
    v_gs_taxa_kansen.identity,
    v_gs_taxa_kansen.name,
    v_gs_taxa_kansen.scientific,
    v_gs_taxa_kansen.kans,
    v_gs_taxa_kansen.geom
   FROM besi.v_gs_taxa_kansen;

ALTER TABLE geoserver.besi_taxa_kansen
    OWNER TO anlb;

GRANT SELECT ON TABLE geoserver.besi_taxa_kansen TO besi_readonly;



-- View: geoserver.besi_taxa_kwantiel

--CREATE OR REPLACE VIEW geoserver.besi_taxa_kwantiel
-- AS
-- SELECT v_gs_taxa_kwantiel.taxa_id,
--    v_gs_taxa_kwantiel.identity,
--    v_gs_taxa_kwantiel.name,
--    v_gs_taxa_kwantiel.scientific,
--    v_gs_taxa_kwantiel.kwantiel,
--    v_gs_taxa_kwantiel.geom
--   FROM besi.v_gs_taxa_kwantiel;
--
--ALTER TABLE geoserver.besi_taxa_kwantiel
--    OWNER TO anlb;
--
--GRANT SELECT ON TABLE geoserver.besi_taxa_kwantiel TO besi_readonly;


GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;