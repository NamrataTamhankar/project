-- View: "CNL".v_collectief_beheer_plan

-- DROP VIEW "CNL".v_collectief_beheer_plan;

CREATE OR REPLACE VIEW "CNL".v_collectief_beheer_plan AS 
 SELECT prv_id  AS provincie,
       jaar AS subsidie_jaar,
       imna_id AS identificatie,
	   cbpnaam AS plan_naam,
       cbpcode AS plan_code,
	   geom AS geometry
  FROM "CNL"."CollectiefbeheerplanShape" b
 ;
 
 ALTER TABLE "CNL".v_collectief_beheer_plan
  OWNER TO anlb;
  

-- View: "CNL".v_beheer_eenheden

-- DROP VIEW "CNL".v_beheer_eenheden;

CREATE OR REPLACE VIEW "CNL".v_beheer_eenheden AS 
 SELECT ( SELECT p.prv_id
           FROM "CNL"."CollectiefbeheerplanShape" p
          WHERE p.cbp_id = b.cbp_id
         LIMIT 1) AS provincie,
    b.jaar AS subsidie_jaar,
    b.pakket AS pakket_code,
    b.brsnummer AS rvo_relatie_nummer,
    b.opp AS oppervlak,
        CASE
            WHEN b.extra = true THEN 'Ja'::text
            WHEN b.extra = false THEN 'Nee'::text
            ELSE NULL::text
        END AS extra_subsidie,
    b.mozaiek,
    b.geom AS geometry
   FROM "CNL"."BeheereenheidShape" b;

ALTER TABLE "CNL".v_beheer_eenheden
  OWNER TO anlb;
