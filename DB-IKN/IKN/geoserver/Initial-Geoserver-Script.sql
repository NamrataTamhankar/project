\echo "Starting deployment of Geoserver schema for IKN automatic deployment"

/* Create Schema if not exists*/
CREATE SCHEMA IF NOT EXISTS geoserver
    AUTHORIZATION ikn;




GRANT USAGE ON SCHEMA geoserver TO ikn_readonly;


/* Create Tables */

/* CREATE TABLE IF NOT EXISTS geoserver.attentiezones_nnn
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

ALTER TABLE geoserver.attentiezones_nnn
    OWNER to ikn; */

CREATE TABLE IF NOT EXISTS geoserver.beleid_totaal_historie
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
	classificatie1_code varchar(20) NULL,
	classificatie1_desc varchar(100) NULL,
	classificatie2_code varchar(20) NULL,
	classificatie2_desc varchar(100) NULL,
	classificatie3_code varchar(20) NULL,
	classificatie3_desc varchar(100) NULL,
	geom geometry(polygon) NOT NULL
);

ALTER TABLE geoserver.beleid_totaal_historie
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.beleid_totaal_historie TO ikn_readonly;

CREATE TABLE IF NOT EXISTS geoserver.beleid_totaal_huidig
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
	classificatie1_code varchar(20) NULL,
	classificatie1_desc varchar(100) NULL,
	classificatie2_code varchar(20) NULL,
	classificatie2_desc varchar(100) NULL,
	classificatie3_code varchar(20) NULL,
	classificatie3_desc varchar(100) NULL,
	geom geometry(polygon) NOT NULL
);

ALTER TABLE geoserver.beleid_totaal_huidig
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.beleid_totaal_huidig TO ikn_readonly;

/* CREATE TABLE IF NOT EXISTS geoserver.beschermd_leefgebied
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

ALTER TABLE geoserver.beschermd_leefgebied
    OWNER to ikn; */


/* CREATE TABLE IF NOT EXISTS geoserver.beschermde_natuurmonumenten
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

ALTER TABLE geoserver.beschermde_natuurmonumenten
    OWNER to ikn; */

/* CREATE TABLE IF NOT EXISTS geoserver.bescherming_houtopstanden
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

ALTER TABLE geoserver.bescherming_houtopstanden
    OWNER to ikn; */

/* CREATE TABLE IF NOT EXISTS geoserver.bijzonder_provinciaal_landschap
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

ALTER TABLE geoserver.bijzonder_provinciaal_landschap
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS geoserver.bos_natuur_buiten_nnn
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

ALTER TABLE geoserver.bos_natuur_buiten_nnn
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.bosreservaten
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

ALTER TABLE geoserver.bosreservaten
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.cultuur_historische_waardenkaart
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

ALTER TABLE geoserver.cultuur_historische_waardenkaart
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.distel_verordening
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

ALTER TABLE geoserver.distel_verordening
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.drone_vlieg_gebieden
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

ALTER TABLE geoserver.drone_vlieg_gebieden
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.duisternis_gebieden
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

ALTER TABLE geoserver.duisternis_gebieden
    OWNER to ikn; */

/* CREATE TABLE IF NOT EXISTS geoserver.ecologiche_verbindingszone
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

ALTER TABLE geoserver.ecologiche_verbindingszone
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.erosie_verordening
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

ALTER TABLE geoserver.erosie_verordening
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.faunabeheereenheid_of_wildbeheereenheid
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

ALTER TABLE geoserver.faunabeheereenheid_of_wildbeheereenheid
    OWNER to ikn; */

CREATE TABLE IF NOT EXISTS geoserver.ganzen_rustgebied
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

ALTER TABLE geoserver.ganzen_rustgebied
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.ganzen_rustgebied TO ikn_readonly;

