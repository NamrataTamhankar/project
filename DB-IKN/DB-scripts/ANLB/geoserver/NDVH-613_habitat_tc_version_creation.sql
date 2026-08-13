\echo "Starting deployment of GeoServer - Habitat tc Creation"

/* Create Views */

-- View: geoserver.ndvh_habitat_package_tc

-- DROP VIEW geoserver.ndvh_habitat_package_tc;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_package_tc AS
SELECT *
  FROM geoserver.ndvh_habitat_package pa
 WHERE NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package pb
  				    WHERE pa.identificatie <> pb.identificatie
					  AND pa.gebied_nr = pb.gebied_nr
					  AND pa.package_versie < pb.package_versie);

   
ALTER TABLE geoserver.ndvh_habitat_package_tc
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_package_tc TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_package_tc TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_1000

-- DROP VIEW geoserver.ndvh_habitat_tc_1000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_1000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 1
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);

   
ALTER TABLE geoserver.ndvh_habitat_tc_1000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_1000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_1000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_2000

-- DROP VIEW geoserver.ndvh_habitat_tc_2000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_2000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 2
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_2000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_2000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_2000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_3000

-- DROP VIEW geoserver.ndvh_habitat_tc_3000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_3000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 3
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_3000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_3000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_3000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_4000

-- DROP VIEW geoserver.ndvh_habitat_tc_4000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_4000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 4
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_4000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_4000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_4000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_5000

-- DROP VIEW geoserver.ndvh_habitat_tc_5000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_5000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 5
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_5000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_5000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_5000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_6000

-- DROP VIEW geoserver.ndvh_habitat_tc_6000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_6000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 6
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_6000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_6000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_6000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_7000

-- DROP VIEW geoserver.ndvh_habitat_tc_7000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_7000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 7
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_7000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_7000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_7000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_9000

-- DROP VIEW geoserver.ndvh_habitat_tc_9000;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_9000 AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 9
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_9000
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_9000 TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_9000 TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_all

-- DROP VIEW geoserver.ndvh_habitat_tc_all;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_all AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 0
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_all
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_all TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_all TO anlb_sqlpad;   
;

-- View: geoserver.ndvh_habitat_tc_kwal

-- DROP VIEW geoserver.ndvh_habitat_tc_kwal;

CREATE OR REPLACE VIEW geoserver.ndvh_habitat_tc_kwal AS
SELECT *
  FROM geoserver.ndvh_habitat
 WHERE layer_nr = 10
   AND NOT EXISTS (SELECT 1
                     FROM geoserver.ndvh_habitat_package 
 				    WHERE ndvh_habitat_package.gebied_nr = ndvh_habitat.gebied_nr
					  AND ndvh_habitat_package.package_versie > ndvh_habitat.package_versie);   
   
ALTER TABLE geoserver.ndvh_habitat_tc_kwal
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.ndvh_habitat_tc_kwal TO anlb;
GRANT SELECT ON TABLE geoserver.ndvh_habitat_tc_kwal TO anlb_sqlpad;   
;


\echo "GeoServer - inserting NDVH metadata in table gt_pk_metadata"

\echo "ndvh_habitat_package_tc"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_package_tc','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;

\echo "ndvh_habitat_tc_1000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_1000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_2000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_2000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_3000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_3000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_4000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_4000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_5000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_5000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_6000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_6000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_7000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_7000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_9000"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_9000','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_all"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_all','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;
\echo "ndvh_habitat_tc_kwal"
INSERT INTO geoserver.gt_pk_metadata 
(table_schema, table_name, pk_column, pk_column_idx, pk_policy)
VALUES 
('geoserver','ndvh_habitat_tc_kwal','identificatie',0, 'assigned') 
ON CONFLICT DO NOTHING;