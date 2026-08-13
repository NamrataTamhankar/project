\echo "Starting deployment of GeoServer - Natura 2000 Creation"

CREATE TABLE IF NOT EXISTS geoserver.natura_2000
(
	nummer integer NOT NULL,    -- = natura_2000.nummer
	volgnummer integer NOT NULL,    -- = natura_2000_gebied.volg_nummer
	naam varchar(110) NULL,    -- = natura_2000.nummer + '; ' +natura_2000.naam
	begin_geldigheid timestamp NULL,    -- = natura_2000.begin_geldigheid
	voortouwnemer_code varchar(20) NULL,    -- = dmn_bronhouder.code using n2000.gebied_voortouwnemer
	voortouwnemer_desc varchar(100) NULL,    -- = dmn_bronhouder.description using n2000.gebied_voortouwnemer
	beheerplan_datum date NULL,    -- = natura_2000.beheerplan_datum
	beheerplan_url varchar(1024) NULL,    -- = natura_2000.beheerplan_url
	overbelasting_stikstof boolean NULL,    -- = natura_2000.overbelasting_stikstof
	oppervlakte_totaal decimal(10,2) NULL,    -- = natura_2000.oppervlakte_totaal
	oppervlakte_hr_totaal decimal(10,2) NULL,    -- = natura_2000.oppervlakte_hr
	oppervlakte_vr_totaal decimal(10,2) NULL,    -- = natura_2000.oppervlakte_vr
	natura_2000_type_code varchar(20) NULL,    -- =  natura_2000_gebied -> dmn_natura_2000_type.code
	natura_2000_type_desc varchar(100) NULL,    -- =  natura_2000_gebied -> dmn_natura_2000_type.description
	vhn_new integer NULL,    -- =  natura_2000_gebied.vhn_new
	sitecode_v varchar(24) NULL,    -- =  natura_2000_gebied.sitecode_v
	sitecode_h varchar(24) NULL,    -- =  natura_2000_gebied.sitecode_h
	status text NULL,    -- =  natura_2000_gebied.status
	kadaster varchar(24) NULL,    -- =  natura_2000_gebied.kadaster
	staatscourant varchar(24) NULL,    -- =  natura_2000_gebied.staatscourant
	doelstellingen text NULL,    -- = (SELECT STRING_AGG ((SELECT code FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id) || ' - ' || 						   (SELECT description FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id) ||  						   'linefeed' , 				   ',' 				   ORDER by (SELECT code FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id)) 		FROM natura_2000.natura_2000_habitat_doelstelling d  		WHERE d.natura_2000_id = n.id ) 
	oppervlakte_gebied double precision NULL,    -- =   ST_Area(natura_2000_gebied.geom)
	more_info varchar(50) NULL,    -- = 'https://www.natura2000.nl/ '
	geom geometry NULL    -- =  natura_2000_gebied.geom
)
;
ALTER TABLE geoserver.natura_2000
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natura_2000','PK_natura_2000',
'ALTER TABLE geoserver.natura_2000 ADD CONSTRAINT PK_natura_2000
	PRIMARY KEY (nummer,volgnummer)
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON COLUMN geoserver.natura_2000.nummer
	IS '= natura_2000.nummer'
;

COMMENT ON COLUMN geoserver.natura_2000.volgnummer
	IS '= natura_2000_gebied.volg_nummer'
;

COMMENT ON COLUMN geoserver.natura_2000.naam
	IS '= natura_2000.nummer + ''; '' +natura_2000.naam'
;

COMMENT ON COLUMN geoserver.natura_2000.begin_geldigheid
	IS '= natura_2000.begin_geldigheid'
;

COMMENT ON COLUMN geoserver.natura_2000.voortouwnemer_code
	IS '= dmn_bronhouder.code using n2000.gebied_voortouwnemer'
;

COMMENT ON COLUMN geoserver.natura_2000.voortouwnemer_desc
	IS '= dmn_bronhouder.description using n2000.gebied_voortouwnemer'
;

COMMENT ON COLUMN geoserver.natura_2000.beheerplan_datum
	IS '= natura_2000.beheerplan_datum'
;

COMMENT ON COLUMN geoserver.natura_2000.beheerplan_url
	IS '= natura_2000.beheerplan_url'
;

COMMENT ON COLUMN geoserver.natura_2000.overbelasting_stikstof
	IS '= natura_2000.overbelasting_stikstof'
;

COMMENT ON COLUMN geoserver.natura_2000.oppervlakte_totaal
	IS '= natura_2000.oppervlakte_totaal'
;

COMMENT ON COLUMN geoserver.natura_2000.oppervlakte_hr_totaal
	IS '= natura_2000.oppervlakte_hr'
;

COMMENT ON COLUMN geoserver.natura_2000.oppervlakte_vr_totaal
	IS '= natura_2000.oppervlakte_vr'
;

COMMENT ON COLUMN geoserver.natura_2000.natura_2000_type_code
	IS '=  natura_2000_gebied -> dmn_natura_2000_type.code'
;

COMMENT ON COLUMN geoserver.natura_2000.natura_2000_type_desc
	IS '=  natura_2000_gebied -> dmn_natura_2000_type.description'
;

COMMENT ON COLUMN geoserver.natura_2000.vhn_new
	IS '=  natura_2000_gebied.vhn_new'
;

COMMENT ON COLUMN geoserver.natura_2000.sitecode_v
	IS '=  natura_2000_gebied.sitecode_v'
;

COMMENT ON COLUMN geoserver.natura_2000.sitecode_h
	IS '=  natura_2000_gebied.sitecode_h'
;

COMMENT ON COLUMN geoserver.natura_2000.status
	IS '=  natura_2000_gebied.status'
;

COMMENT ON COLUMN geoserver.natura_2000.kadaster
	IS '=  natura_2000_gebied.kadaster'
;

COMMENT ON COLUMN geoserver.natura_2000.staatscourant
	IS '=  natura_2000_gebied.staatscourant'
;

COMMENT ON COLUMN geoserver.natura_2000.doelstellingen
	IS '= (SELECT STRING_AGG ((SELECT code FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id) || '' - '' || 						   (SELECT description FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id) ||  						   ''linefeed'' , 				   '','' 				   ORDER by (SELECT code FROM masterdata.dmn_habitat_type WHERE id = d.habitat_type_id)) 		FROM natura_2000.natura_2000_habitat_doelstelling d  		WHERE d.natura_2000_id = n.id ) '
;

COMMENT ON COLUMN geoserver.natura_2000.oppervlakte_gebied
	IS '=   ST_Area(natura_2000_gebied.geom)'
;

COMMENT ON COLUMN geoserver.natura_2000.more_info
	IS '= ''https://www.natura2000.nl/ '''
;

COMMENT ON COLUMN geoserver.natura_2000.geom
	IS '=  natura_2000_gebied.geom'
;

GRANT SELECT ON ALL TABLES IN SCHEMA geoserver TO anlb_sqlpad
;