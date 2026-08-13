\echo "Starting removing datamarts for obsolete policies"

DROP TABLE IF EXISTS geoserver.attentiezones_nnn;
DROP TABLE IF EXISTS geoserver.beschermd_leefgebied;
DROP TABLE IF EXISTS geoserver.beschermde_natuurmonumenten;
DROP TABLE IF EXISTS geoserver.bescherming_houtopstanden;
DROP TABLE IF EXISTS geoserver.bijzonder_provinciaal_landschap;
DROP TABLE IF EXISTS geoserver.bos_natuur_buiten_nnn;
DROP TABLE IF EXISTS geoserver.bosreservaten;
DROP TABLE IF EXISTS geoserver.cultuur_historische_waardenkaart;
DROP TABLE IF EXISTS geoserver.distel_verordening;
DROP TABLE IF EXISTS geoserver.drone_vlieg_gebieden;
DROP TABLE IF EXISTS geoserver.duisternis_gebieden;
DROP TABLE IF EXISTS geoserver.ecologiche_verbindingszone;
DROP TABLE IF EXISTS geoserver.erosie_verordening;
DROP TABLE IF EXISTS geoserver.faunabeheereenheid_of_wildbeheereenheid;
DROP TABLE IF EXISTS geoserver.grondwater_bescherming;
DROP TABLE IF EXISTS geoserver.leefgebied_akkervogels;
DROP TABLE IF EXISTS geoserver.leefgebied_weidevogels;
DROP TABLE IF EXISTS geoserver.militaire_terreinen;
DROP TABLE IF EXISTS geoserver.nationaal_landschap;
DROP TABLE IF EXISTS geoserver.nationale_parken;
DROP TABLE IF EXISTS geoserver.natte_natuurparels;
DROP TABLE IF EXISTS geoserver.natura_2000_bufferzone;
DROP TABLE IF EXISTS geoserver.natuur_netwerk_rijkswateren_watervlakken;
DROP TABLE IF EXISTS geoserver.overgangszone_nnn;
DROP TABLE IF EXISTS geoserver.stilte_gebieden;
DROP TABLE IF EXISTS geoserver.waardevolle_open_gebieden;
DROP TABLE IF EXISTS geoserver.waterbergings_gebied;
DROP TABLE IF EXISTS geoserver.werelderfgoed;
DROP TABLE IF EXISTS geoserver.wet_ammoniak_en_veehouderij_gebieden;
DROP TABLE IF EXISTS geoserver.wezenlijke_waarden_kenmerken_nnn;
DROP TABLE IF EXISTS geoserver.zoekgebied_robuuste_verbindingszones;



CREATE TABLE IF NOT EXISTS geoserver.bijzonder_provinciaal_natuurgebied
(
	identificatie varchar(100) NOT NULL,
	begin_geldigheid date NOT NULL,
	eind_geldigheid date NULL,
	beleid_type_code varchar(20) NOT NULL,
	beleid_type_desc varchar(100) NOT NULL,
	beleid_naam_code varchar(20) NOT NULL,
	beleid_naam_desc varchar(100) NOT NULL,
	beleid_naam_bronhouder varchar(100) NOT NULL,
	beleid_bron_naam varchar(100) NOT NULL,
	beleid_bron_datum timestamp NOT NULL,
	beleid_bron_datum_txt varchar(10) NOT NULL,
	beleid_bron_url varchar(255) NOT NULL,
	bronhouder_code varchar(20) NOT NULL,
	bronhouder_desc varchar(100) NOT NULL,
	geom geometry(polygon) NOT NULL
);

ALTER TABLE geoserver.bijzonder_provinciaal_natuurgebied
    OWNER to ikn;

GRANT SELECT ON TABLE geoserver.bijzonder_provinciaal_natuurgebied TO ikn_readonly;

CREATE TABLE IF NOT EXISTS geoserver.leefgebied_boerenlandvogels
(
	identificatie varchar(100) NOT NULL,
	begin_geldigheid date NOT NULL,
	eind_geldigheid date NULL,
	beleid_type_code varchar(20) NOT NULL,
	beleid_type_desc varchar(100) NOT NULL,
	beleid_naam_code varchar(20) NOT NULL,
	beleid_naam_desc varchar(100) NOT NULL,
	beleid_naam_bronhouder varchar(100) NOT NULL,
	beleid_bron_naam varchar(100) NOT NULL,
	beleid_bron_datum timestamp NOT NULL,
	beleid_bron_datum_txt varchar(10) NOT NULL,
	beleid_bron_url varchar(255) NOT NULL,
	bronhouder_code varchar(20) NOT NULL,
	bronhouder_desc varchar(100) NOT NULL,
	geom geometry(polygon) NOT NULL
);

ALTER TABLE geoserver.leefgebied_boerenlandvogels
    OWNER to ikn; 
	
GRANT SELECT ON TABLE geoserver.leefgebied_boerenlandvogels TO ikn_readonly;	
	
SELECT pg_temp.create_constraint_if_not_exists ('geoserver','bijzonder_provinciaal_natuurgebied','PK_bijzonder_provinciaal_natuurgebied',
'ALTER TABLE geoserver.bijzonder_provinciaal_natuurgebied ADD CONSTRAINT PK_bijzonder_provinciaal_natuurgebied
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','leefgebied_boerenlandvogels','PK_leefgebied_boerenlandvogels',
'ALTER TABLE geoserver.leefgebied_boerenlandvogels ADD CONSTRAINT PK_leefgebied_boerenlandvogels
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');




DROP VIEW IF EXISTS geoserver.bron_specificatie_wfs;

CREATE OR REPLACE VIEW geoserver.bron_specificatie_wfs AS
SELECT wfs.beleid_naam_id,
       (SELECT code FROM masterdata.dmn_beleid_naam WHERE id = wfs.beleid_naam_id) AS beleid_naam_code,
	   (SELECT description FROM masterdata.dmn_beleid_naam WHERE id = wfs.beleid_naam_id) AS beleid_naam_desc,
	   wfs.bronhouder_id,
       (SELECT code FROM masterdata.dmn_bronhouder WHERE id = wfs.bronhouder_id) AS bronhouder_code,
	   (SELECT description FROM masterdata.dmn_bronhouder WHERE id = wfs.bronhouder_id) AS bronhouder_desc,
	   wfs.metadata_url,
	   wfs.wfs_end_point,
	   wfs.feature_type,
	   wfs.laatste_revisie,
	   (case when wfs.active = TRUE THEN 'Aan' else 'Uit' end) active,
	   bs.valid_to,
	   bs.valid_from,
	   NULL::geometry AS geom	   
  FROM masterdata.bron_specificatie_wfs wfs
  JOIN masterdata.bron_specificatie bs on bs.beleid_naam_id = wfs.beleid_naam_id and bs.bronhouder_id = wfs.bronhouder_id;
ALTER TABLE geoserver.bron_specificatie_wfs
    OWNER TO ikn;

GRANT ALL ON TABLE geoserver.bron_specificatie_wfs TO ikn;
GRANT SELECT ON TABLE geoserver.bron_specificatie_wfs TO ikn_readonly;