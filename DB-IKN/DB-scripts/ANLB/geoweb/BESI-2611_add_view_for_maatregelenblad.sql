\echo "Starting deployment of BESI-2611 for geoserver schema"

-- View: besi.v_besi_maatregelenblad

-- DROP VIEW besi.v_besi_maatregelenblad;

CREATE OR REPLACE VIEW geoweb.v_besi_maatregelenblad
 AS
 SELECT w.urn, w.omschrijving, m.maatregelenblad_tekst FROM besi.maatregelenblad m
JOIN dso.werkzaamheid w on w.id = m.werkzaamheid_id;

ALTER TABLE geoweb.v_besi_maatregelenblad
    OWNER TO anlb;

COMMENT ON VIEW geoweb.v_besi_maatregelenblad
	IS 'This view is being used by the DSO to show the text of the maatregel in the Vergunningchecker'
;
GRANT SELECT ON geoweb.v_besi_maatregelenblad TO besi_dsoapi;
GRANT SELECT ON geoweb.v_besi_maatregelenblad TO besi_readonly;

GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad;