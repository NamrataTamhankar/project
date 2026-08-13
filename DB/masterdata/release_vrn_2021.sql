-- View: masterdata.all_domains

--DROP VIEW masterdata.all_domains;

CREATE OR REPLACE VIEW masterdata.all_domains AS
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_ambitiegebied_type' AS dmn
    FROM
        masterdata.dmn_ambitiegebied_type
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_pakket_landschap' AS dmn
    FROM
        masterdata.dmn_beheer_pakket_landschap
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_agrarisch' AS dmn
    FROM
        masterdata.dmn_beheer_type_agrarisch
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_grootschaligenatuur' AS dmn
    FROM
        masterdata.dmn_beheer_type_grootschaligenatuur
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_landschap' AS dmn
    FROM
        masterdata.dmn_beheer_type_landschap
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_natuur' AS dmn
    FROM
        masterdata.dmn_beheer_type_natuur
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_natuur_ambitie' AS dmn
    FROM
        masterdata.dmn_beheer_type_natuur_ambitie
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_omtevormennatuur_ambitie' AS dmn
    FROM
        masterdata.dmn_beheer_type_omtevormennatuur_ambitie
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_water' AS dmn
    FROM
        masterdata.dmn_beheer_type_water
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheergebied_type' AS dmn
    FROM
        masterdata.dmn_beheergebied_type
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_bijzonder_gebied_code' AS dmn
    FROM
        masterdata.dmn_bijzonder_gebied_code
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_natuur_type_agrarisch' AS dmn
    FROM
        masterdata.dmn_natuur_type_agrarisch
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_natuur_type_water' AS dmn
    FROM
        masterdata.dmn_natuur_type_water
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_openstellings_bijdrage_type' AS dmn
    FROM
        masterdata.dmn_openstellings_bijdrage_type
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_provincie_code' AS dmn
    FROM
        masterdata.dmn_provincie_code
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_ehs' AS dmn
    FROM
        masterdata.dmn_status_ehs
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_plan' AS dmn
    FROM
        masterdata.dmn_status_plan
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_beheer_gebied' AS dmn
    FROM
        masterdata.dmn_status_beheer_gebied
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_beheer_gebied_ambitie' AS dmn
    FROM
        masterdata.dmn_status_beheer_gebied_ambitie
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_bijzonder_gebied' AS dmn
    FROM
        masterdata.dmn_status_bijzonder_gebied
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_deel_gebied' AS dmn
    FROM
        masterdata.dmn_status_deel_gebied
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_zoek_gebied_agrarisch' AS dmn
    FROM
        masterdata.dmn_status_zoek_gebied_agrarisch
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_zoek_gebied_landschap' AS dmn
    FROM
        masterdata.dmn_status_zoek_gebied_landschap
	UNION
	SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_zoek_gebied_water' AS dmn
    FROM
        masterdata.dmn_status_zoek_gebied_water		
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_functie' AS dmn
    FROM
        masterdata.dmn_beheer_functie
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_natuur_type' AS dmn
    FROM
        masterdata.dmn_natuur_type
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_pakket' AS dmn
    FROM
        masterdata.dmn_beheer_pakket
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type' AS dmn
    FROM
        masterdata.dmn_beheer_type
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_natuur' AS dmn
    FROM
        masterdata.dmn_status_natuur
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_type_beheerder_en_eigenaar' AS dmn
    FROM
        masterdata.dmn_type_beheerder_en_eigenaar
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_status_aanvraag_subsidie' AS dmn
    FROM
        masterdata.dmn_status_aanvraag_subsidie
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_type_regeling' AS dmn
    FROM
        masterdata.dmn_type_regeling
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_type_regeling_snl' AS dmn
    FROM
        masterdata.dmn_type_regeling_snl
    UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_type_regeling_niet_snl' AS dmn
    FROM
        masterdata.dmn_type_regeling_niet_snl
	UNION
    SELECT
        id,
        code,
        description,
		valid_from,
		valid_to,
        'dmn_beheer_type_beschikking_niet_snl' AS dmn
    FROM
        masterdata.dmn_beheer_type_beschikking_niet_snl;

ALTER TABLE masterdata.all_domains
  OWNER TO anlb;
GRANT SELECT ON TABLE masterdata.all_domains TO anlb_sqlpad;  
;

DROP TABLE IF EXISTS masterdata.dmn_status_verwerving
;