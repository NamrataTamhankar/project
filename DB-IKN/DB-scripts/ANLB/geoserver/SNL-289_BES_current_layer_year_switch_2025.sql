\echo "SNL-289 Switching BES Current layers to 2025"
CREATE OR REPLACE VIEW geoserver.v_imna_bes_beschikking_current
 AS
 SELECT * FROM geoserver.imna_bes_beschikking
 WHERE beheer_jaar = 2025;

ALTER TABLE geoserver.v_imna_bes_beschikking_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_bes_beschikking_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_bes_beschikking_current TO anlb_sqlpad;  