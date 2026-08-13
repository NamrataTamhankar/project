CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_inrichting_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_inrichting
 WHERE rapportage_jaar = 2022;

ALTER TABLE geoserver.v_imna_vrn_gebied_inrichting_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_inrichting_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_inrichting_current TO anlb_sqlpad;  




CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_natuur_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_natuur
 WHERE rapportage_jaar = 2022;

ALTER TABLE geoserver.v_imna_vrn_gebied_natuur_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_natuur_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_natuur_current TO anlb_sqlpad; 





CREATE OR REPLACE VIEW geoserver.v_imna_vrn_gebied_verwerving_current
 AS
 SELECT * FROM geoserver.imna_vrn_gebied_verwerving
 WHERE rapportage_jaar = 2022;

ALTER TABLE geoserver.v_imna_vrn_gebied_verwerving_current
    OWNER TO anlb;
	
GRANT ALL ON TABLE geoserver.v_imna_vrn_gebied_verwerving_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_gebied_verwerving_current TO anlb_sqlpad;





CREATE OR REPLACE VIEW geoserver.v_imna_vrn_natuur_netwerk_nederland_current
 AS
 SELECT * FROM geoserver.imna_vrn_natuur_netwerk_nederland
 WHERE rapportage_jaar = 2022;

ALTER TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current TO anlb;
GRANT SELECT ON TABLE geoserver.v_imna_vrn_natuur_netwerk_nederland_current TO anlb_sqlpad; 