/* CREATE TABLE IF NOT EXISTS geoserver.grondwater_bescherming
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

ALTER TABLE geoserver.grondwater_bescherming
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.leefgebied_akkervogels
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

ALTER TABLE geoserver.leefgebied_akkervogels
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.leefgebied_weidevogels
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

ALTER TABLE geoserver.leefgebied_weidevogels
    OWNER to ikn;


CREATE TABLE IF NOT EXISTS geoserver.militaire_terreinen
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

ALTER TABLE geoserver.militaire_terreinen
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.nationaal_landschap
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

ALTER TABLE geoserver.nationaal_landschap
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.nationale_parken
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

ALTER TABLE geoserver.nationale_parken
    OWNER to ikn;
	
CREATE TABLE IF NOT EXISTS geoserver.natte_natuurparels
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

ALTER TABLE geoserver.natte_natuurparels
    OWNER to ikn; */
	
CREATE TABLE IF NOT EXISTS geoserver.natura_2000_beheerplannen
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
	richtlijn_code varchar(20) NOT NULL,
	richtlijn_desc varchar(100) NOT NULL,
	geom geometry(polygon) NOT NULL
);

ALTER TABLE geoserver.natura_2000_beheerplannen
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.natura_2000_beheerplannen TO ikn_readonly;

/* CREATE TABLE IF NOT EXISTS geoserver.natura_2000_bufferzone
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

ALTER TABLE geoserver.natura_2000_bufferzone
    OWNER to ikn; */

CREATE TABLE IF NOT EXISTS geoserver.natuur_netwerk_nederland
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

ALTER TABLE geoserver.natuur_netwerk_nederland
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.natuur_netwerk_nederland TO ikn_readonly;

CREATE TABLE IF NOT EXISTS geoserver.natuur_netwerk_rijkswateren
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

ALTER TABLE geoserver.natuur_netwerk_rijkswateren
    OWNER to ikn;
	
GRANT SELECT ON TABLE geoserver.natuur_netwerk_rijkswateren TO ikn_readonly;

/* CREATE TABLE IF NOT EXISTS geoserver.natuur_netwerk_rijkswateren_watervlakken
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

ALTER TABLE geoserver.natuur_netwerk_rijkswateren_watervlakken
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.overgangszone_nnn
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

ALTER TABLE geoserver.overgangszone_nnn
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.stilte_gebieden
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

ALTER TABLE geoserver.stilte_gebieden
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.waardevolle_open_gebieden
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

ALTER TABLE geoserver.waardevolle_open_gebieden
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.waterbergings_gebied
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

ALTER TABLE geoserver.waterbergings_gebied
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.werelderfgoed
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

ALTER TABLE geoserver.werelderfgoed
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.wet_ammoniak_en_veehouderij_gebieden
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

ALTER TABLE geoserver.wet_ammoniak_en_veehouderij_gebieden
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.wezenlijke_waarden_kenmerken_nnn
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

ALTER TABLE geoserver.wezenlijke_waarden_kenmerken_nnn
    OWNER to ikn;

CREATE TABLE IF NOT EXISTS geoserver.zoekgebied_robuuste_verbindingszones
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

ALTER TABLE geoserver.zoekgebied_robuuste_verbindingszones
    OWNER to ikn; */
	
/* Create Primary Keys, Indexes, Uniques, Checks */

/* SELECT pg_temp.create_constraint_if_not_exists ('geoserver','attentiezones_nnn','PK_attentiezones_nnn',
'ALTER TABLE geoserver.attentiezones_nnn ADD CONSTRAINT PK_attentiezones_nnn
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;'); */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','beleid_totaal_historie','PK_beleid_totaal_historie',
'ALTER TABLE geoserver.beleid_totaal_historie ADD CONSTRAINT PK_beleid_totaal_historie
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code,beleid_naam_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','beleid_totaal_huidig','PK_beleid_totaal_huidig',
'ALTER TABLE geoserver.beleid_totaal_huidig ADD CONSTRAINT PK_beleid_totaal_huidig
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code,beleid_naam_code)
;');
	
