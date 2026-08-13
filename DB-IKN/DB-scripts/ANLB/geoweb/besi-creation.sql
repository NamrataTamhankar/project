/* GRANT USAGE ON SCHEMA */
GRANT USAGE ON SCHEMA geoweb TO besi_readonly;
GRANT USAGE ON SCHEMA geoweb TO besi_geoweb;



/* Create Sequences for Besi*/

CREATE SEQUENCE IF NOT EXISTS geoweb.report_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE geoweb.report_seq
    OWNER TO anlb;
	
GRANT USAGE ON SEQUENCE geoweb.report_seq TO besi_geoweb;

/* Create Tables */

CREATE TABLE IF NOT EXISTS geoweb.besi_report_request
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('geoweb.report_seq'::text)::regclass),    -- Report Id
	report_id uuid NOT NULL,    -- IMNA-10158. report_id is an unique id created by geoweb. When the record is being created, the workflow can fetch the record based on this uuid, which enforce the workflow to continue with the correct data for the user who creates the report
	create_date timestamp NOT NULL,    -- Date that the report was requested
	werkzaamheid_id bigint NOT NULL,    -- Id of the activity
	geom geometry(polygon) NOT NULL,    -- Geometry of the surface which was drawn by the user in Geoweb
	grid_ids bigint[] NULL    -- The id's from the basis_grid that intersect the geometry.
)
;

ALTER TABLE geoweb.besi_report_request
    OWNER to anlb;
	
GRANT SELECT ON TABLE geoweb.besi_report_request TO besi_readonly;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_report_request','PK_besi_report_request',
'ALTER TABLE geoweb.besi_report_request ADD CONSTRAINT PK_besi_report_request
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoweb','besi_report_request','UN_besi_report_request_report_id',
'ALTER TABLE geoweb.besi_report_request ADD CONSTRAINT UN_besi_report_request_report_id UNIQUE (report_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_besi_report_request ON geoweb.besi_report_request (id ASC)
;

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE geoweb.besi_report_request
	IS 'This table will be filled from Geoweb and a record will be added when a report is requested.'
;

COMMENT ON COLUMN geoweb.besi_report_request.id
	IS 'Report Id'
;

COMMENT ON COLUMN geoweb.besi_report_request.report_id
	IS 'IMNA-10158. report_id is an unique id created by geoweb. When the record is being created, the workflow can fetch the record based on this uuid, which enforce the workflow to continue with the correct data for the user who creates the report'
;

COMMENT ON COLUMN geoweb.besi_report_request.create_date
	IS 'Date that the report was requested'
;

COMMENT ON COLUMN geoweb.besi_report_request.werkzaamheid_id
	IS 'Id of the activity'
;

COMMENT ON COLUMN geoweb.besi_report_request.geom
	IS 'Geometry of the surface which was drawn by the user in Geoweb'
;

COMMENT ON COLUMN geoweb.besi_report_request.grid_ids
	IS 'The id''s from the basis_grid that intersect the geometry.'
;

/* Create Views */

-- View: geoweb.v_besi_alle_soorten

CREATE OR REPLACE VIEW geoweb.v_besi_alle_soorten
 AS
 SELECT bt.taxa_id AS id,
    nt.identity AS idenity,
    nt.name AS taxa_name,
    nt.scientific AS taxa_scientific_name
   FROM besi.besi_taxa bt
     JOIN ndff.taxa nt ON nt.id = bt.taxa_id
  WHERE bt.publish = true AND bt.valid_from < now() AND (bt.valid_to IS NULL OR bt.valid_to < now())
UNION
 SELECT bs.id,
    bs.identity AS idenity,
    bs.name AS taxa_name,
    bs.scientific AS taxa_scientific_name
   FROM besi.besi_species_group bs
  WHERE bs.publish = true AND bs.valid_from < now() AND (bs.valid_to IS NULL OR bs.valid_to < now());
 
ALTER TABLE geoweb.v_besi_alle_soorten
    OWNER TO anlb;

GRANT SELECT ON TABLE geoweb.v_besi_alle_soorten TO besi_readonly;


COMMENT ON VIEW geoweb.v_besi_alle_soorten
	IS 'This view is used in Besi when a user is selecting the map for a particular specie in Geoweb. The view provides all the species that exist in Besi_taxa witch are published and now is in between valid_from and valid_to'
;

-- View: besi.v_besi_report_header

CREATE OR REPLACE VIEW geoweb.v_besi_report_header
 AS
 SELECT 
	req_one.id as request_id,
	req_one.create_date as request_create_date,
	req_one.werkzaamheid_id as request_werkzaamheid_id,
	req_one.geom as request_geom,
	wz.omschrijving as workitem_description,
	(SELECT code FROM masterdata.dmn_scope WHERE id = wz.scope_id) AS scope_code,
	ST_Area(req_one.geom) AS request_area,
	ST_X(ST_Centroid(req_one.geom)) AS request_x,
	ST_Y(ST_Centroid(req_one.geom)) AS request_y,
	(SELECT VALUE FROM masterdata.parameters WHERE name = 'BesiReportHeader-SoortenregisterURL') AS soortenregister_url,
	(SELECT VALUE FROM masterdata.parameters WHERE name = 'BesiReportHeader-NatuurbeschermingsregelsURL') AS natuurbeschermingsregels_url,
	(SELECT VALUE FROM masterdata.parameters WHERE name = 'BesiReportHeader-Bij12URL') AS bij12_url,
	(SELECT VALUE FROM masterdata.parameters WHERE name = 'BesiReportHeader-Xtime') AS expire_time,
	(SELECT 
		CASE WHEN count(*) > 0 
			THEN true 
			ELSE false 
		END in_natura_2000 
	FROM natura_2000.natura_2000 n
	JOIN natura_2000.natura_2000_gebied ng ON ng.natura_2000_id = n.id
	JOIN geoweb.besi_report_request req_two ON ST_Intersects(ng.geom, req_one.geom) = TRUE
	WHERE n.eind_geldigheid IS NULL)
FROM geoweb.besi_report_request req_one
JOIN dso.werkzaamheid wz ON wz.id = req_one.werkzaamheid_id;
 
ALTER TABLE geoweb.v_besi_report_header
    OWNER TO anlb;
	
GRANT SELECT ON TABLE geoweb.v_besi_report_header TO besi_readonly;

COMMENT ON VIEW geoweb.v_besi_report_header
	IS 'This view is being used when creating the report in Besi. This view contains the headers for the generated report'
;





CREATE INDEX IF NOT EXISTS "IDX_besi_report_request_geom"
ON geoweb.besi_report_request USING gist
(geom)
TABLESPACE pg_default;

/* IMNA-9871 Besi new database user account */
GRANT SELECT, INSERT ON geoweb.besi_report_request TO besi_geoweb;
GRANT SELECT ON geoweb.v_besi_report_header TO besi_geoweb;
--GRANT SELECT ON geoweb.v_besi_soorten_en_adviezen TO besi_geoweb;
--GRANT SELECT ON geoweb.v_besi_beschermde_factor TO besi_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA geoweb TO anlb_sqlpad;