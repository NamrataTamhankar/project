CREATE OR REPLACE VIEW geoserver.imna_vrn_resterende_inrichtings_ambitie AS
 SELECT v_gs_resterende_inrichtings_ambitie.bron_houder,
    v_gs_resterende_inrichtings_ambitie.bron_houder_desc,
    v_gs_resterende_inrichtings_ambitie.rapportage_jaar,
    v_gs_resterende_inrichtings_ambitie.identificatie,
    v_gs_resterende_inrichtings_ambitie.begin_geldigheid,
    v_gs_resterende_inrichtings_ambitie.eind_geldigheid,
    v_gs_resterende_inrichtings_ambitie.resterende_inrichtings_ambitie
   FROM imna.v_gs_resterende_inrichtings_ambitie;

ALTER TABLE geoserver.imna_vrn_resterende_inrichtings_ambitie
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.imna_vrn_resterende_inrichtings_ambitie TO anlb;
GRANT SELECT ON TABLE geoserver.imna_vrn_resterende_inrichtings_ambitie TO anlb_sqlpad;
   
CREATE OR REPLACE VIEW geoserver.imna_vrn_gebied_verwerving AS
 SELECT v_gs_gebied_verwerving.bron_houder,
    v_gs_gebied_verwerving.bron_houder_desc,
    v_gs_gebied_verwerving.rapportage_jaar,
    v_gs_gebied_verwerving.identificatie,
    v_gs_gebied_verwerving.begin_geldigheid,
    v_gs_gebied_verwerving.eind_geldigheid,
    v_gs_gebied_verwerving.begin_tijd,
    v_gs_gebied_verwerving.eind_tijd,
    v_gs_gebied_verwerving.type_eigenaar,
    v_gs_gebied_verwerving.type_eigenaar_desc,
    v_gs_gebied_verwerving.contract_nummer,
    v_gs_gebied_verwerving.relatie_nummer,
    v_gs_gebied_verwerving.geom
   FROM imna.v_gs_gebied_verwerving;

ALTER TABLE geoserver.imna_vrn_gebied_verwerving
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.imna_vrn_gebied_verwerving TO anlb;
GRANT SELECT ON TABLE geoserver.imna_vrn_gebied_verwerving TO anlb_sqlpad;