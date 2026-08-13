\echo "Deploying IMNA-10928 Update ambitie add status NNN"

ALTER TABLE IF EXISTS geoserver.imna_nbp_viewer_beheer_gebied_ambitie
ADD COLUMN IF NOT EXISTS status_nnn char(20) NULL,
ADD COLUMN IF NOT EXISTS status_nnn_desc char(100) NULL
;

DROP VIEW IF EXISTS geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current;

CREATE OR REPLACE VIEW geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
 AS
 SELECT imna_nbp_viewer_beheer_gebied_ambitie.provincie,
		imna_nbp_viewer_beheer_gebied_ambitie.provincie_desc,
		imna_nbp_viewer_beheer_gebied_ambitie.subsidie_jaar,
		imna_nbp_viewer_beheer_gebied_ambitie.status,
		imna_nbp_viewer_beheer_gebied_ambitie.status_desc,
		imna_nbp_viewer_beheer_gebied_ambitie.identificatie,
		imna_nbp_viewer_beheer_gebied_ambitie.begin_geldigheid,
		imna_nbp_viewer_beheer_gebied_ambitie.eind_geldigheid,
		imna_nbp_viewer_beheer_gebied_ambitie.begin_tijd,
		imna_nbp_viewer_beheer_gebied_ambitie.eind_tijd,
		imna_nbp_viewer_beheer_gebied_ambitie.status_ehs,
		imna_nbp_viewer_beheer_gebied_ambitie.status_ehs_desc,
		imna_nbp_viewer_beheer_gebied_ambitie.beheer_type,
		imna_nbp_viewer_beheer_gebied_ambitie.beheer_type_desc,
		imna_nbp_viewer_beheer_gebied_ambitie.subsidiabel,
		imna_nbp_viewer_beheer_gebied_ambitie.indicatieve_verhouding_beheer_typen,
		imna_nbp_viewer_beheer_gebied_ambitie.toegestane_beheer_paketten,
		imna_nbp_viewer_beheer_gebied_ambitie.document_link,
		imna_nbp_viewer_beheer_gebied_ambitie.geom
   FROM geoserver.imna_nbp_viewer_beheer_gebied_ambitie
 WHERE (subsidie_jaar = 2024 and status = '3') OR (subsidie_jaar = 2024 and status = '2');

ALTER TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_nbp_viewer_beheer_gebied_ambitie_current TO anlb_sqlpad;  
