\echo "Deploying IMNA-18664 Update view imna.bes_reports"


CREATE OR REPLACE VIEW imna.bes_reports AS 
 SELECT r.id,
    r.begin_geldigheid,
    r.eind_geldigheid,
    r.provincie_id,
    r.beheer_jaar
   FROM imna.beschikking_rapportage r
  WHERE (NOT (EXISTS ( SELECT 1
           FROM imna.beschikking_rapportage r_prev
          WHERE ((r.provincie_id = r_prev.provincie_id) AND (r.beheer_jaar = r_prev.beheer_jaar) AND (r.begin_geldigheid < r_prev.begin_geldigheid)))));

ALTER TABLE imna.bes_reports
    OWNER TO anlb;

GRANT SELECT ON imna.bes_reports TO anlb_sqlpad;	