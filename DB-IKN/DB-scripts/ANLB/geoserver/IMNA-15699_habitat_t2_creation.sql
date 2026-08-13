\echo "Starting deployment of GeoServer - Habitat T2 Creation"

/* Create Views */

-- View: geoserver.ndvh_habitat_package_t2

-- DROP VIEW geoserver.ndvh_habitat_package_t2;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_package_t2 AS
SELECT *
  FROM geoserver.ndvh_habitat_package
 WHERE package_versie = 'T2';
   
ALTER TABLE geoserver.ndvh_habitat_package_t2
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_package_t2 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_package_t2 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_1000

-- DROP VIEW geoserver.ndvh_habitat_t2_1000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_1000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 1;
   
ALTER TABLE geoserver.ndvh_habitat_t2_1000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_1000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_1000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_2000

-- DROP VIEW geoserver.ndvh_habitat_t2_2000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_2000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 2;
   
ALTER TABLE geoserver.ndvh_habitat_t2_2000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_2000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_2000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_3000

-- DROP VIEW geoserver.ndvh_habitat_t2_3000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_3000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 3;
   
ALTER TABLE geoserver.ndvh_habitat_t2_3000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_3000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_3000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_4000

-- DROP VIEW geoserver.ndvh_habitat_t2_4000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_4000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 4;
   
ALTER TABLE geoserver.ndvh_habitat_t2_4000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_4000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_4000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_5000

-- DROP VIEW geoserver.ndvh_habitat_t2_5000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_5000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 5;
   
ALTER TABLE geoserver.ndvh_habitat_t2_5000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_5000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_5000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_6000

-- DROP VIEW geoserver.ndvh_habitat_t2_6000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_6000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 6;
   
ALTER TABLE geoserver.ndvh_habitat_t2_6000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_6000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_6000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_7000

-- DROP VIEW geoserver.ndvh_habitat_t2_7000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_7000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 7;
   
ALTER TABLE geoserver.ndvh_habitat_t2_7000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_7000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_7000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_9000

-- DROP VIEW geoserver.ndvh_habitat_t2_9000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_9000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 9;
   
ALTER TABLE geoserver.ndvh_habitat_t2_9000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_9000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_9000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_all

-- DROP VIEW geoserver.ndvh_habitat_t2_all;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_all AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 0;
   
ALTER TABLE geoserver.ndvh_habitat_t2_all
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_all TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_all TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_t2_kwal

-- DROP VIEW geoserver.ndvh_habitat_t2_kwal;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_t2_kwal AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE package_versie = 'T2'
   AND layer_nr = 10;
   
ALTER TABLE geoserver.ndvh_habitat_t2_kwal
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_t2_kwal TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_t2_kwal TO anlb_sqlpad;   
;
