\echo "Starting deployment of NDVH IMNA-5837 - Vegetation IMNA"

/* GRANT USAGE ON SCHEMA */
GRANT USAGE ON SCHEMA imna TO ndvh_geoweb;

/* Create Tables */

CREATE TABLE IF NOT EXISTS imna.lokale_toevoeging
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the local additions 
	identificatie char(100) NOT NULL,    -- Uniek  nummer van de toevoeging  Unique number of the addition
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	toevoeging_naam text NOT NULL,    -- Naam van de toevoeging  Name of the additional information
	toevoeging_toelichting text NOT NULL,    -- Toelichting van de toevoeging  Explanation of the addition
	toevoeging_code text NOT NULL,    -- Code van de toevoeging  Code of the addition
	toevoeging_code_naam text NOT NULL    -- Naam van de code van de toevoeging  Name of the code
)
;
ALTER TABLE imna.lokale_toevoeging
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.soort_kartering
(
	vegetatie_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation
	soort_code_id bigint NOT NULL,    -- Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list
	abundantie_schaal_code_id bigint NULL,    -- Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation
	aantals_klasse_code_id bigint NULL,    -- Code van de aantallen van een gekozen aantalsklasse schema  Code of the number class of the observation
	bedekkings_percentage integer NULL,    -- Percentage van de bedekking van de waargenomen soort  Percentage coverage of the observed plant species
	abundantie_schaal_schema_vegetatie_soort_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon
	aantals_klasse_schema_vegetatie_soort_id bigint NOT NULL    -- Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon
)
;
ALTER TABLE imna.soort_kartering
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.soort_waarneming
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the plant species observations 
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	identificatie char(100) NOT NULL,    -- Uniek nummer van de waarneming  Unique number of the observation
	veld_situatie_datum timestamp NOT NULL,    -- Datum waarop de soort is waargenomen  Observationdate of the species
	aantals_klasse_code_id bigint NULL,    -- Code van de aantallen van een gekozen aantalsklasse schema  Code of the number class of the observation
	abundantie_schaal_code_id bigint NULL,    -- Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation
	bedekkings_percentage integer NULL,    -- Percentage van de bedekking van de waargenomen soort  Percentage coverage of the observation
	soort_code_id bigint NOT NULL,    -- Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list
	geometrie geometry NOT NULL,    -- Locatie van waarneming van de plantensoort  Location of the observation of the plant species
	abundantie_schaal_schema_waarneming_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van een plantensoort als losse waarneming aan te geven  Reference to the coverage scheme used to indicate the coverage of a plant species
	aantals_klasse_schema_waarneming_id bigint NOT NULL    -- Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen  van een plantensoort als losse waarneming aan te geven  Reference to the abundance scheme used to indicate the numbers of a plant species 
)
;
ALTER TABLE imna.soort_waarneming
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the vegetation
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	identificatie char(100) NOT NULL,    -- Uniek nummer van het vegetatievlak  Unique number of the vegetationpolygon
	veld_situatie_datum timestamp NULL,    -- Datum waarop het vegetatievlak is gelabeld  Date on which the inventory in the field was determined
	opmerking text NULL,    -- Algemene opmerking over het vegetatievlak  General remarks concerning the vegetation
	geometrie geometry NOT NULL,    -- Locatie van de vegetatie  Location of the vegetation
	abundantie_schaal_schema_vegetatie_soort_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon
	aantals_klasse_schema_vegetatie_soort_id bigint NOT NULL,    -- Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon
	abundantie_schaal_schema_vegetatie_vegetatie_id bigint NOT NULL    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon
)
;
ALTER TABLE imna.vegetatie
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_documentatie
(
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	document_naam varchar(1024) NOT NULL,    -- naam van het document  Name of the document
	document_uri varchar(1024) NOT NULL,    -- URI verwijzing naar het document  Reference to the document by means of a URI
	verantwoordings_document boolean NOT NULL,    -- Document waarin de vegetatiekartering wordt verantwoord. De gebruikte lokale typologie en vertalingen naar de landelijke typen worden hierin beschreven. Dit document is van belang om de vegetatiekartering te kunnen beoordelen.  Document that justifies the vegetationmapping. The used local typology and the translation to the national vegetation scheme is described. This document is important to understand the mapping. 
	bron_bestand boolean NOT NULL    -- Originele bestand dat is geuploaded.   Original file that was uploaded.
)
;
ALTER TABLE imna.vegetatie_documentatie
    OWNER to anlb;

CREATE OR REPLACE FUNCTION imna.default_package_kwaliteit_id() 
RETURNS bigint LANGUAGE SQL AS $$ 
SELECT id FROM masterdata.dmn_package_kwaliteit WHERE code = 'N'; 
$$;
ALTER FUNCTION imna.default_package_kwaliteit_id()
    OWNER TO anlb;



