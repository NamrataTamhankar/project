\echo "Starting deployment of "PNL" schema for ANLB automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS "PNL"
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA "PNL" TO anlb;

--GRANT USAGE ON SCHEMA etl TO ;
GRANT USAGE ON SCHEMA "PNL" TO anlb_sqlpad;


/* Create Tables */

CREATE TABLE IF NOT EXISTS "PNL"."AgrarischZoekGebiedShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	naam varchar(200) NULL,
	agrarnt varchar(64) NULL,
	toegbp text NULL,
	toegcb text NULL,
	toegbf text NULL,
	dgnaam varchar(256) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."AgrarischZoekGebiedShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."BeheergebiedAmbitieShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	btype varchar(64) NULL,
	indbtype text NULL,
	toegbp text NULL,
	rtype varchar(2) NULL,
	taakstllng smallint NULL,
	statusehs smallint NULL,
	gegadnwntr smallint NULL,
	subssknl smallint NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."BeheergebiedAmbitieShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."BeheergebiedShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	btype varchar(64) NULL,
	indbtype text NULL,
	toegbp text NULL,
	subs smallint NULL,
	nsubsbp text NULL,
	rtype varchar(2) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."BeheergebiedShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."BijzondergebiedShape"
(
	byz_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	bnaam varchar(64) NULL,
	bcode varchar(64) NULL,
	bzgbtype varchar(3) NULL,
	bzgbkopp smallint NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."BijzondergebiedShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."DeelgebiedShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	deelnaam varchar(50) NULL,
	beschr varchar(256) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."DeelgebiedShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	lzgnaam varchar(200) NULL,
	toegbt text NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."LandschapsZoekgebiedAmbitieShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."LandschapsZoekgebiedShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	lzgnaam varchar(200) NULL,
	toegbt text NULL,
	nsubsbp text NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."LandschapsZoekgebiedShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."NatuurbeheerplanShape"
(
	nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbpnaam varchar(64) NULL,
	nbpverw varchar(255) NULL,
	nbpeig varchar(255) NULL,
	datumv timestamp without time zone NULL,
	beslnr varchar(20) NULL,
	prv_id integer NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."NatuurbeheerplanShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL".tln_nbp
(
	tln_nbp_id integer NULL,
	nbp_id integer NULL,
	tln_nbp_datum timestamp without time zone NULL,
	status_code integer NULL,
	prs_id integer NULL,
	besluit_num varchar(64) NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL".tln_nbp
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "PNL"."ZoekGebiedWaterShape"
(
	sub_nbp_id integer NULL,
	imna_id varchar(100) NULL,
	nbp_id integer NULL,
	naam varchar(200) NULL,
	wtrt varchar(64) NULL,
	toegbp text NULL,
	toegcb text NULL,
	toegbf text NULL,
	dgnaam varchar(256) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "PNL"."ZoekGebiedWaterShape"
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */
/* Dropping old indexes from shape files*/
--DEV/TEST
DROP INDEX IF EXISTS "PNL"."AgrarischZoekGebiedShape_geom_155851425552";
DROP INDEX IF EXISTS "PNL"."BeheergebiedAmbitieShape_geom_1558514288565";
DROP INDEX IF EXISTS "PNL"."BeheergebiedShape_geom_1558514357204";
DROP INDEX IF EXISTS "PNL"."BijzondergebiedShape_geom_1558514477257";
DROP INDEX IF EXISTS "PNL"."DeelgebiedShape_geom_1558514483671";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape_geom_155851446913";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedShape_geom_1558514261990";
DROP INDEX IF EXISTS "PNL"."NatuurbeheerplanShape_geom_1558514476878";
DROP INDEX IF EXISTS "PNL"."ZoekGebiedWaterShape_geom_1558514485694";
DROP INDEX IF EXISTS "PNL".tln_nbp_geom_1558514483668;

--ACC
DROP INDEX IF EXISTS "PNL"."AgrarischZoekGebiedShape_geom_1578957381564";
DROP INDEX IF EXISTS "PNL"."AgrarischZoekGebiedShape_nbp_id_1578957380745";
DROP INDEX IF EXISTS "PNL"."BeheergebiedAmbitieShape_geom_157897905342";
DROP INDEX IF EXISTS "PNL"."BeheergebiedAmbitieShape_nbp_id_157897904596";
DROP INDEX IF EXISTS "PNL"."BeheergebiedShape_geom_1578979097471";
DROP INDEX IF EXISTS "PNL"."BeheergebiedShape_nbp_id_1578979086381";
DROP INDEX IF EXISTS "PNL"."BijzondergebiedShape_geom_1578979155850";
DROP INDEX IF EXISTS "PNL"."BijzondergebiedShape_nbp_id_1578979155411";
DROP INDEX IF EXISTS "PNL"."DeelgebiedShape_geom_1578979158832";
DROP INDEX IF EXISTS "PNL"."DeelgebiedShape_nbp_id_1578979158720";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape_geom_1578979150750";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape_nbp_id_15789791508";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedShape_geom_1578979030532";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedShape_nbp_id_1578979027962";
DROP INDEX IF EXISTS "PNL"."NatuurbeheerplanShape_geom_157897904529";
DROP INDEX IF EXISTS "PNL"."NatuurbeheerplanShape_nbp_id_157897904524";
DROP INDEX IF EXISTS "PNL"."ZoekGebiedWaterShape_geom_1578979159554";
DROP INDEX IF EXISTS "PNL"."ZoekGebiedWaterShape_nbp_id_1578979159389";
DROP INDEX IF EXISTS "PNL".tln_nbp_geom_1578979158691;
DROP INDEX IF EXISTS "PNL".tln_nbp_nbp_id_1578979158687;
DROP INDEX IF EXISTS "PNL".tln_nbp_tln_nbp_id_1578979158683;

--PROD 
DROP INDEX IF EXISTS "PNL"."AgrarischZoekGebiedShape_geom_1583962566336";
DROP INDEX IF EXISTS "PNL"."AgrarischZoekGebiedShape_nbp_id_1583962565521";
DROP INDEX IF EXISTS "PNL"."BeheergebiedAmbitieShape_geom_158391120060";
DROP INDEX IF EXISTS "PNL"."BeheergebiedAmbitieShape_nbp_id_1583911191541";
DROP INDEX IF EXISTS "PNL"."BeheergebiedShape_geom_1583910485162";
DROP INDEX IF EXISTS "PNL"."BeheergebiedShape_nbp_id_1583910472340";
DROP INDEX IF EXISTS "PNL"."BijzondergebiedShape_geom_1583909420914";
DROP INDEX IF EXISTS "PNL"."BijzondergebiedShape_nbp_id_1583909420165";
DROP INDEX IF EXISTS "PNL"."DeelgebiedShape_geom_158390942443";
DROP INDEX IF EXISTS "PNL"."DeelgebiedShape_nbp_id_1583909423870";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape_geom_1583909415655";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedAmbitieShape_nbp_id_1583909413821";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedShape_geom_1583909134846";
DROP INDEX IF EXISTS "PNL"."LandschapsZoekgebiedShape_nbp_id_1583909132410";
DROP INDEX IF EXISTS "PNL"."NatuurbeheerplanShape_geom_1583909149426";
DROP INDEX IF EXISTS "PNL"."NatuurbeheerplanShape_nbp_id_1583909149421";
DROP INDEX IF EXISTS "PNL"."ZoekGebiedWaterShape_geom_1583909150704";
DROP INDEX IF EXISTS "PNL"."ZoekGebiedWaterShape_nbp_id_1583909149502";
DROP INDEX IF EXISTS "PNL".tln_nbp_geom_1583909149498;
DROP INDEX IF EXISTS "PNL".tln_nbp_nbp_id_1583909149494;
DROP INDEX IF EXISTS "PNL".tln_nbp_tln_nbp_id_1583909149487;

 
/* Recreating new ones */ 
CREATE INDEX IF NOT EXISTS "AgrarischZoekGebiedShape_geom" ON "PNL"."AgrarischZoekGebiedShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS  "AgrarischZoekGebiedShape_nbp_id" ON "PNL"."AgrarischZoekGebiedShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "BeheergebiedAmbitieShape_geom" ON "PNL"."BeheergebiedAmbitieShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS  "BeheergebiedAmbitieShape_nbp_id" ON "PNL"."BeheergebiedAmbitieShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "BeheergebiedShape_geom" ON "PNL"."BeheergebiedShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS  "BeheergebiedShape_nbp_id" ON "PNL"."BeheergebiedShape" USING btree (nbp_id)
;
	
CREATE INDEX IF NOT EXISTS "BijzondergebiedShape_geom" ON "PNL"."BijzondergebiedShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS  "BijzondergebiedShape_nbp_id" ON "PNL"."BijzondergebiedShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "DeelgebiedShape_geom" ON "PNL"."DeelgebiedShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "DeelgebiedShape_nbp_id" ON "PNL"."DeelgebiedShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "LandschapsZoekgebiedAmbitieShape_geom" ON "PNL"."LandschapsZoekgebiedAmbitieShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "LandschapsZoekgebiedAmbitieShape_nbp_id" ON "PNL"."LandschapsZoekgebiedAmbitieShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "LandschapsZoekgebiedShape_geom" ON "PNL"."LandschapsZoekgebiedShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "LandschapsZoekgebiedShape_nbp_id" ON "PNL"."LandschapsZoekgebiedShape" USING btree (nbp_id)
;

CREATE INDEX IF NOT EXISTS "NatuurbeheerplanShape_geom" ON "PNL"."NatuurbeheerplanShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "NatuurbeheerplanShape_nbp_id" ON "PNL"."NatuurbeheerplanShape" USING btree (nbp_id)
;
	
CREATE INDEX IF NOT EXISTS "tln_nbp_geom" ON "PNL".tln_nbp USING gist (geom)
;
CREATE INDEX IF NOT EXISTS tln_nbp_nbp_id ON "PNL".tln_nbp USING btree (nbp_id)
;
CREATE INDEX IF NOT EXISTS tln_nbp_tln_nbp_id ON "PNL".tln_nbp USING btree (tln_nbp_id)
;

CREATE INDEX IF NOT EXISTS "ZoekGebiedWaterShape_geom" ON "PNL"."ZoekGebiedWaterShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "ZoekGebiedWaterShape_nbp_id" ON "PNL"."ZoekGebiedWaterShape" USING btree (nbp_id)
;

/* Create Foreign Key Constraints */

/* Create Views */

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.btype AS beheer_type,
    ( SELECT dmn_beheer_type.description
           FROM masterdata.dmn_beheer_type
          WHERE (dmn_beheer_type.code = (b.btype)::bpchar)) AS beheer_type_desc,
        CASE
            WHEN (b.subs = 1) THEN 'Ja'::text
            WHEN (b.subs = 0) THEN 'Nee'::text
            ELSE NULL::text
        END AS subsidiabel,
    b.indbtype AS indicatieve_verhouding_beheer_typen,
    b.toegbp AS toegestane_beheer_paketten,
    b.nsubsbp AS niet_subsidiabele_beheer_paketten,
    b.geom AS geometry
   FROM "PNL"."BeheergebiedShape" b;
;

ALTER TABLE "PNL".v_beheer_gebied
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_agrarisch AS 
 SELECT v_beheer_gebied.provincie,
    v_beheer_gebied.status,
    v_beheer_gebied.status_desc,
    v_beheer_gebied.subsidie_jaar,
    v_beheer_gebied.identificatie,
    v_beheer_gebied.beheer_type,
    v_beheer_gebied.beheer_type_desc,
    v_beheer_gebied.subsidiabel,
    v_beheer_gebied.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied.toegestane_beheer_paketten,
    v_beheer_gebied.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied.geometry
   FROM "PNL".v_beheer_gebied
  WHERE ((v_beheer_gebied.beheer_type)::text ~~ 'A%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.btype AS beheer_type,
    ( SELECT dmn_beheer_type.description
           FROM masterdata.dmn_beheer_type
          WHERE (dmn_beheer_type.code = (b.btype)::bpchar)) AS beheer_type_desc,
        CASE
            WHEN (b.subssknl = 1) THEN 'Ja'::text
            WHEN (b.subssknl = 0) THEN 'Nee'::text
            ELSE NULL::text
        END AS subsidiabel,
    b.indbtype AS indicatieve_verhouding_beheer_typen,
    b.toegbp AS toegestane_beheer_paketten,
    b.rtype AS recreatie_type,
        CASE
            WHEN ((b.rtype)::text = 'R0'::text) THEN 'Afgesloten natuurterrein'::text
            WHEN ((b.rtype)::text = 'R1'::text) THEN 'Opengesteld inrichtingsniveau beperkt'::text
            WHEN ((b.rtype)::text = 'R2'::text) THEN 'Opengesteld inrichtingsniveau basis'::text
            WHEN ((b.rtype)::text = 'R3'::text) THEN 'Opengesteld inrichtingsniveau plus'::text
            WHEN ((b.rtype)::text = 'R4'::text) THEN 'Opengesteld recreatie om de stad'::text
            ELSE NULL::text
        END AS recreatie_type_desc,
    b.taakstllng AS taak_stelling,
        CASE
            WHEN (b.taakstllng = 1) THEN 'Bestaande natuur'::text
            WHEN (b.taakstllng = 2) THEN 'Nieuwe natuur'::text
            WHEN (b.taakstllng = 3) THEN 'Natte natuur'::text
            WHEN (b.taakstllng = 4) THEN 'Robuuste verbindingen'::text
            WHEN (b.taakstllng = 5) THEN 'Beheersgebied'::text
            WHEN (b.taakstllng = 6) THEN 'RODS'::text
            WHEN (b.taakstllng = 999) THEN 'Geen taakstelling'::text
            ELSE NULL::text
        END AS taak_stelling_desc,
    b.statusehs AS status_ehs,
        CASE
            WHEN (b.statusehs = 1) THEN 'EHS Planologisch beschermd'::text
            WHEN (b.statusehs = 2) THEN 'EHS Planologisch beschermd Grote wateren'::text
            ELSE NULL::text
        END AS status_ehs_desc,
    b.gegadnwntr AS gegadigden_nieuwe_natuur,
        CASE
            WHEN (b.gegadnwntr = 1) THEN 'TBOs'::text
            WHEN (b.gegadnwntr = 2) THEN 'Particulieren'::text
            WHEN (b.gegadnwntr = 3) THEN 'TBOs en particulieren'::text
            ELSE NULL::text
        END AS gegadigden_nieuwe_natuur_desc,
    b.geom AS geometry
   FROM "PNL"."BeheergebiedAmbitieShape" b;
;

ALTER TABLE "PNL".v_beheer_gebied_ambitie
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_agrarisch AS 
 SELECT v_beheer_gebied_ambitie.provincie,
    v_beheer_gebied_ambitie.status,
    v_beheer_gebied_ambitie.status_desc,
    v_beheer_gebied_ambitie.subsidie_jaar,
    v_beheer_gebied_ambitie.identificatie,
    v_beheer_gebied_ambitie.beheer_type,
    v_beheer_gebied_ambitie.beheer_type_desc,
    v_beheer_gebied_ambitie.subsidiabel,
    v_beheer_gebied_ambitie.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie.recreatie_type,
    v_beheer_gebied_ambitie.recreatie_type_desc,
    v_beheer_gebied_ambitie.taak_stelling,
    v_beheer_gebied_ambitie.taak_stelling_desc,
    v_beheer_gebied_ambitie.status_ehs,
    v_beheer_gebied_ambitie.status_ehs_desc,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie.geometry
   FROM "PNL".v_beheer_gebied_ambitie
  WHERE ((v_beheer_gebied_ambitie.beheer_type)::text ~~ 'A%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_landschap AS 
 SELECT v_beheer_gebied_ambitie.provincie,
    v_beheer_gebied_ambitie.status,
    v_beheer_gebied_ambitie.status_desc,
    v_beheer_gebied_ambitie.subsidie_jaar,
    v_beheer_gebied_ambitie.identificatie,
    v_beheer_gebied_ambitie.beheer_type,
    v_beheer_gebied_ambitie.beheer_type_desc,
    v_beheer_gebied_ambitie.subsidiabel,
    v_beheer_gebied_ambitie.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie.recreatie_type,
    v_beheer_gebied_ambitie.recreatie_type_desc,
    v_beheer_gebied_ambitie.taak_stelling,
    v_beheer_gebied_ambitie.taak_stelling_desc,
    v_beheer_gebied_ambitie.status_ehs,
    v_beheer_gebied_ambitie.status_ehs_desc,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie.geometry
   FROM "PNL".v_beheer_gebied_ambitie
  WHERE ((v_beheer_gebied_ambitie.beheer_type)::text ~~ 'L%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_ambitie_natuur AS 
 SELECT v_beheer_gebied_ambitie.provincie,
    v_beheer_gebied_ambitie.status,
    v_beheer_gebied_ambitie.status_desc,
    v_beheer_gebied_ambitie.subsidie_jaar,
    v_beheer_gebied_ambitie.identificatie,
    v_beheer_gebied_ambitie.beheer_type,
    v_beheer_gebied_ambitie.beheer_type_desc,
    v_beheer_gebied_ambitie.subsidiabel,
    v_beheer_gebied_ambitie.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied_ambitie.toegestane_beheer_paketten,
    v_beheer_gebied_ambitie.recreatie_type,
    v_beheer_gebied_ambitie.recreatie_type_desc,
    v_beheer_gebied_ambitie.taak_stelling,
    v_beheer_gebied_ambitie.taak_stelling_desc,
    v_beheer_gebied_ambitie.status_ehs,
    v_beheer_gebied_ambitie.status_ehs_desc,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur,
    v_beheer_gebied_ambitie.gegadigden_nieuwe_natuur_desc,
    v_beheer_gebied_ambitie.geometry
   FROM "PNL".v_beheer_gebied_ambitie
  WHERE ((v_beheer_gebied_ambitie.beheer_type)::text ~~ 'N%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_ambitie_natuur
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_landschap AS 
 SELECT v_beheer_gebied.provincie,
    v_beheer_gebied.status,
    v_beheer_gebied.status_desc,
    v_beheer_gebied.subsidie_jaar,
    v_beheer_gebied.identificatie,
    v_beheer_gebied.beheer_type,
    v_beheer_gebied.beheer_type_desc,
    v_beheer_gebied.subsidiabel,
    v_beheer_gebied.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied.toegestane_beheer_paketten,
    v_beheer_gebied.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied.geometry
   FROM "PNL".v_beheer_gebied
  WHERE ((v_beheer_gebied.beheer_type)::text ~~ 'L%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_beheer_gebied_natuur AS 
 SELECT v_beheer_gebied.provincie,
    v_beheer_gebied.status,
    v_beheer_gebied.status_desc,
    v_beheer_gebied.subsidie_jaar,
    v_beheer_gebied.identificatie,
    v_beheer_gebied.beheer_type,
    v_beheer_gebied.beheer_type_desc,
    v_beheer_gebied.subsidiabel,
    v_beheer_gebied.indicatieve_verhouding_beheer_typen,
    v_beheer_gebied.toegestane_beheer_paketten,
    v_beheer_gebied.niet_subsidiabele_beheer_paketten,
    v_beheer_gebied.geometry
   FROM "PNL".v_beheer_gebied
  WHERE ((v_beheer_gebied.beheer_type)::text ~~ 'N%'::text);
;

ALTER TABLE "PNL".v_beheer_gebied_natuur
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_bijzonder_gebied AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.bnaam AS gebieds_naam,
    b.bcode AS gebieds_code,
        CASE
            WHEN ((b.bcode)::text = 'B1'::text) THEN 'Probleemgebiedenvergoeding'::text
            WHEN ((b.bcode)::text = 'B2'::text) THEN 'Vaarland'::text
            WHEN ((b.bcode)::text = 'B3'::text) THEN 'Gescheperde Schaapskuddes'::text
            ELSE NULL::text
        END AS gebieds_code_desc,
    b.geom AS geometry
   FROM "PNL"."BijzondergebiedShape" b;
;

ALTER TABLE "PNL".v_bijzonder_gebied
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_deel_gebied AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.deelnaam AS gebieds_naam,
    b.beschr AS beschrijving,
    b.geom AS geometry
   FROM "PNL"."DeelgebiedShape" b;
;

ALTER TABLE "PNL".v_deel_gebied
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_natuur_beheer_plan AS 
 SELECT b.prv_id AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.nbpnaam AS plan_naam,
    b.nbpverw AS plan_verwijzing,
    b.nbpeig AS plan_eigenaar,
    b.datumv AS datum_vaststelling,
    b.geom AS geometry
   FROM "PNL"."NatuurbeheerplanShape" b;
;

ALTER TABLE "PNL".v_natuur_beheer_plan
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_agrarisch AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.naam,
    b.agrarnt AS agrarisch_natuur_type,
    b.dgnaam AS deel_gebied_naam,
    b.toegbp AS toegestane_beheer_typen,
    b.toegcb AS toegestane_beheer_clusters,
    b.toegbf AS toegestane_beheer_functies,
    b.geom AS geometry
   FROM "PNL"."AgrarischZoekGebiedShape" b;
;

ALTER TABLE "PNL".v_zoek_gebied_agrarisch
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_ambitie_landschap AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.lzgnaam AS naam,
    b.toegbt AS toegestane_beheer_typen,
    b.geom AS geometry
   FROM "PNL"."LandschapsZoekgebiedAmbitieShape" b;
;

ALTER TABLE "PNL".v_zoek_gebied_ambitie_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_landschap AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.lzgnaam AS naam,
    b.toegbt AS toegestane_beheer_typen,
    b.nsubsbp AS niet_subsidiabele_beheer_pakketten,
    b.geom AS geometry
   FROM "PNL"."LandschapsZoekgebiedShape" b;
;

ALTER TABLE "PNL".v_zoek_gebied_landschap
    OWNER TO anlb;

CREATE OR REPLACE VIEW "PNL".v_zoek_gebied_water AS 
 SELECT ( SELECT p.prv_id
           FROM "PNL"."NatuurbeheerplanShape" p
          WHERE (p.nbp_id = b.nbp_id)) AS provincie,
    ( SELECT s.status_code
           FROM "PNL".tln_nbp s
          WHERE (s.nbp_id = b.nbp_id)) AS status,
        CASE
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 1) THEN 'Concept'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 2) THEN 'Vastgesteld ontwerp'::text
            WHEN (( SELECT s.status_code
               FROM "PNL".tln_nbp s
              WHERE (s.nbp_id = b.nbp_id)) = 3) THEN 'Vastgesteld definitief'::text
            ELSE NULL::text
        END AS status_desc,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.naam,
    b.wtrt AS water_natuur_type,
    b.dgnaam AS deel_gebied_naam,
    b.toegbp AS toegestane_beheer_typen,
    b.toegcb AS toegestane_beheer_clusters,
    b.toegbf AS toegestane_beheer_functies,
    b.geom AS geometry
   FROM "PNL"."ZoekGebiedWaterShape" b;
;

ALTER TABLE "PNL".v_zoek_gebied_water
    OWNER TO anlb;

GRANT SELECT ON ALL TABLES IN SCHEMA "PNL" TO anlb_sqlpad;