/* SELECT pg_temp.create_constraint_if_not_exists ('geoserver','beschermd_leefgebied','PK_beschermd_leefgebied',
'ALTER TABLE geoserver.beschermd_leefgebied ADD CONSTRAINT PK_beschermd_leefgebied
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','beschermde_natuurmonumenten','PK_beschermde_natuurmonumenten',
'ALTER TABLE geoserver.beschermde_natuurmonumenten ADD CONSTRAINT PK_beschermde_natuurmonumenten
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','bescherming_houtopstanden','PK_bescherming_houtopstanden',
'ALTER TABLE geoserver.bescherming_houtopstanden ADD CONSTRAINT PK_bescherming_houtopstanden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','bijzonder_provinciaal_landschap','PK_bijzonder_provinciaal_landschap',
'ALTER TABLE geoserver.bijzonder_provinciaal_landschap ADD CONSTRAINT PK_bijzonder_provinciaal_landschap
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','bos_natuur_buiten_nnn','PK_bos_natuur_buiten_nnn',
'ALTER TABLE geoserver.bos_natuur_buiten_nnn ADD CONSTRAINT PK_bos_natuur_buiten_nnn
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','bosreservaten','PK_bosreservaten',
'ALTER TABLE geoserver.bosreservaten ADD CONSTRAINT PK_bosreservaten
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','cultuur_historische_waardenkaart','PK_cultuur_historische_waardenkaart',
'ALTER TABLE geoserver.cultuur_historische_waardenkaart ADD CONSTRAINT PK_cultuur_historische_waardenkaart
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','distel_verordening','PK_distel_verordening',
'ALTER TABLE geoserver.distel_verordening ADD CONSTRAINT PK_distel_verordening
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','drone_vlieg_gebieden','PK_drone_vlieg_gebieden',
'ALTER TABLE geoserver.drone_vlieg_gebieden ADD CONSTRAINT PK_drone_vlieg_gebieden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','duisternis_gebieden','PK_duisternis_gebieden',
'ALTER TABLE geoserver.duisternis_gebieden ADD CONSTRAINT PK_duisternis_gebieden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','ecologiche_verbindingszone','PK_ecologiche_verbindingszone',
'ALTER TABLE geoserver.ecologiche_verbindingszone ADD CONSTRAINT PK_ecologiche_verbindingszone
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','erosie_verordening','PK_erosie_verordening',
'ALTER TABLE geoserver.erosie_verordening ADD CONSTRAINT PK_erosie_verordening
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','faunabeheereenheid_of_wildbeheereenheid','PK_faunabeheereenheid_of_wildbeheereenheid',
'ALTER TABLE geoserver.faunabeheereenheid_of_wildbeheereenheid ADD CONSTRAINT PK_faunabeheereenheid_of_wildbeheereenheid
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;'); */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','ganzen_rustgebied','PK_ganzen_rustgebied',
'ALTER TABLE geoserver.ganzen_rustgebied ADD CONSTRAINT PK_ganzen_rustgebied
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

/* SELECT pg_temp.create_constraint_if_not_exists ('geoserver','grondwater_bescherming','PK_grondwater_bescherming',
'ALTER TABLE geoserver.grondwater_bescherming ADD CONSTRAINT PK_grondwater_bescherming
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','leefgebied_akkervogels','PK_leefgebied_akkervogels',
'ALTER TABLE geoserver.leefgebied_akkervogels ADD CONSTRAINT PK_leefgebied_akkervogels
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','leefgebied_weidevogels','PK_leefgebied_weidevogels',
'ALTER TABLE geoserver.leefgebied_weidevogels ADD CONSTRAINT PK_leefgebied_weidevogels
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','militaire_terreinen','PK_militaire_terreinen',
'ALTER TABLE geoserver.militaire_terreinen ADD CONSTRAINT PK_militaire_terreinen
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','nationaal_landschap','PK_nationaal_landschap',
'ALTER TABLE geoserver.nationaal_landschap ADD CONSTRAINT PK_nationaal_landschap
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','nationale_parken','PK_nationale_parken',
'ALTER TABLE geoserver.nationale_parken ADD CONSTRAINT PK_nationale_parken
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natte_natuurparels','PK_natte_natuurparels',
'ALTER TABLE geoserver.natte_natuurparels ADD CONSTRAINT PK_natte_natuurparels
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;'); */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natura_2000_beheerplannen','PK_natura_2000_beheerplannen',
'ALTER TABLE geoserver.natura_2000_beheerplannen ADD CONSTRAINT PK_natura_2000_beheerplannen
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

/* SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natura_2000_bufferzone','PK_natura_2000_bufferzone',
'ALTER TABLE geoserver.natura_2000_bufferzone ADD CONSTRAINT PK_natura_2000_bufferzone
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;'); */

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natuur_netwerk_nederland','PK_natuur_netwerk_nederland',
'ALTER TABLE geoserver.natuur_netwerk_nederland ADD CONSTRAINT PK_natuur_netwerk_nederland
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natuur_netwerk_rijkswateren','PK_natuur_netwerk_rijkswateren',
'ALTER TABLE geoserver.natuur_netwerk_rijkswateren ADD CONSTRAINT PK_natuur_netwerk_rijkswateren
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

/* SELECT pg_temp.create_constraint_if_not_exists ('geoserver','natuur_netwerk_rijkswateren_watervlakken','PK_natuur_netwerk_rijkswateren_watervlakken',
'ALTER TABLE geoserver.natuur_netwerk_rijkswateren_watervlakken ADD CONSTRAINT PK_natuur_netwerk_rijkswateren_watervlakken
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','overgangszone_nnn','PK_overgangszone_nnn',
'ALTER TABLE geoserver.overgangszone_nnn ADD CONSTRAINT PK_overgangszone_nnn
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','stilte_gebieden','PK_stilte_gebieden',
'ALTER TABLE geoserver.stilte_gebieden ADD CONSTRAINT PK_stilte_gebieden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','waardevolle_open_gebieden','PK_waardevolle_open_gebieden',
'ALTER TABLE geoserver.waardevolle_open_gebieden ADD CONSTRAINT PK_waardevolle_open_gebieden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','waterbergings_gebied','PK_waterbergings_gebied',
'ALTER TABLE geoserver.waterbergings_gebied ADD CONSTRAINT PK_waterbergings_gebied
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','werelderfgoed','PK_werelderfgoed',
'ALTER TABLE geoserver.werelderfgoed ADD CONSTRAINT PK_werelderfgoed
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','wet_ammoniak_en_veehouderij_gebieden','PK_wet_ammoniak_en_veehouderij_gebieden',
'ALTER TABLE geoserver.wet_ammoniak_en_veehouderij_gebieden ADD CONSTRAINT PK_wet_ammoniak_en_veehouderij_gebieden
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','wezenlijke_waarden_kenmerken_nnn','PK_wezenlijke_waarden_kenmerken_nnn',
'ALTER TABLE geoserver.wezenlijke_waarden_kenmerken_nnn ADD CONSTRAINT PK_wezenlijke_waarden_kenmerken_nnn
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');

SELECT pg_temp.create_constraint_if_not_exists ('geoserver','zoekgebied_robuuste_verbindingszones','PK_zoekgebied_robuuste_verbindingszones',
'ALTER TABLE geoserver.zoekgebied_robuuste_verbindingszones ADD CONSTRAINT PK_zoekgebied_robuuste_verbindingszones
	PRIMARY KEY (identificatie,begin_geldigheid,bronhouder_code)
;');
 */
/* Create Views */

-- View: geoserver.bron_specificatie_wfs

-- DROP VIEW geoserver.bron_specificatie_wfs;

/* CREATE OR REPLACE VIEW geoserver.bron_specificatie_wfs AS
SELECT beleid_naam_id,
       (SELECT code FROM masterdata.dmn_beleid_naam WHERE id = beleid_naam_id) AS beleid_naam_code,
	   (SELECT description FROM masterdata.dmn_beleid_naam WHERE id = beleid_naam_id) AS beleid_naam_desc,
	   bronhouder_id,
       (SELECT code FROM masterdata.dmn_bronhouder WHERE id = bronhouder_id) AS bronhouder_code,
	   (SELECT description FROM masterdata.dmn_bronhouder WHERE id = bronhouder_id) AS bronhouder_desc,
	   metadata_url,
	   wfs_end_point,
	   feature_type,
	   laatste_revisie,
	   (case when active = TRUE THEN 'Aan' else 'Uit' end) active,
	   NULL::geometry AS geom	   
  FROM masterdata.bron_specificatie_wfs;
ALTER TABLE geoserver.bron_specificatie_wfs
    OWNER TO ikn;

GRANT SELECT ON TABLE geoserver.bron_specificatie_wfs TO ikn_readonly; */


-- View: geoserver.ikn_upload

-- DROP VIEW geoserver.ikn_upload;

 CREATE OR REPLACE VIEW geoserver.ikn_upload AS
 SELECT ikn_upload.id,
    ikn_upload.informatie_kaart_aanlevering_id,
    ( SELECT dmn_bronhouder.code
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ikn_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder.description
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ikn_upload.bronhouder_id) AS bronhouder_desc,
    ( SELECT dmn_beleid_naam.code
           FROM masterdata.dmn_beleid_naam
          WHERE dmn_beleid_naam.id = ikn_upload.beleid_naam_id) AS beleid_naam_code,
    ( SELECT dmn_beleid_naam.description
           FROM masterdata.dmn_beleid_naam
          WHERE dmn_beleid_naam.id = ikn_upload.beleid_naam_id) AS beleid_naam_desc,
    ( SELECT dmn_bron_type.code
           FROM masterdata.dmn_bron_type
          WHERE dmn_bron_type.id = ikn_upload.bron_type_id) AS bron_type_code,
    ( SELECT dmn_bron_type.description
           FROM masterdata.dmn_bron_type
          WHERE dmn_bron_type.id = ikn_upload.bron_type_id) AS bron_type_desc,
	((((( SELECT parameters.value
           FROM masterdata.parameters
          WHERE parameters.name::text = 'GeoWebIKNGetFileURL'::text))::text) || ikn_upload.id) || '/'::text) || ( SELECT file_name
	 		FROM geoweb.ikn_upload_files 
   			WHERE file_type = 'Bestanden Bundel'
   			AND ikn_upload_id = ikn_upload.id 
			LIMIT 1)::text AS zipfile_url,
    ikn_upload.upload_date,
    ikn_upload.user_id,
    ikn_upload.status,
	ikn_upload.type_run,
	NULL::geometry AS geom
   FROM geoweb.ikn_upload;

ALTER TABLE geoserver.ikn_upload
    OWNER TO ikn;

GRANT SELECT ON TABLE geoserver.ikn_upload TO ikn_readonly;


-- View: geoserver.ikn_upload_files

-- DROP VIEW geoserver.ikn_upload_files;

CREATE OR REPLACE VIEW geoserver.ikn_upload_files AS
 SELECT ikn_upload.id,
    ikn_upload.informatie_kaart_aanlevering_id,
    ( SELECT dmn_bronhouder.code
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ikn_upload.bronhouder_id) AS bronhouder_code,
    ( SELECT dmn_bronhouder.description
           FROM masterdata.dmn_bronhouder
          WHERE dmn_bronhouder.id = ikn_upload.bronhouder_id) AS bronhouder_desc,
    ( SELECT dmn_beleid_naam.code
           FROM masterdata.dmn_beleid_naam
          WHERE dmn_beleid_naam.id = ikn_upload.beleid_naam_id) AS beleid_naam_code,
    ( SELECT dmn_beleid_naam.description
           FROM masterdata.dmn_beleid_naam
          WHERE dmn_beleid_naam.id = ikn_upload.beleid_naam_id) AS beleid_naam_desc,
    ( SELECT dmn_bron_type.code
           FROM masterdata.dmn_bron_type
          WHERE dmn_bron_type.id = ikn_upload.bron_type_id) AS bron_type_code,
    ( SELECT dmn_bron_type.description
           FROM masterdata.dmn_bron_type
          WHERE dmn_bron_type.id = ikn_upload.bron_type_id) AS bron_type_desc,
    ikn_upload.upload_date,
    ikn_upload.user_id,
    ikn_upload_files.file_name,
    ikn_upload_files.file_type,
    ((((( SELECT parameters.value
           FROM masterdata.parameters
          WHERE parameters.name::text = 'GeoWebIKNGetFileURL'::text))::text) || ikn_upload.id) || '/'::text) || ikn_upload_files.file_name::text AS file_url,
	NULL::geometry AS geom
   FROM geoweb.ikn_upload
     JOIN geoweb.ikn_upload_files ON ikn_upload.id = ikn_upload_files.ikn_upload_id;

ALTER TABLE geoserver.ikn_upload_files
    OWNER TO ikn;

GRANT SELECT ON TABLE geoserver.ikn_upload_files TO ikn_readonly;


GRANT ALL ON SCHEMA geoserver TO ikn;
