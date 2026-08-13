\echo "Deploying IMNA-10928 Update ambitie add status NNN"

ALTER TABLE IF EXISTS imna.beheer_gebied_ambitie
ADD COLUMN IF NOT EXISTS status_nnn_id bigint NULL;

CREATE INDEX IF NOT EXISTS IXFK_dmn_status_nnn1 ON imna.beheer_gebied_ambitie (status_nnn_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','beheer_gebied_ambitie','FK_dmn_status_nnn1',
'ALTER TABLE imna.beheer_gebied_ambitie ADD CONSTRAINT FK_dmn_status_nnn1
	FOREIGN KEY (status_nnn_id) REFERENCES masterdata.dmn_status_nnn (id) ON DELETE No Action ON UPDATE No Action
;');

COMMENT ON COLUMN imna.beheer_gebied_ambitie.status_nnn_id
	IS 'Domain Id linking to the NNN status of the ambition area.  NNN (Natuur Netwerk Nederland) stands for the national nature network'
;

/* Drop Views */

DROP VIEW IF EXISTS imna.v_gs_beheer_gebied_ambitie CASCADE
;

/* Create Views */

CREATE OR REPLACE VIEW imna.v_gs_beheer_gebied_ambitie AS 
 SELECT ( SELECT btrim((dmn_provincie_code.code)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = s.provincie_id)) AS provincie,
    ( SELECT btrim((dmn_provincie_code.description)::text) AS btrim
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = s.provincie_id)) AS provincie_desc,
    s.subsidie_jaar,
    ( SELECT btrim((dmn_status_beheer_gebied_ambitie.code)::text) AS btrim
           FROM masterdata.dmn_status_beheer_gebied_ambitie
          WHERE (dmn_status_beheer_gebied_ambitie.id = s.status_id)) AS status,
    ( SELECT btrim((dmn_status_beheer_gebied_ambitie.description)::text) AS btrim
           FROM masterdata.dmn_status_beheer_gebied_ambitie
          WHERE (dmn_status_beheer_gebied_ambitie.id = s.status_id)) AS status_desc,
    a.begin_geldigheid,
    NULL::text AS eind_geldigheid,
    btrim((a.identificatie)::text) AS identificatie,
    a.begin_tijd,
    a.eind_tijd,
    ( SELECT btrim((dmn_status_nnn.code)::text) AS btrim
           FROM masterdata.dmn_status_nnn
          WHERE (dmn_status_nnn.id = a.status_nnn_id)) AS status_nnn,
    ( SELECT btrim((dmn_status_nnn.description)::text) AS btrim
           FROM masterdata.dmn_status_nnn
          WHERE (dmn_status_nnn.id = a.status_nnn_id)) AS status_nnn_desc,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'N'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_natuur_ambitie.code)::text) AS btrim
               FROM masterdata.dmn_beheer_type_natuur_ambitie
              WHERE (dmn_beheer_type_natuur_ambitie.id = n.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_grootschaligenatuur.code)::text) AS btrim
               FROM masterdata.dmn_beheer_type_grootschaligenatuur
              WHERE (dmn_beheer_type_grootschaligenatuur.id = g.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_omtevormennatuur_ambitie.code)::text) AS btrim
               FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie
              WHERE (dmn_beheer_type_omtevormennatuur_ambitie.id = v.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_landschap.code)::text) AS btrim
               FROM masterdata.dmn_beheer_type_landschap
              WHERE (dmn_beheer_type_landschap.id = l.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'W'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_water.code)::text) AS btrim
               FROM masterdata.dmn_beheer_type_water
              WHERE (dmn_beheer_type_water.id = w.beheer_type_id))
            ELSE NULL::text
        END AS beheer_type,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'N'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_natuur_ambitie.description)::text) AS btrim
               FROM masterdata.dmn_beheer_type_natuur_ambitie
              WHERE (dmn_beheer_type_natuur_ambitie.id = n.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_grootschaligenatuur.description)::text) AS btrim
               FROM masterdata.dmn_beheer_type_grootschaligenatuur
              WHERE (dmn_beheer_type_grootschaligenatuur.id = g.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_omtevormennatuur_ambitie.description)::text) AS btrim
               FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie
              WHERE (dmn_beheer_type_omtevormennatuur_ambitie.id = v.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_landschap.description)::text) AS btrim
               FROM masterdata.dmn_beheer_type_landschap
              WHERE (dmn_beheer_type_landschap.id = l.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'W'::bpchar))) THEN ( SELECT btrim((dmn_beheer_type_water.description)::text) AS btrim
               FROM masterdata.dmn_beheer_type_water
              WHERE (dmn_beheer_type_water.id = w.beheer_type_id))
            ELSE NULL::text
        END AS beheer_type_desc,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'N'::bpchar))) THEN
            CASE
                WHEN (n.subsidiabel = true) THEN 'Ja'::text
                WHEN (n.subsidiabel = false) THEN 'Nee'::text
                ELSE NULL::text
            END
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN
            CASE
                WHEN (g.subsidiabel = true) THEN 'Ja'::text
                WHEN (g.subsidiabel = false) THEN 'Nee'::text
                ELSE NULL::text
            END
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN
            CASE
                WHEN (v.subsidiabel = true) THEN 'Ja'::text
                WHEN (v.subsidiabel = false) THEN 'Nee'::text
                ELSE NULL::text
            END
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN
            CASE
                WHEN (l.subsidiabel = true) THEN 'Ja'::text
                WHEN (l.subsidiabel = false) THEN 'Nee'::text
                ELSE NULL::text
            END
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'W'::bpchar))) THEN
            CASE
                WHEN (w.subsidiabel = true) THEN 'Ja'::text
                WHEN (w.subsidiabel = false) THEN 'Nee'::text
                ELSE NULL::text
            END
            ELSE NULL::text
        END AS subsidiabel,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN ( SELECT string_agg(((((i.percentage || '% '::text) || (d.code)::text) || ': '::text) || (d.description)::text), '<br>'::text ORDER BY d.code) AS string_agg
               FROM (imna.ambitie_indicatieve_verhouding_beheer_typen_gr i
                 JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON ((d.id = i.beheer_type_id)))
              WHERE (i.ambitie_gebied_id = g.ambitie_gebied_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN ( SELECT string_agg(((((i.percentage || '% '::text) || (d.code)::text) || ': '::text) || (d.description)::text), '<br>'::text ORDER BY d.code) AS string_agg
               FROM (imna.ambitie_indicatieve_verhouding_beheer_typen_vr i
                 JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON ((d.id = i.beheer_type_id)))
              WHERE (i.ambitie_gebied_id = v.ambitie_gebied_id))
            ELSE NULL::text
        END AS indicatieve_verhouding_beheer_typen,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN ( SELECT string_agg((((d.code)::text || ': '::text) || (d.description)::text), '<br>'::text ORDER BY d.code) AS string_agg
               FROM (imna.ambitie_toegestane_beheer_pakketten_landschap pak
                 JOIN masterdata.dmn_beheer_pakket d ON ((d.id = pak.beheer_pakket_id)))
              WHERE (pak.ambitie_gebied_id = l.ambitie_gebied_id))
            ELSE NULL::text
        END AS toegestane_beheer_paketten,
    ((( SELECT pr.value
           FROM masterdata.parameters pr
          WHERE ((pr.name)::text = 'GeoWebSNL-NBPGetPublicFileURL'::text)))::text 
		  || s.subsidie_jaar 
		  || '-' || ( SELECT btrim((dmn_status_plan.code)::text) AS btrim
                        FROM masterdata.dmn_status_plan
                       WHERE (dmn_status_plan.id = s.status_id))
		  || '-' || ( SELECT btrim((dmn_provincie_code.code)::text) AS btrim
                        FROM masterdata.dmn_provincie_code
                       WHERE (dmn_provincie_code.id = s.provincie_id))
		  || '-'|| (( SELECT natuur_beheer_plan.document_link
                        FROM imna.natuur_beheer_plan
                       WHERE natuur_beheer_plan.id = s.plan_id)))::text AS document_link,
    a.geom
   FROM ((((((imna.vm_prov_year_status_beheer_gebied_ambitie s
     JOIN imna.beheer_gebied_ambitie a ON ((a.id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_natuur n ON ((n.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_grootschaligenatuur g ON ((g.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_omtevormennatuur v ON ((v.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_landschap l ON ((l.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_water w ON ((w.ambitie_gebied_id = s.ambitie_gebied_id)));
;


ALTER TABLE IF EXISTS imna.v_gs_beheer_gebied_ambitie
    OWNER to anlb;

GRANT SELECT ON imna.v_gs_beheer_gebied_ambitie TO anlb_sqlpad;

/* Drop Views */

DROP VIEW IF EXISTS imna.v_rvo_beheer_gebied_ambitie CASCADE
;

/* Create Views */

CREATE OR REPLACE VIEW imna.v_rvo_beheer_gebied_ambitie AS 
 SELECT ( SELECT dmn_provincie_code.code
           FROM masterdata.dmn_provincie_code
          WHERE (dmn_provincie_code.id = s.provincie_id)) AS provincie,
    s.subsidie_jaar,
    ( SELECT dmn_status_beheer_gebied_ambitie.code
           FROM masterdata.dmn_status_beheer_gebied_ambitie
          WHERE (dmn_status_beheer_gebied_ambitie.id = s.status_id)) AS status,
    a.begin_geldigheid,
    NULL::text AS eind_geldigheid,
    a.identificatie,
    a.begin_tijd,
    a.eind_tijd,
    ( SELECT dmn_status_nnn.code
           FROM masterdata.dmn_status_nnn
          WHERE (dmn_status_nnn.id = a.status_nnn_id)) AS status_nnn,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'N'::bpchar))) THEN ( SELECT dmn_beheer_type_natuur_ambitie.code
               FROM masterdata.dmn_beheer_type_natuur_ambitie
              WHERE (dmn_beheer_type_natuur_ambitie.id = n.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN ( SELECT dmn_beheer_type_grootschaligenatuur.code
               FROM masterdata.dmn_beheer_type_grootschaligenatuur
              WHERE (dmn_beheer_type_grootschaligenatuur.id = g.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN ( SELECT dmn_beheer_type_omtevormennatuur_ambitie.code
               FROM masterdata.dmn_beheer_type_omtevormennatuur_ambitie
              WHERE (dmn_beheer_type_omtevormennatuur_ambitie.id = v.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN ( SELECT dmn_beheer_type_landschap.code
               FROM masterdata.dmn_beheer_type_landschap
              WHERE (dmn_beheer_type_landschap.id = l.beheer_type_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'W'::bpchar))) THEN ( SELECT dmn_beheer_type_water.code
               FROM masterdata.dmn_beheer_type_water
              WHERE (dmn_beheer_type_water.id = w.beheer_type_id))
            ELSE NULL::bpchar
        END AS beheer_type,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'N'::bpchar))) THEN n.subsidiabel
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN g.subsidiabel
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN v.subsidiabel
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN l.subsidiabel
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'W'::bpchar))) THEN w.subsidiabel
            ELSE NULL::boolean
        END AS subsidiabel,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'G'::bpchar))) THEN ( SELECT string_agg(((i.percentage || '%'::text) || (d.code)::text), ';'::text ORDER BY d.code) AS string_agg
               FROM (imna.ambitie_indicatieve_verhouding_beheer_typen_gr i
                 JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON ((d.id = i.beheer_type_id)))
              WHERE (i.ambitie_gebied_id = g.ambitie_gebied_id))
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'V'::bpchar))) THEN ( SELECT string_agg(((i.percentage || '%'::text) || (d.code)::text), ';'::text ORDER BY d.code) AS string_agg
               FROM (imna.ambitie_indicatieve_verhouding_beheer_typen_vr i
                 JOIN masterdata.dmn_beheer_type_natuur_ambitie d ON ((d.id = i.beheer_type_id)))
              WHERE (i.ambitie_gebied_id = v.ambitie_gebied_id))
            ELSE NULL::text
        END AS indicatieve_verhouding_beheer_typen,
        CASE
            WHEN (a.gebied_type_id = ( SELECT dmn_ambitiegebied_type.id
               FROM masterdata.dmn_ambitiegebied_type
              WHERE (dmn_ambitiegebied_type.code = 'L'::bpchar))) THEN ( SELECT string_agg((d.code)::text, ';'::text ORDER BY ((d.code)::text)) AS string_agg
               FROM (imna.ambitie_toegestane_beheer_pakketten_landschap pak
                 JOIN masterdata.dmn_beheer_pakket d ON ((d.id = pak.beheer_pakket_id)))
              WHERE (pak.ambitie_gebied_id = l.ambitie_gebied_id))
            ELSE NULL::text
        END AS toegestane_beheer_paketten,
    a.geom
   FROM ((((((imna.vm_prov_year_status_beheer_gebied_ambitie s
     JOIN imna.beheer_gebied_ambitie a ON ((a.id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_natuur n ON ((n.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_grootschaligenatuur g ON ((g.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_omtevormennatuur v ON ((v.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_landschap l ON ((l.ambitie_gebied_id = s.ambitie_gebied_id)))
     LEFT JOIN imna.ambitie_water w ON ((w.ambitie_gebied_id = s.ambitie_gebied_id)));
;

ALTER TABLE IF EXISTS imna.v_rvo_beheer_gebied_ambitie
    OWNER to anlb;
GRANT SELECT ON imna.v_rvo_beheer_gebied_ambitie TO anlb_sqlpad;	