CREATE TABLE IF NOT EXISTS imna.vegetatie_kartering_package
(
	identificatie char(100) NOT NULL,    -- Uniek nummer van de package  Unique number of the package
	begin_geldigheid timestamp NOT NULL,    -- Gegenereerde datum om de package historie bij te houden  Generated date to keep track of package history
	eind_geldigheid timestamp NULL,    -- Gegenereerde datum om de package historie bij te houden  Generated date to keep track of package history
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the vegetation package
	begin_tijd timestamp NOT NULL,    -- Startdatum van de geldigheid van de package  Start date of the period in which the package is valid
	eind_tijd timestamp NULL,    -- Einddatum van de geldigheid van de package  End date of the period in which the package is valid
	package_bronhouder_id bigint NOT NULL,    -- Organisatie die de rechten van de kartering heeft en eindverantwoordelijk is voor de kwaliteit  Organization that holds the rights of the vegetation map and is responsible for the quality of it 
	package_inwinner varchar(255) NOT NULL,    -- Organisatie die de vegetatiekartering heeft uitgevoerd  Organization or individual responsible for the collection of the data
	package_kwaliteit_id bigint NOT NULL DEFAULT imna.default_package_kwaliteit_id(),    -- Kwaliteitslabel van de kartering  Quality label of the package
	package_kwaliteit_door varchar(20) NULL,
	package_kwaliteit_op timestamp with time zone NULL,
	package_naam text NULL,    -- Naam van de kartering  Name of the package
	package_omschrijving text NULL,    -- Omschrijving van de kartering  Description of the package
	vegetatie_karterings_protocol_id bigint NOT NULL,    -- Vegetatiekartering protocol dat is gebruikt voor het uitvoeren van de kartering  Protocol that was used for the data collection in the field
	package_geometrie geometry NOT NULL,    -- Geometrische begrenzing van de kartering  Geometrical boundary of the research area of the package
	vast_gesteld boolean NOT NULL   DEFAULT false,    -- Hiermee wordt aangegeven dat de kartering publiekelijk gebruik mag worden  Field to indicate whether a package can be viewed publicly
	vast_gesteld_door varchar(20) NULL,
	vast_gesteld_op timestamp without time zone NULL,
	ingediend_door varchar(20) NOT NULL,
	abundantie_schaal_schema_opname_soort_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)
	abundantie_schaal_schema_vegetatie_soort_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon
	aantals_klasse_schema_vegetatie_soort_id bigint NOT NULL,    -- Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon
	abundantie_schaal_schema_vegetatie_vegetatie_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon
	abundantie_schaal_schema_waarneming_id bigint NOT NULL,    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van een plantensoort als losse waarneming aan te geven  Reference to the coverage scheme used to indicate the coverage of a plant species
	aantals_klasse_schema_waarneming_id bigint NOT NULL,    -- Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen  van een plantensoort als losse waarneming aan te geven  Reference to the abundance scheme used to indicate the numbers of a plant species 
	vegetatie_type_landelijk_schema_id bigint NOT NULL    -- Verwijzing naar het schema dat is gebruikt om de landelijke typologie mee aan te geven in deze kartering  Reference to the national scheme used to define the national vegetation type
)
;
ALTER TABLE imna.vegetatie_kartering_package
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_laag_bedekking
(
	vegetatie_opname_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation samples (relevés)
	vegetatie_laag_type_id bigint NOT NULL,    -- Geeft aan om welke vegetatielaag het gaat (bv struik of kruidlaag)  Indicates the layer that is estimated
	vegetatie_laag_bedekking integer NOT NULL    -- Geeft de bedekking van de betreffende laag aan in procenten  Coverage of the vegetation layer
)
;
ALTER TABLE imna.vegetatie_laag_bedekking
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_laag_hoogte
(
	vegetatie_opname_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation samples (relevés)
	vegetatie_laag_hoogte_type_id bigint NOT NULL,    -- Geeft aan om welke vegetatielaag het gaat (bv struik of kruidlaag)  Indicates the layer that is estimated
	vegetatie_laag_hoogte numeric(9,3) NOT NULL    -- (verticale) hoogte van de laag in meters  Height of the vegetation layer
)
;
ALTER TABLE imna.vegetatie_laag_hoogte
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_opname
(
	identificatie char(100) NOT NULL,    -- Uniek nummer van de opname   Unique number of the vegetationsample (relevé)
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the vegetation samples (relevés)
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	veld_situatie_datum timestamp NOT NULL,    -- Datum waarop de vegetatie-opname is gemaakt.  Date of the vegetationsample (relevé)
	vegetatie_type_lokaal_naar_landelijk_id bigint NOT NULL,    -- Vegetatietype volgens de lokaal gebruikte set aan vegetatietypen  Vegetation typing in accordance with the local typology the vegetation sample was used to justify this local type
	cryptogamen_geidentificeerd boolean NULL,    -- Attribuut om aan te geven of (korst)mossen zijn gedetermineerd en meegenomen in de opname  Attribute that can be used to indicate whether cryptogams ((lichen) mosses) have been identified or not
	expositie text NULL,    -- (wind) expositie van de vegetatie-opname  Wind direction to which the vegetation on a slope is directed
	waarnemer text NOT NULL,    -- Persoon die de opname in het veld heeft gemaakt  Person that collected the data of the sample
	inclinatie integer NULL,    -- Hellingshoek van de vegetatie-opname  Inclination angle of the slope on which the vegetation is observed
	oppervlakte numeric(9,3) NOT NULL,    -- Totale oppervlakte van de vegetatie-opname  Surface area of a vegetation sample (relevé)
	opmerking text NULL,    -- Algemene opmerking over de vegetatie-opname  General remarks concerning the vegetation sample (relevé)
	geometrie geometry NOT NULL,    -- Locatie van de vegetatie-opname  Location of the vegetation sample (relevé) 
	abundantie_schaal_schema_opname_soort_id bigint NOT NULL    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)
)
;
ALTER TABLE imna.vegetatie_opname
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_opname_soort
(
	vegetatie_opname_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation samples (relevés)
	soort_code_id bigint NOT NULL,    -- Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list
	vegetatie_stratum_id bigint NOT NULL,    -- Vegetatielaag waarin de plantensoort is aangetroffen Een eik kan bijvoorbeeld worden waargenomen in de boomlaag als volwassen boom, als struik in de struiklaag of  als juveniel in de kruidlaag   Vegetation layer where the species was observed For example an oak can be observed as a tree in the tree-layer, as a shrub in the shrub layer and as a juvenile in the herb layer
	abundantie_schaal_code_id bigint NOT NULL,    -- Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation
	abundantie_schaal_schema_opname_soort_id bigint NOT NULL    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)
)
;
ALTER TABLE imna.vegetatie_opname_soort
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_toevoeging
(
	toevoeging_id bigint NOT NULL,    -- Uniek  nummer van de toevoeging  Unique number referring tot lokaletoevoeging-identificatie
	vegetatie_id bigint NOT NULL    -- ID linking to  the internal id of the vegetation
)
;
ALTER TABLE imna.vegetatie_toevoeging
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_type_landelijk
(
	vegetatie_opname_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation samples (relevés)
	vegetatie_type_landelijk_id bigint NOT NULL    -- Code van het vegetatietype volgens één van de landelijke typologieën  Code of the vegetation type in accordance with one of the national vegetation schemes
)
;
ALTER TABLE imna.vegetatie_type_landelijk
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_type_lokaal_met_bedekking
(
	vegetatie_id bigint NOT NULL,    -- ID linking to  the internal id of the vegetation
	abundantie_schaal_code_id bigint NULL,    -- Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation
	vegetatie_type_lokaal_naar_landelijk_id bigint NOT NULL,    -- Lokale type (code)  Vegetation type (code) in accordance with the local typology
	bedekkings_percentage integer NOT NULL,    -- Percentage van de bedekking van het desbetreffende vegetatietype  Percentage coverage of the observation
	abundantie_schaal_schema_vegetatie_vegetatie_id bigint NOT NULL    -- Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon
)
;
ALTER TABLE imna.vegetatie_type_lokaal_met_bedekking
    OWNER to anlb;

