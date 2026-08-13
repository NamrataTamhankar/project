\echo "Starting deployment of GeoServer - CNL Creation"

DO
$$
BEGIN
	IF NOT EXISTS (SELECT 1 
						 FROM information_schema.columns 
						WHERE table_schema='geoserver' 
						  AND table_name='snl_cbp_beheer_eenheden' 
						  AND column_name='geoserver_id')
		THEN
			EXECUTE '
					 DROP VIEW IF EXISTS geoserver.snl_cbp_beheer_eenheden;
					';
		RAISE NOTICE 'Adding snl_cbp_beheer_eenheden.geoserver_id ';
    END IF;		
END;
$$ LANGUAGE 'plpgsql';

/* Create Views */

CREATE OR REPLACE VIEW geoserver.snl_cbp_beheer_eenheden AS 
 SELECT v_beheer_eenheden.provincie,
    v_beheer_eenheden.subsidie_jaar,
    v_beheer_eenheden.pakket_code,
    v_beheer_eenheden.rvo_relatie_nummer,
    v_beheer_eenheden.oppervlak,
    v_beheer_eenheden.extra_subsidie,
    v_beheer_eenheden.mozaiek,
	v_beheer_eenheden.geoserver_id,
    v_beheer_eenheden.geometry
   FROM "CNL".v_beheer_eenheden;
;

ALTER TABLE geoserver.snl_cbp_beheer_eenheden
    OWNER to anlb;

CREATE OR REPLACE VIEW geoserver.snl_cbp_collectief_beheer_plan AS 
 SELECT v_collectief_beheer_plan.provincie,
    v_collectief_beheer_plan.subsidie_jaar,
    v_collectief_beheer_plan.identificatie,
    v_collectief_beheer_plan.plan_naam,
    v_collectief_beheer_plan.plan_code,
    v_collectief_beheer_plan.geometry
   FROM "CNL".v_collectief_beheer_plan;
;

ALTER TABLE geoserver.snl_cbp_collectief_beheer_plan
    OWNER to anlb;
	
GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad;