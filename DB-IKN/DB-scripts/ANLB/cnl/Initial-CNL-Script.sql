\echo "Starting deployment of "CNL" schema for ANLB automatic deployment"
\echo "Also deploying update on bug SNL-586 for view CNL v_beheer_eenheden"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS "CNL"
    AUTHORIZATION anlb;

GRANT ALL ON SCHEMA "CNL" TO anlb;

--GRANT USAGE ON SCHEMA etl TO ;
GRANT USAGE ON SCHEMA "CNL" TO anlb_sqlpad;


/* Create Tables */

CREATE TABLE IF NOT EXISTS "CNL"."BeheereenheidLijnShape"
(
	sub_cbp_id integer NULL,
	cbp_id integer NULL,
	pakket varchar(64) NULL,
	brsnummer varchar(12) NULL,
	afw_brs_nr text NULL,
	reden_brs text NULL,
	opp numeric(10,3) NULL,
	reden_opp text NULL,
	extra boolean NULL,
	mozaiek varchar(64) NULL,
	consistent varchar(11) NULL,
	tochok boolean NULL,
	tochok_not text NULL,
	afw_datum timestamp without time zone NULL,
	lengte numeric(10,2) NULL,
	breedte numeric(10,2) NULL,
	aantal integer NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "CNL"."BeheereenheidLijnShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "CNL"."BeheereenheidShape"
(
	sub_cbp_id integer NULL,
	cbp_id integer NULL,
	pakket varchar(64) NULL,
	brsnummer varchar(12) NULL,
	afw_brs_nr text NULL,
	reden_brs text NULL,
	opp numeric(10,3) NULL,
	reden_opp text NULL,
	extra boolean NULL,
	mozaiek varchar(64) NULL,
	consistent varchar(11) NULL,
	tochok boolean NULL,
	tochok_not text NULL,
	afw_datum timestamp without time zone NULL,
	lengte numeric(10,2) NULL,
	breedte numeric(10,2) NULL,
	aantal integer NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "CNL"."BeheereenheidShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "CNL"."CollectiefbeheerplanShape"
(
	cbp_id integer NULL,
	imna_id varchar(100) NULL,
	cbpnaam varchar(256) NULL,
	cbpcode varchar(5) NULL,
	prv_id integer NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "CNL"."CollectiefbeheerplanShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "CNL"."LastMinuteBeheerShape"
(
	sub_cbp_id integer NULL,
	cbp_id integer NULL,
	cbp_naam varchar(256) NULL,
	prv_id integer NULL,
	prv_naam varchar(32) NULL,
	brs_num varchar(12) NULL,
	opp numeric(10,3) NULL,
	type_id integer NULL,
	type_oms varchar(256) NULL,
	tarief numeric(10,2) NULL,
	totaal numeric(10,2) NULL,
	reden varchar(256) NULL,
	aanvullng varchar(256) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "CNL"."LastMinuteBeheerShape"
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS "CNL"."RuigeMestShape"
(
	rmm_id integer NULL,
	sub_cbp_id integer NULL,
	cbp_id integer NULL,
	pakket varchar(64) NULL,
	brsnummer varchar(12) NULL,
	opp numeric(10,3) NULL,
	vaarland boolean NULL,
	datum_uitrijden timestamp without time zone NULL,
	datum_melding timestamp without time zone NULL,
	opmerkingen varchar(512) NULL,
	jaar integer NULL,
	geom geometry NULL
)
;

ALTER TABLE "CNL"."RuigeMestShape"
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

/* Dropping old indexes from shape files*/
--DEV/TEST
DROP INDEX IF EXISTS "CNL"."BeheereenheidLijnShape_geom_1573631699749";
DROP INDEX IF EXISTS "CNL"."BeheereenheidShape_geom_1573631700782";
DROP INDEX IF EXISTS "CNL"."CollectiefbeheerplanShape_geom_1573631707173";
DROP INDEX IF EXISTS "CNL"."LastMinuteBeheerShape_geom_1573631707993";
DROP INDEX IF EXISTS "CNL"."RuigeMestShape_geom_1573631707855";
--ACC
DROP INDEX IF EXISTS "CNL"."BeheereenheidLijnShape_cbp_id_1578572558506";
DROP INDEX IF EXISTS "CNL"."BeheereenheidLijnShape_geom_1578572558967";
DROP INDEX IF EXISTS "CNL"."BeheereenheidShape_cbp_id_1578572560863";
DROP INDEX IF EXISTS "CNL"."BeheereenheidShape_geom_1578572562215";
DROP INDEX IF EXISTS "CNL"."CollectiefbeheerplanShape_cbp_id_15785725607";
DROP INDEX IF EXISTS "CNL"."CollectiefbeheerplanShape_geom_157857256022";
DROP INDEX IF EXISTS "CNL"."LastMinuteBeheerShape_cbp_id_1578572567503";
DROP INDEX IF EXISTS "CNL"."LastMinuteBeheerShape_geom_1578572567534";
DROP INDEX IF EXISTS "CNL"."RuigeMestShape_cbp_id_1578572567614";
DROP INDEX IF EXISTS "CNL"."RuigeMestShape_geom_1578572567664";
--PROD 
DROP INDEX IF EXISTS "CNL"."BeheereenheidLijnShape_cbp_id_1583903214509";
DROP INDEX IF EXISTS "CNL"."BeheereenheidLijnShape_geom_15839032155";
DROP INDEX IF EXISTS "CNL"."BeheereenheidShape_cbp_id_158390321678";
DROP INDEX IF EXISTS "CNL"."BeheereenheidShape_geom_1583903217113";
DROP INDEX IF EXISTS "CNL"."CollectiefbeheerplanShape_cbp_id_1583903222561";
DROP INDEX IF EXISTS "CNL"."CollectiefbeheerplanShape_geom_1583903223574";
DROP INDEX IF EXISTS "CNL"."LastMinuteBeheerShape_cbp_id_1583903224292";
DROP INDEX IF EXISTS "CNL"."LastMinuteBeheerShape_geom_1583903224320";
DROP INDEX IF EXISTS "CNL"."RuigeMestShape_cbp_id_1583903224431";
DROP INDEX IF EXISTS "CNL"."RuigeMestShape_geom_1583903224484 ";
 
 
/* Recreating new ones */ 
CREATE INDEX IF NOT EXISTS "BeheereenheidLijnShape_geom" ON "CNL"."BeheereenheidLijnShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "BeheereenheidLijnShape_cbp_id" ON "CNL"."BeheereenheidLijnShape" USING btree (cbp_id)
;

CREATE INDEX IF NOT EXISTS "BeheereenheidShape_geom" ON "CNL"."BeheereenheidShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "BeheereenheidShape_cbp_id" ON "CNL"."BeheereenheidShape" USING btree (cbp_id)
;

CREATE INDEX IF NOT EXISTS "CollectiefbeheerplanShape_geom"  ON "CNL"."CollectiefbeheerplanShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "CollectiefbeheerplanShape_cbp_id" ON "CNL"."CollectiefbeheerplanShape" USING btree (cbp_id)
;

CREATE INDEX IF NOT EXISTS "LastMinuteBeheerShape_geom" ON "CNL"."LastMinuteBeheerShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "LastMinuteBeheerShape_cbp_id" ON "CNL"."LastMinuteBeheerShape" USING btree (cbp_id)
;

CREATE INDEX IF NOT EXISTS "RuigeMestShape_geom" ON "CNL"."RuigeMestShape" USING gist (geom)
;
CREATE INDEX IF NOT EXISTS "RuigeMestShape_cbp_id" ON "CNL"."RuigeMestShape" USING btree (cbp_id)
;

\echo "CNL - Add geoserver_id go CNL BeheereenheidShape"
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 
				     FROM information_schema.columns 
				    WHERE table_schema='CNL' 
				      AND table_name='BeheereenheidShape' 
				      AND column_name='geoserver_id')
    THEN
        EXECUTE '
				 ALTER TABLE IF EXISTS "CNL"."BeheereenheidShape"
				    ADD COLUMN geoserver_id bigint ;
				 
				 CREATE SEQUENCE "CNL".position_seq;
				 UPDATE "CNL"."BeheereenheidShape"
				  	SET geoserver_id = NEXTVAL(''"CNL".position_seq'');
				 DROP SEQUENCE "CNL".position_seq;
				 
				 CREATE INDEX IF NOT EXISTS ix_beheer_eenheid_shape_geoserver_id
				   ON "CNL"."BeheereenheidShape" USING btree
                   (geoserver_id ASC NULLS LAST);
				 
   		        ';
		RAISE NOTICE 'Adding BeheereenheidShape.geoserver_id ';
    END IF;
END;
$$ LANGUAGE 'plpgsql';



/* Create Foreign Key Constraints */


DO
$$
BEGIN
	IF NOT EXISTS (SELECT 1 
						 FROM information_schema.columns 
						WHERE table_schema='CNL' 
						  AND table_name='v_beheer_eenheden' 
						  AND column_name='geoserver_id')
		THEN
			EXECUTE '
					 DROP VIEW IF EXISTS "CNL"."v_beheer_eenheden" CASCADE;
					';
		RAISE NOTICE 'Adding v_beheer_eenheden.geoserver_id ';
	END IF;
END;
$$ LANGUAGE 'plpgsql';

/* Create Views */

CREATE OR REPLACE VIEW "CNL".v_beheer_eenheden AS 
 SELECT ( SELECT p.prv_id
           FROM "CNL"."CollectiefbeheerplanShape" p
          WHERE (p.cbp_id = b.cbp_id)
		  LIMIT 1) AS provincie,
    b.jaar AS subsidie_jaar,
    b.pakket AS pakket_code,
    b.brsnummer AS rvo_relatie_nummer,
    b.opp AS oppervlak,
        CASE
            WHEN (b.extra = true) THEN 'Ja'::text
            WHEN (b.extra = false) THEN 'Nee'::text
            ELSE NULL::text
        END AS extra_subsidie,
    b.mozaiek,
	b.geoserver_id,
    b.geom AS geometry
   FROM "CNL"."BeheereenheidShape" b;
;

ALTER TABLE "CNL".v_beheer_eenheden
    OWNER TO anlb;

CREATE OR REPLACE VIEW "CNL".v_collectief_beheer_plan AS 
 SELECT b.prv_id AS provincie,
    b.jaar AS subsidie_jaar,
    b.imna_id AS identificatie,
    b.cbpnaam AS plan_naam,
    b.cbpcode AS plan_code,
    b.geom AS geometry
   FROM "CNL"."CollectiefbeheerplanShape" b;
;

ALTER TABLE "CNL".v_collectief_beheer_plan
    OWNER TO anlb;

GRANT SELECT ON ALL TABLES IN SCHEMA "CNL" TO anlb_sqlpad;