CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_beheer_gebied_ambitie
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb_sqlpad;  

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_beheer_gebied_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_beheer_gebied
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_deel_gebied_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_deel_gebied
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_deel_gebied_current TO anlb_sqlpad;  

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_agrarisch
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_agrarisch_current TO anlb_sqlpad;  

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_klimaat
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_klimaat_current TO anlb_sqlpad; 

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_zoek_gebied_water_current
 AS
 SELECT * FROM geoserver.imna_nbp_viewer_zoek_gebied_water
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2025 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_zoek_gebied_water_current TO anlb_sqlpad; 

GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;