CREATE TABLE IF NOT EXISTS imna.vegetatie_type_lokaal_naar_landelijk
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('imna_seq'::text)::regclass),    -- Internal ID of the local vegetation types 
	package_id bigint NOT NULL,    -- ID linking to  the internal id of  the vegetation package
	vegetatie_type_lokaal varchar(255) NOT NULL,    -- Lokale type (code)  Vegetation type (code) in accordance with the local typology
	vegetatie_type_lokaal_naam text NOT NULL,    -- Naam van het lokale type  Name of the local type
	vegetatie_type_landelijk_id bigint NOT NULL,    -- Vegetatietype volgens één van de landelijke typologieën  Vegetation type in accordance with one of the national vegetation schemes
	vegetatie_type_landelijk_schema_id bigint NOT NULL,    -- Verwijzing naar het schema dat is gebruikt om de landelijke typologie mee aan te geven in deze kartering  Reference to the national scheme used to define the national vegetation type
	vegetatie_type_landelijk_alternatief_id bigint NULL    -- Alternatief Vegetatietype volgens één van de landelijke typologieën  Alternative Vegetation type in accordance with one of the national vegetation schemes
)
;
ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('imna','lokale_toevoeging','PK_lokale_toevoeging',
'ALTER TABLE imna.lokale_toevoeging ADD CONSTRAINT PK_lokale_toevoeging
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','lokale_toevoeging','UN_lokale_toevoeging_identificatie',
'ALTER TABLE imna.lokale_toevoeging ADD CONSTRAINT UN_lokale_toevoeging_identificatie UNIQUE (package_id,identificatie)
;');

CREATE INDEX IF NOT EXISTS IXFK_lokale_toevoeging_vegetatie_kartering_package ON imna.lokale_toevoeging (package_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_kartering','PK_soort_kartering',
'ALTER TABLE imna.soort_kartering ADD CONSTRAINT PK_soort_kartering
	PRIMARY KEY (vegetatie_id,soort_code_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_soort_kartering_abundance_code_klasse_code ON imna.soort_kartering (aantals_klasse_schema_vegetatie_soort_id ASC,aantals_klasse_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_kartering_abundance_code_schaal_code ON imna.soort_kartering (abundantie_schaal_schema_vegetatie_soort_id ASC,abundantie_schaal_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_kartering_dmn_vegetatie_taxa ON imna.soort_kartering (soort_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_kartering_vegetatie ON imna.soort_kartering (vegetatie_id ASC,abundantie_schaal_schema_vegetatie_soort_id ASC,aantals_klasse_schema_vegetatie_soort_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','PK_soort_waarneming',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT PK_soort_waarneming
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','UN_soort_waarneming_identificatie',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT UN_soort_waarneming_identificatie UNIQUE (package_id,identificatie)
;');

CREATE INDEX IF NOT EXISTS IXFK_soort_waarneming_abundance_code_aantal_klasse_code ON imna.soort_waarneming (aantals_klasse_schema_waarneming_id ASC,aantals_klasse_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_waarneming_abundance_code_abundantie_schaal_code ON imna.soort_waarneming (abundantie_schaal_schema_waarneming_id ASC,abundantie_schaal_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_waarneming_dmn_vegetatie_taxa ON imna.soort_waarneming (soort_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_soort_waarneming_dmn_vegetatie_taxa_02 ON imna.soort_waarneming (soort_code_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie','PK_vegetatie',
'ALTER TABLE imna.vegetatie ADD CONSTRAINT PK_vegetatie
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie','UN_vegetatie_identificatie',
'ALTER TABLE imna.vegetatie ADD CONSTRAINT UN_vegetatie_identificatie UNIQUE (package_id,identificatie)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie','UN_vegetatie_soort_kartering_key',
'ALTER TABLE imna.vegetatie ADD CONSTRAINT UN_vegetatie_soort_kartering_key UNIQUE (id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie','UN_vegatatie_vegetatie_type_lokaal_met_bedekking_key',
'ALTER TABLE imna.vegetatie ADD CONSTRAINT UN_vegatatie_vegetatie_type_lokaal_met_bedekking_key UNIQUE (id,abundantie_schaal_schema_vegetatie_vegetatie_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_vegetatie_kartering_package ON imna.vegetatie (package_id ASC,abundantie_schaal_schema_vegetatie_soort_id ASC,aantals_klasse_schema_vegetatie_soort_id ASC,abundantie_schaal_schema_vegetatie_vegetatie_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_documentatie','PK_vegetatie_documentatie',
'ALTER TABLE imna.vegetatie_documentatie ADD CONSTRAINT PK_vegetatie_documentatie
	PRIMARY KEY (package_id,document_naam)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_documentatie_vegetatie_kartering_package ON imna.vegetatie_documentatie (package_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','PK_vegetatie_kartering_package',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT PK_vegetatie_kartering_package
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','UN_vegetatie_package_identifcatie',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT UN_vegetatie_package_identifcatie UNIQUE (identificatie,begin_geldigheid)
;');

/* IMNA-11881 Start Remove
SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','UN_vegetatie_opname_key',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT UN_vegetatie_opname_key UNIQUE (id,abundantie_schaal_schema_opname_soort_id)
;');
IMNA-11881 End Remove*/

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','UN_vegetatie_key',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT UN_vegetatie_key UNIQUE (id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id,abundantie_schaal_schema_vegetatie_vegetatie_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','UN_soort_waarneming_key',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT UN_soort_waarneming_key UNIQUE (id,abundantie_schaal_schema_waarneming_id,aantals_klasse_schema_waarneming_id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','UN_vegetatie_type_lokaal_naar_landelijk_key',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT UN_vegetatie_type_lokaal_naar_landelijk_key UNIQUE (id,vegetatie_type_landelijk_schema_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_aantal_srt ON imna.vegetatie_kartering_package (aantals_klasse_schema_vegetatie_soort_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_aantal_wrn ON imna.vegetatie_kartering_package (aantals_klasse_schema_waarneming_id ASC)
;

/* IMNA-11881 Start Remove
CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_opname_soort ON imna.vegetatie_kartering_package (abundantie_schaal_schema_opname_soort_id ASC)
;
IMNA-11881 End Remove*/

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_vegetatie ON imna.vegetatie_kartering_package (abundantie_schaal_schema_vegetatie_vegetatie_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_vegetatie_srt ON imna.vegetatie_kartering_package (abundantie_schaal_schema_vegetatie_soort_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_abundance_schema_waarneming ON imna.vegetatie_kartering_package (abundantie_schaal_schema_waarneming_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_dmn_bronhouder_vegetatie ON imna.vegetatie_kartering_package (package_bronhouder_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_dmn_package_kwaliteit ON imna.vegetatie_kartering_package (package_kwaliteit_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_dmn_protocol ON imna.vegetatie_kartering_package (vegetatie_karterings_protocol_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_kartering_package_vegetatie_type_schema ON imna.vegetatie_kartering_package (vegetatie_type_landelijk_schema_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_bedekking','PK_vegetatie_laag_bedekking',
'ALTER TABLE imna.vegetatie_laag_bedekking ADD CONSTRAINT PK_vegetatie_laag_bedekking
	PRIMARY KEY (vegetatie_laag_type_id,vegetatie_opname_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_laag_bedekking_dmn_vegetatie_laag_type ON imna.vegetatie_laag_bedekking (vegetatie_laag_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_laag_bedekking_vegetatie_opname ON imna.vegetatie_laag_bedekking (vegetatie_opname_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_hoogte','PK_vegetatie_laag_hoogte',
'ALTER TABLE imna.vegetatie_laag_hoogte ADD CONSTRAINT PK_vegetatie_laag_hoogte
	PRIMARY KEY (vegetatie_opname_id,vegetatie_laag_hoogte_type_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_laag_hoogte_dmn_vegetatie_hoogte_type ON imna.vegetatie_laag_hoogte (vegetatie_laag_hoogte_type_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_laag_hoogte_vegetatie_opname ON imna.vegetatie_laag_hoogte (vegetatie_opname_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname','PK_vegetatie_opname',
'ALTER TABLE imna.vegetatie_opname ADD CONSTRAINT PK_vegetatie_opname
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname','UN_vegetatie_opname_identificatie',
'ALTER TABLE imna.vegetatie_opname ADD CONSTRAINT UN_vegetatie_opname_identificatie UNIQUE (package_id,identificatie)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname','UN_vegetatie_opname_soort_key',
'ALTER TABLE imna.vegetatie_opname ADD CONSTRAINT UN_vegetatie_opname_soort_key UNIQUE (id,abundantie_schaal_schema_opname_soort_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_vegetatie_kartering_package ON imna.vegetatie_opname (package_id ASC,abundantie_schaal_schema_opname_soort_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_vegetatie_type_lokaal_naar_landelijk ON imna.vegetatie_opname (vegetatie_type_lokaal_naar_landelijk_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname_soort','PK_vegetatie_opname_soort',
'ALTER TABLE imna.vegetatie_opname_soort ADD CONSTRAINT PK_vegetatie_opname_soort
	PRIMARY KEY (vegetatie_opname_id,soort_code_id,vegetatie_stratum_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_soort_abundance_code ON imna.vegetatie_opname_soort (abundantie_schaal_schema_opname_soort_id ASC,abundantie_schaal_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_soort_dmn_strata ON imna.vegetatie_opname_soort (vegetatie_stratum_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_soort_dmn_vegetatie_taxa ON imna.vegetatie_opname_soort (soort_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_opname_soort_vegetatie_opname ON imna.vegetatie_opname_soort (vegetatie_opname_id ASC,abundantie_schaal_schema_opname_soort_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_toevoeging','PK_vegetatie_toevoeging',
'ALTER TABLE imna.vegetatie_toevoeging ADD CONSTRAINT PK_vegetatie_toevoeging
	PRIMARY KEY (toevoeging_id,vegetatie_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_toevoeging_lokale_toevoeging ON imna.vegetatie_toevoeging (toevoeging_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_toevoeging_vegetatie ON imna.vegetatie_toevoeging (vegetatie_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_landelijk','PK_vegetatie_type_landelijk',
'ALTER TABLE imna.vegetatie_type_landelijk ADD CONSTRAINT PK_vegetatie_type_landelijk
	PRIMARY KEY (vegetatie_opname_id,vegetatie_type_landelijk_id)
;
');
CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_landelijk_vegetatie_opname ON imna.vegetatie_type_landelijk (vegetatie_opname_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_landelijk_vegetatie_type ON imna.vegetatie_type_landelijk (vegetatie_type_landelijk_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_met_bedekking','PK_vegetatie_type_lokaal_met_bedekking',
'ALTER TABLE imna.vegetatie_type_lokaal_met_bedekking ADD CONSTRAINT PK_vegetatie_type_lokaal_met_bedekking
	PRIMARY KEY (vegetatie_id,vegetatie_type_lokaal_naar_landelijk_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lok_m_bedekking_vgt_type_lok_naar_landelijk ON imna.vegetatie_type_lokaal_met_bedekking (vegetatie_type_lokaal_naar_landelijk_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lokaal_met_bedekking_abundance_code ON imna.vegetatie_type_lokaal_met_bedekking (abundantie_schaal_schema_vegetatie_vegetatie_id ASC,abundantie_schaal_code_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lokaal_met_bedekking_dmn_vegetatie_hoogte ON imna.vegetatie_type_lokaal_met_bedekking (abundantie_schaal_code_id ASC)
;

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_naar_landelijk','PK_vegetatie_type_lokaal_naar_landelijk',
'ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk ADD CONSTRAINT PK_vegetatie_type_lokaal_naar_landelijk
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_naar_landelijk','UN_vegetatie_type_lokaal_naar_landelijk_identificatie',
'ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk ADD CONSTRAINT UN_vegetatie_type_lokaal_naar_landelijk_identificatie UNIQUE (package_id,vegetatie_type_lokaal,vegetatie_type_landelijk_schema_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type ON imna.vegetatie_type_lokaal_naar_landelijk (vegetatie_type_landelijk_schema_id ASC,vegetatie_type_landelijk_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type_02 ON imna.vegetatie_type_lokaal_naar_landelijk (vegetatie_type_landelijk_schema_id ASC,vegetatie_type_landelijk_alternatief_id ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_vegetatie_type_lokaal_naar_landelijk_vgt_kartering_package ON imna.vegetatie_type_lokaal_naar_landelijk (package_id ASC,vegetatie_type_landelijk_schema_id ASC)
;

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('imna','lokale_toevoeging','FK_lokale_toevoeging_vegetatie_kartering_package',
'ALTER TABLE imna.lokale_toevoeging ADD CONSTRAINT FK_lokale_toevoeging_vegetatie_kartering_package
	FOREIGN KEY (package_id) REFERENCES imna.vegetatie_kartering_package (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_kartering','FK_soort_kartering_abundance_code',
'ALTER TABLE imna.soort_kartering ADD CONSTRAINT FK_soort_kartering_abundance_code
	FOREIGN KEY (abundantie_schaal_schema_vegetatie_soort_id,abundantie_schaal_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_kartering','FK_soort_kartering_abundance_code_02',
'ALTER TABLE imna.soort_kartering ADD CONSTRAINT FK_soort_kartering_abundance_code_02
	FOREIGN KEY (aantals_klasse_schema_vegetatie_soort_id,aantals_klasse_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_kartering','FK_soort_kartering_dmn_vegetatie_taxa',
'ALTER TABLE imna.soort_kartering ADD CONSTRAINT FK_soort_kartering_dmn_vegetatie_taxa
	FOREIGN KEY (soort_code_id) REFERENCES masterdata.dmn_vegetatie_taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_kartering','FK_soort_kartering_vegetatie',
'ALTER TABLE imna.soort_kartering ADD CONSTRAINT FK_soort_kartering_vegetatie
	FOREIGN KEY (vegetatie_id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id) REFERENCES imna.vegetatie (id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','FK_soort_waarneming_abundance_code_aantal_klasse_code',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT FK_soort_waarneming_abundance_code_aantal_klasse_code
	FOREIGN KEY (aantals_klasse_schema_waarneming_id,aantals_klasse_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','FK_soort_waarneming_abundance_code_abundantie_schaal_code',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT FK_soort_waarneming_abundance_code_abundantie_schaal_code
	FOREIGN KEY (abundantie_schaal_schema_waarneming_id,abundantie_schaal_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','FK_soort_waarneming_dmn_vegetatie_taxa',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT FK_soort_waarneming_dmn_vegetatie_taxa
	FOREIGN KEY (soort_code_id) REFERENCES masterdata.dmn_vegetatie_taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','soort_waarneming','FK_soort_waarneming_vegetatie_kartering_package',
'ALTER TABLE imna.soort_waarneming ADD CONSTRAINT FK_soort_waarneming_vegetatie_kartering_package
	FOREIGN KEY (package_id,abundantie_schaal_schema_waarneming_id,aantals_klasse_schema_waarneming_id) REFERENCES imna.vegetatie_kartering_package (id,abundantie_schaal_schema_waarneming_id,aantals_klasse_schema_waarneming_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie','FK_vegetatie_vegetatie_kartering_package',
'ALTER TABLE imna.vegetatie ADD CONSTRAINT FK_vegetatie_vegetatie_kartering_package
	FOREIGN KEY (package_id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id,abundantie_schaal_schema_vegetatie_vegetatie_id) REFERENCES imna.vegetatie_kartering_package (id,abundantie_schaal_schema_vegetatie_soort_id,aantals_klasse_schema_vegetatie_soort_id,abundantie_schaal_schema_vegetatie_vegetatie_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_documentatie','FK_vegetatie_documentatie_vegetatie_kartering_package',
'ALTER TABLE imna.vegetatie_documentatie ADD CONSTRAINT FK_vegetatie_documentatie_vegetatie_kartering_package
	FOREIGN KEY (package_id) REFERENCES imna.vegetatie_kartering_package (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_aantal_srt',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_aantal_srt
	FOREIGN KEY (aantals_klasse_schema_vegetatie_soort_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_aantal_wrn',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_aantal_wrn
	FOREIGN KEY (aantals_klasse_schema_waarneming_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');

/* IMNA-11881 Start Remove
SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_opname_soort',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_opname_soort
	FOREIGN KEY (abundantie_schaal_schema_opname_soort_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');
IMNA-11881 End Remove*/

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_vegetatie',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_vegetatie
	FOREIGN KEY (abundantie_schaal_schema_vegetatie_vegetatie_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_vegetatie_srt',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_vegetatie_srt
	FOREIGN KEY (abundantie_schaal_schema_vegetatie_soort_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_abundance_schema_waarneming',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_abundance_schema_waarneming
	FOREIGN KEY (abundantie_schaal_schema_waarneming_id) REFERENCES ndff.abundance_schema (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_dmn_bronhouder_vegetatie',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_dmn_bronhouder_vegetatie
	FOREIGN KEY (package_bronhouder_id) REFERENCES masterdata.dmn_bronhouder_vegetatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_dmn_package_kwaliteit',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_dmn_package_kwaliteit
	FOREIGN KEY (package_kwaliteit_id) REFERENCES masterdata.dmn_package_kwaliteit (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_dmn_protocol',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_dmn_protocol
	FOREIGN KEY (vegetatie_karterings_protocol_id) REFERENCES masterdata.dmn_protocol (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_kartering_package','FK_vegetatie_kartering_package_vegetatie_type_schema',
'ALTER TABLE imna.vegetatie_kartering_package ADD CONSTRAINT FK_vegetatie_kartering_package_vegetatie_type_schema
	FOREIGN KEY (vegetatie_type_landelijk_schema_id) REFERENCES synbiosys.vegetatie_type_schema (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_bedekking','FK_vegetatie_laag_bedekking_dmn_vegetatie_laag_type',
'ALTER TABLE imna.vegetatie_laag_bedekking ADD CONSTRAINT FK_vegetatie_laag_bedekking_dmn_vegetatie_laag_type
	FOREIGN KEY (vegetatie_laag_type_id) REFERENCES masterdata.dmn_vegetatie_laag_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_bedekking','FK_vegetatie_laag_bedekking_vegetatie_opname',
'ALTER TABLE imna.vegetatie_laag_bedekking ADD CONSTRAINT FK_vegetatie_laag_bedekking_vegetatie_opname
	FOREIGN KEY (vegetatie_opname_id) REFERENCES imna.vegetatie_opname (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_hoogte','FK_vegetatie_laag_hoogte_dmn_vegetatie_hoogte_type',
'ALTER TABLE imna.vegetatie_laag_hoogte ADD CONSTRAINT FK_vegetatie_laag_hoogte_dmn_vegetatie_hoogte_type
	FOREIGN KEY (vegetatie_laag_hoogte_type_id) REFERENCES masterdata.dmn_vegetatie_hoogte_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_laag_hoogte','FK_vegetatie_laag_hoogte_vegetatie_opname',
'ALTER TABLE imna.vegetatie_laag_hoogte ADD CONSTRAINT FK_vegetatie_laag_hoogte_vegetatie_opname
	FOREIGN KEY (vegetatie_opname_id) REFERENCES imna.vegetatie_opname (id) ON DELETE No Action ON UPDATE No Action
;');

/* IMNA-7686 Start remove
SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname','FK_vegetatie_opname_vegetatie_kartering_package',
'ALTER TABLE imna.vegetatie_opname ADD CONSTRAINT FK_vegetatie_opname_vegetatie_kartering_package
	FOREIGN KEY (package_id,abundantie_schaal_schema_opname_soort_id) REFERENCES imna.vegetatie_kartering_package (id,abundantie_schaal_schema_opname_soort_id) ON DELETE No Action ON UPDATE No Action
;');
IMNA-7686 End Remove */

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname','FK_vegetatie_opname_vegetatie_type_lokaal_naar_landelijk',
'ALTER TABLE imna.vegetatie_opname ADD CONSTRAINT FK_vegetatie_opname_vegetatie_type_lokaal_naar_landelijk
	FOREIGN KEY (vegetatie_type_lokaal_naar_landelijk_id) REFERENCES imna.vegetatie_type_lokaal_naar_landelijk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname_soort','FK_vegetatie_opname_soort_abundance_code',
'ALTER TABLE imna.vegetatie_opname_soort ADD CONSTRAINT FK_vegetatie_opname_soort_abundance_code
	FOREIGN KEY (abundantie_schaal_schema_opname_soort_id,abundantie_schaal_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname_soort','FK_vegetatie_opname_soort_dmn_strata',
'ALTER TABLE imna.vegetatie_opname_soort ADD CONSTRAINT FK_vegetatie_opname_soort_dmn_strata
	FOREIGN KEY (vegetatie_stratum_id) REFERENCES masterdata.dmn_strata (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname_soort','FK_vegetatie_opname_soort_dmn_vegetatie_taxa',
'ALTER TABLE imna.vegetatie_opname_soort ADD CONSTRAINT FK_vegetatie_opname_soort_dmn_vegetatie_taxa
	FOREIGN KEY (soort_code_id) REFERENCES masterdata.dmn_vegetatie_taxa (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_opname_soort','FK_vegetatie_opname_soort_vegetatie_opname',
'ALTER TABLE imna.vegetatie_opname_soort ADD CONSTRAINT FK_vegetatie_opname_soort_vegetatie_opname
	FOREIGN KEY (vegetatie_opname_id,abundantie_schaal_schema_opname_soort_id) REFERENCES imna.vegetatie_opname (id,abundantie_schaal_schema_opname_soort_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_toevoeging','FK_vegetatie_toevoeging_lokale_toevoeging',
'ALTER TABLE imna.vegetatie_toevoeging ADD CONSTRAINT FK_vegetatie_toevoeging_lokale_toevoeging
	FOREIGN KEY (toevoeging_id) REFERENCES imna.lokale_toevoeging (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_toevoeging','FK_vegetatie_toevoeging_vegetatie',
'ALTER TABLE imna.vegetatie_toevoeging ADD CONSTRAINT FK_vegetatie_toevoeging_vegetatie
	FOREIGN KEY (vegetatie_id) REFERENCES imna.vegetatie (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_landelijk','FK_vegetatie_type_landelijk_vegetatie_opname',
'ALTER TABLE imna.vegetatie_type_landelijk ADD CONSTRAINT FK_vegetatie_type_landelijk_vegetatie_opname
	FOREIGN KEY (vegetatie_opname_id) REFERENCES imna.vegetatie_opname (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_landelijk','FK_vegetatie_type_landelijk_vegetatie_type',
'ALTER TABLE imna.vegetatie_type_landelijk ADD CONSTRAINT FK_vegetatie_type_landelijk_vegetatie_type
	FOREIGN KEY (vegetatie_type_landelijk_id) REFERENCES synbiosys.vegetatie_type (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_met_bedekking','FK_vegetatie_type_lok_met_bedekking_vgt_type_lok_naar_landelijk',
'ALTER TABLE imna.vegetatie_type_lokaal_met_bedekking ADD CONSTRAINT FK_vegetatie_type_lok_met_bedekking_vgt_type_lok_naar_landelijk
	FOREIGN KEY (vegetatie_type_lokaal_naar_landelijk_id) REFERENCES imna.vegetatie_type_lokaal_naar_landelijk (id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_met_bedekking','FK_vegetatie_type_lokaal_met_bedekking_abundance_code',
'ALTER TABLE imna.vegetatie_type_lokaal_met_bedekking ADD CONSTRAINT FK_vegetatie_type_lokaal_met_bedekking_abundance_code
	FOREIGN KEY (abundantie_schaal_schema_vegetatie_vegetatie_id,abundantie_schaal_code_id) REFERENCES ndff.abundance_code (abundance_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_met_bedekking','FK_vegetatie_type_lokaal_met_bedekking_vegetatie',
'ALTER TABLE imna.vegetatie_type_lokaal_met_bedekking ADD CONSTRAINT FK_vegetatie_type_lokaal_met_bedekking_vegetatie
	FOREIGN KEY (vegetatie_id,abundantie_schaal_schema_vegetatie_vegetatie_id) REFERENCES imna.vegetatie (id,abundantie_schaal_schema_vegetatie_vegetatie_id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_naar_landelijk','FK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type',
'ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk ADD CONSTRAINT FK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type
	FOREIGN KEY (vegetatie_type_landelijk_schema_id,vegetatie_type_landelijk_id) REFERENCES synbiosys.vegetatie_type (vegetatie_type_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_naar_landelijk','FK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type_02',
'ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk ADD CONSTRAINT FK_vegetatie_type_lokaal_naar_landelijk_vegetatie_type_02
	FOREIGN KEY (vegetatie_type_landelijk_schema_id,vegetatie_type_landelijk_alternatief_id) REFERENCES synbiosys.vegetatie_type (vegetatie_type_schema_id,id) ON DELETE No Action ON UPDATE No Action
;');

SELECT pg_temp.create_constraint_if_not_exists ('imna','vegetatie_type_lokaal_naar_landelijk','FK_vegetatie_type_lokaal_naar_landelijk_vgt_kartering_package',
'ALTER TABLE imna.vegetatie_type_lokaal_naar_landelijk ADD CONSTRAINT FK_vegetatie_type_lokaal_naar_landelijk_vgt_kartering_package
	FOREIGN KEY (package_id,vegetatie_type_landelijk_schema_id) REFERENCES imna.vegetatie_kartering_package (id,vegetatie_type_landelijk_schema_id) ON DELETE No Action ON UPDATE No Action
;');

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE imna.lokale_toevoeging
	IS 'Definitie van de lokale toevoegingen  Definition of local additions '
;

COMMENT ON COLUMN imna.lokale_toevoeging.id
	IS 'Internal ID of the local additions '
;

COMMENT ON COLUMN imna.lokale_toevoeging.identificatie
	IS 'Uniek  nummer van de toevoeging  Unique number of the addition'
;

COMMENT ON COLUMN imna.lokale_toevoeging.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

/* IMNA-11955 Start remove
COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_naam
	IS 'Naam van de toevoeging  Name of the additional information'
;

COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_toelichting
	IS 'Toelichting van de toevoeging  Explanation of the addition'
;

COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_code
	IS 'Code van de toevoeging  Code of the addition'
;

COMMENT ON COLUMN imna.lokale_toevoeging.toevoeging_code_naam
	IS 'Naam van de code van de toevoeging  Name of the code'
;
IMNA-11955 End Remove*/ 

COMMENT ON TABLE imna.soort_kartering
	IS 'Bedekking van bepaalde plantensoorten in het vegetatievlak  Coverage of certain plant species in the vegetation polygon'
;

COMMENT ON COLUMN imna.soort_kartering.vegetatie_id
	IS 'ID linking to  the internal id of the vegetation'
;

COMMENT ON COLUMN imna.soort_kartering.soort_code_id
	IS 'Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list'
;

COMMENT ON COLUMN imna.soort_kartering.abundantie_schaal_code_id
	IS 'Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation'
;

COMMENT ON COLUMN imna.soort_kartering.aantals_klasse_code_id
	IS 'Code van de aantallen van een gekozen aantalsklasse schema  Code of the number class of the observation'
;

/* IMNA-12039 Start remove
COMMENT ON COLUMN imna.soort_kartering.bedekkings_percentage
	IS 'Percentage van de bedekking van de waargenomen soort  Percentage coverage of the observed plant species'
;
IMNA-12039 End Remove*/ 

COMMENT ON COLUMN imna.soort_kartering.abundantie_schaal_schema_vegetatie_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon'
;

COMMENT ON COLUMN imna.soort_kartering.aantals_klasse_schema_vegetatie_soort_id
	IS 'Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon'
;

COMMENT ON TABLE imna.soort_waarneming
	IS 'Geeft de mogelijkheid om plantwaarnemingen toe te voegen de kartering  Enables the possibility to add plant species observations to the package'
;

COMMENT ON COLUMN imna.soort_waarneming.id
	IS 'Internal ID of the plant species observations '
;

COMMENT ON COLUMN imna.soort_waarneming.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

COMMENT ON COLUMN imna.soort_waarneming.identificatie
	IS 'Uniek nummer van de waarneming  Unique number of the observation'
;

COMMENT ON COLUMN imna.soort_waarneming.veld_situatie_datum
	IS 'Datum waarop de soort is waargenomen  Observationdate of the species'
;

COMMENT ON COLUMN imna.soort_waarneming.aantals_klasse_code_id
	IS 'Code van de aantallen van een gekozen aantalsklasse schema  Code of the number class of the observation'
;

COMMENT ON COLUMN imna.soort_waarneming.abundantie_schaal_code_id
	IS 'Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation'
;

COMMENT ON COLUMN imna.soort_waarneming.bedekkings_percentage
	IS 'Percentage van de bedekking van de waargenomen soort  Percentage coverage of the observation'
;

COMMENT ON COLUMN imna.soort_waarneming.soort_code_id
	IS 'Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list'
;

COMMENT ON COLUMN imna.soort_waarneming.geometrie
	IS 'Locatie van waarneming van de plantensoort  Location of the observation of the plant species'
;

COMMENT ON COLUMN imna.soort_waarneming.abundantie_schaal_schema_waarneming_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van een plantensoort als losse waarneming aan te geven  Reference to the coverage scheme used to indicate the coverage of a plant species'
;

COMMENT ON COLUMN imna.soort_waarneming.aantals_klasse_schema_waarneming_id
	IS 'Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen  van een plantensoort als losse waarneming aan te geven  Reference to the abundance scheme used to indicate the numbers of a plant species '
;

COMMENT ON TABLE imna.vegetatie
	IS 'Een geografisch begrensd gebied met een karakteristieke groep planten (plantengemeenschap)  A geographical area with a characteristic group of plants '
;

COMMENT ON COLUMN imna.vegetatie.id
	IS 'Internal ID of the vegetation'
;

COMMENT ON COLUMN imna.vegetatie.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie.identificatie
	IS 'Uniek nummer van het vegetatievlak  Unique number of the vegetationpolygon'
;

COMMENT ON COLUMN imna.vegetatie.veld_situatie_datum
	IS 'Datum waarop het vegetatievlak is gelabeld  Date on which the inventory in the field was determined'
;

COMMENT ON COLUMN imna.vegetatie.opmerking
	IS 'Algemene opmerking over het vegetatievlak  General remarks concerning the vegetation'
;

COMMENT ON COLUMN imna.vegetatie.geometrie
	IS 'Locatie van de vegetatie  Location of the vegetation'
;

COMMENT ON COLUMN imna.vegetatie.abundantie_schaal_schema_vegetatie_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon'
;

COMMENT ON COLUMN imna.vegetatie.aantals_klasse_schema_vegetatie_soort_id
	IS 'Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon'
;

COMMENT ON COLUMN imna.vegetatie.abundantie_schaal_schema_vegetatie_vegetatie_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon'
;

COMMENT ON TABLE imna.vegetatie_documentatie
	IS 'verzameling documenten die horen bij de vegetatiekartering  collection of documents related to the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie_documentatie.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie_documentatie.document_naam
	IS 'naam van het document  Name of the document'
;

COMMENT ON COLUMN imna.vegetatie_documentatie.document_uri
	IS 'URI verwijzing naar het document  Reference to the document by means of a URI'
;

COMMENT ON COLUMN imna.vegetatie_documentatie.verantwoordings_document
	IS 'Document waarin de vegetatiekartering wordt verantwoord. De gebruikte lokale typologie en vertalingen naar de landelijke typen worden hierin beschreven. Dit document is van belang om de vegetatiekartering te kunnen beoordelen.  Document that justifies the vegetationmapping. The used local typology and the translation to the national vegetation scheme is described. This document is important to understand the mapping. '
;

COMMENT ON COLUMN imna.vegetatie_documentatie.bron_bestand
	IS 'Originele bestand dat is geuploaded.   Original file that was uploaded.'
;

COMMENT ON TABLE imna.vegetatie_kartering_package
	IS 'Een gebundelde set coherente gegevens over vegetatie De gegevens worden verzameld en geanalyseerd binnen een bepaald gebied en in een bepaalde tijdsperiode  A bundled set of coherent data about vegetation The data is collected and analysed within a defined area and period'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.identificatie
	IS 'Uniek nummer van de package  Unique number of the package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.begin_geldigheid
	IS 'Gegenereerde datum om de package historie bij te houden  Generated date to keep track of package history'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.eind_geldigheid
	IS 'Gegenereerde datum om de package historie bij te houden  Generated date to keep track of package history'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.id
	IS 'Internal ID of the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.begin_tijd
	IS 'Startdatum van de geldigheid van de package  Start date of the period in which the package is valid'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.eind_tijd
	IS 'Einddatum van de geldigheid van de package  End date of the period in which the package is valid'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_bronhouder_id
	IS 'Organisatie die de rechten van de kartering heeft en eindverantwoordelijk is voor de kwaliteit  Organization that holds the rights of the vegetation map and is responsible for the quality of it '
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_inwinner
	IS 'Organisatie die de vegetatiekartering heeft uitgevoerd  Organization or individual responsible for the collection of the data'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_kwaliteit_id
	IS 'Kwaliteitslabel van de kartering  Quality label of the package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_naam
	IS 'Naam van de kartering  Name of the package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_omschrijving
	IS 'Omschrijving van de kartering  Description of the package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.vegetatie_karterings_protocol_id
	IS 'Vegetatiekartering protocol dat is gebruikt voor het uitvoeren van de kartering  Protocol that was used for the data collection in the field'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.package_geometrie
	IS 'Geometrische begrenzing van de kartering  Geometrical boundary of the research area of the package'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.vast_gesteld
	IS 'Hiermee wordt aangegeven dat de kartering publiekelijk gebruik mag worden  Field to indicate whether a package can be viewed publicly'
;
/* IMNA-11881 Start remove
COMMENT ON COLUMN imna.vegetatie_kartering_package.abundantie_schaal_schema_opname_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)'
;
IMNA-11881 End remove*/

COMMENT ON COLUMN imna.vegetatie_kartering_package.abundantie_schaal_schema_vegetatie_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van soorten in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverages of species in a vegetation polygon'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.aantals_klasse_schema_vegetatie_soort_id
	IS 'Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen planten van een bepaalde soort in een vegetatievlak aan te geven  Reference to the abundance scheme used to indicate the numbers of plants of a particular species in a vegetation polygon'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.abundantie_schaal_schema_vegetatie_vegetatie_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.abundantie_schaal_schema_waarneming_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen van een plantensoort als losse waarneming aan te geven  Reference to the coverage scheme used to indicate the coverage of a plant species'
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.aantals_klasse_schema_waarneming_id
	IS 'Verwijzing naar het aantalsklassen schema dat is gebruikt om de aantallen  van een plantensoort als losse waarneming aan te geven  Reference to the abundance scheme used to indicate the numbers of a plant species '
;

COMMENT ON COLUMN imna.vegetatie_kartering_package.vegetatie_type_landelijk_schema_id
	IS 'Verwijzing naar het schema dat is gebruikt om de landelijke typologie mee aan te geven in deze kartering  Reference to the national scheme used to define the national vegetation type'
;

COMMENT ON TABLE imna.vegetatie_laag_bedekking
	IS 'In een vegetatieopname wordt de bedekking ingeschat van verschillende vegetatielagen Voorbeelden zijn oa kruidlaag, boomlaag en percentage vegetatieloos  In a vegetation sample (Relevé) the coverage of different vegetation layers is estimated Examples are herb- and tree layer or coverage with no vegetation'
;

COMMENT ON COLUMN imna.vegetatie_laag_bedekking.vegetatie_opname_id
	IS 'ID linking to  the internal id of the vegetation samples (relevés)'
;

COMMENT ON COLUMN imna.vegetatie_laag_bedekking.vegetatie_laag_type_id
	IS 'Geeft aan om welke vegetatielaag het gaat (bv struik of kruidlaag)  Indicates the layer that is estimated'
;

COMMENT ON COLUMN imna.vegetatie_laag_bedekking.vegetatie_laag_bedekking
	IS 'Geeft de bedekking van de betreffende laag aan in procenten  Coverage of the vegetation layer'
;

COMMENT ON TABLE imna.vegetatie_laag_hoogte
	IS 'In een vegetatieopname wordt de hoogte ingeschat van verschillende vegetatielagen Voorbeelden zijn oa kruidlaag en boomlaag  In a vegetation sample (Relevé) the height of different vegetation layers is estimated Examples are herb- and tree layer'
;

COMMENT ON COLUMN imna.vegetatie_laag_hoogte.vegetatie_opname_id
	IS 'ID linking to  the internal id of the vegetation samples (relevés)'
;

COMMENT ON COLUMN imna.vegetatie_laag_hoogte.vegetatie_laag_hoogte_type_id
	IS 'Geeft aan om welke vegetatielaag het gaat (bv struik of kruidlaag)  Indicates the layer that is estimated'
;

COMMENT ON COLUMN imna.vegetatie_laag_hoogte.vegetatie_laag_hoogte
	IS '(verticale) hoogte van de laag in meters  Height of the vegetation layer'
;

COMMENT ON TABLE imna.vegetatie_opname
	IS 'Maakt het mogelijk om vegetatie-opnamen toe te voegen aan de kartering. Deze opnamen zijn een wezenlijk onderdeel van een kartering en worden gebruikt om de gebruikte typologie te onderbouwen en deze te kunnen vertalen naar een landelijke typologie  Enables the possibility to add vegetation samples (relevés) These samples are used to justify the local vegetation types and the translation to a national scheme'
;

COMMENT ON COLUMN imna.vegetatie_opname.identificatie
	IS 'Uniek nummer van de opname   Unique number of the vegetationsample (relevé)'
;

COMMENT ON COLUMN imna.vegetatie_opname.id
	IS 'Internal ID of the vegetation samples (relevés)'
;

COMMENT ON COLUMN imna.vegetatie_opname.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie_opname.veld_situatie_datum
	IS 'Datum waarop de vegetatie-opname is gemaakt.  Date of the vegetationsample (relevé)'
;

COMMENT ON COLUMN imna.vegetatie_opname.vegetatie_type_lokaal_naar_landelijk_id
	IS 'Vegetatietype volgens de lokaal gebruikte set aan vegetatietypen  Vegetation typing in accordance with the local typology the vegetation sample was used to justify this local type'
;

COMMENT ON COLUMN imna.vegetatie_opname.cryptogamen_geidentificeerd
	IS 'Attribuut om aan te geven of (korst)mossen zijn gedetermineerd en meegenomen in de opname  Attribute that can be used to indicate whether cryptogams ((lichen) mosses) have been identified or not'
;

COMMENT ON COLUMN imna.vegetatie_opname.expositie
	IS '(wind) expositie van de vegetatie-opname  Wind direction to which the vegetation on a slope is directed'
;

COMMENT ON COLUMN imna.vegetatie_opname.waarnemer
	IS 'Persoon die de opname in het veld heeft gemaakt  Person that collected the data of the sample'
;

COMMENT ON COLUMN imna.vegetatie_opname.inclinatie
	IS 'Hellingshoek van de vegetatie-opname  Inclination angle of the slope on which the vegetation is observed'
;

COMMENT ON COLUMN imna.vegetatie_opname.oppervlakte
	IS 'Totale oppervlakte van de vegetatie-opname  Surface area of a vegetation sample (relevé)'
;

COMMENT ON COLUMN imna.vegetatie_opname.opmerking
	IS 'Algemene opmerking over de vegetatie-opname  General remarks concerning the vegetation sample (relevé)'
;

COMMENT ON COLUMN imna.vegetatie_opname.geometrie
	IS 'Locatie van de vegetatie-opname  Location of the vegetation sample (relevé) '
;

COMMENT ON COLUMN imna.vegetatie_opname.abundantie_schaal_schema_opname_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)'
;

COMMENT ON TABLE imna.vegetatie_opname_soort
	IS 'Dit betreft de soorten die in een vegetatie-opname zijn waargenomen met een bepaalde bedekking  These are the species encountered in the vegetation sample (Relevé) with a certain coverage'
;

COMMENT ON COLUMN imna.vegetatie_opname_soort.vegetatie_opname_id
	IS 'ID linking to  the internal id of the vegetation samples (relevés)'
;

COMMENT ON COLUMN imna.vegetatie_opname_soort.soort_code_id
	IS 'Code van de waargenomen plantensoort uit het bijbehorende schema (NDFF taxa list) voor soorten  Reference to the species code of the observed species from the NDFF taxa list'
;

COMMENT ON COLUMN imna.vegetatie_opname_soort.vegetatie_stratum_id
	IS 'Vegetatielaag waarin de plantensoort is aangetroffen Een eik kan bijvoorbeeld worden waargenomen in de boomlaag als volwassen boom, als struik in de struiklaag of  als juveniel in de kruidlaag   Vegetation layer where the species was observed For example an oak can be observed as a tree in the tree-layer, as a shrub in the shrub layer and as a juvenile in the herb layer'
;

COMMENT ON COLUMN imna.vegetatie_opname_soort.abundantie_schaal_code_id
	IS 'Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation'
;

COMMENT ON COLUMN imna.vegetatie_opname_soort.abundantie_schaal_schema_opname_soort_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekkingen in de vegetatie-opnamen aan te geven  Reference to abundance scheme used to give the coverage of a species in a vegetation sample (relevés)'
;

COMMENT ON TABLE imna.vegetatie_toevoeging
	IS 'Geeft de mogelijkheid om extra informatie toe te voegen aan een vegetatievlak (toevoegingen) Het betreft een gelimiteerde set die voorafgaand aan de kartering wordt afgesproken  Enables the possibility to add additional information to a vegetation polygon This additional information is limited and agreed on before the fieldwork is carried out'
;

COMMENT ON COLUMN imna.vegetatie_toevoeging.toevoeging_id
	IS 'Uniek  nummer van de toevoeging  Unique number referring tot lokaletoevoeging-identificatie'
;

COMMENT ON COLUMN imna.vegetatie_toevoeging.vegetatie_id
	IS 'ID linking to  the internal id of the vegetation'
;

COMMENT ON TABLE imna.vegetatie_type_landelijk
	IS 'Vegetatietype volgens één van de landelijke typologieën  Vegetation type in accordance with one of the national vegetation schemes'
;

COMMENT ON COLUMN imna.vegetatie_type_landelijk.vegetatie_opname_id
	IS 'ID linking to  the internal id of the vegetation samples (relevés)'
;

COMMENT ON COLUMN imna.vegetatie_type_landelijk.vegetatie_type_landelijk_id
	IS 'Code van het vegetatietype volgens één van de landelijke typologieën  Code of the vegetation type in accordance with one of the national vegetation schemes'
;

COMMENT ON TABLE imna.vegetatie_type_lokaal_met_bedekking
	IS 'Bedekking van de verticale projectie van de vegetatie in het vlak  Coverage of "vertical projection" of the polygon with the vegetation type'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_met_bedekking.vegetatie_id
	IS 'ID linking to  the internal id of the vegetation'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_met_bedekking.abundantie_schaal_code_id
	IS 'Code van de abundantie van een gekozen abundantieschaalschema  Code of the abundance class of the observation'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_met_bedekking.vegetatie_type_lokaal_naar_landelijk_id
	IS 'Lokale type (code)  Vegetation type (code) in accordance with the local typology'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_met_bedekking.bedekkings_percentage
	IS 'Percentage van de bedekking van het desbetreffende vegetatietype  Percentage coverage of the observation'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_met_bedekking.abundantie_schaal_schema_vegetatie_vegetatie_id
	IS 'Verwijzing naar het bedekkingsschema dat is gebruikt om de bedekking van een vegetatietype in een vegetatievlak aan te geven  Reference to the coverage scheme used to indicate the coverage of a vegetation type in a vegetation polygon'
;

COMMENT ON TABLE imna.vegetatie_type_lokaal_naar_landelijk
	IS 'Hierin wordt de vertaling van het lokale typen naar één van de landelijke typologieën gegeven  Describes the translation of the local vegetation types to one of the national vegetation type'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.id
	IS 'Internal ID of the local vegetation types '
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.package_id
	IS 'ID linking to  the internal id of  the vegetation package'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.vegetatie_type_lokaal
	IS 'Lokale type (code)  Vegetation type (code) in accordance with the local typology'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.vegetatie_type_lokaal_naam
	IS 'Naam van het lokale type  Name of the local type'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.vegetatie_type_landelijk_id
	IS 'Vegetatietype volgens één van de landelijke typologieën  Vegetation type in accordance with one of the national vegetation schemes'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.vegetatie_type_landelijk_schema_id
	IS 'Verwijzing naar het schema dat is gebruikt om de landelijke typologie mee aan te geven in deze kartering  Reference to the national scheme used to define the national vegetation type'
;

COMMENT ON COLUMN imna.vegetatie_type_lokaal_naar_landelijk.vegetatie_type_landelijk_alternatief_id
	IS 'Alternatief Vegetatietype volgens één van de landelijke typologieën  Alternative Vegetation type in accordance with one of the national vegetation schemes'
;

GRANT SELECT, UPDATE ON imna.vegetatie_kartering_package TO ndvh_geoweb;

GRANT SELECT ON ALL TABLES IN SCHEMA imna TO anlb_sqlpad;