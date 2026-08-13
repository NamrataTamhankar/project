------------------delete imna_nbp_viewer_beheer_gebied-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_beheer_gebied;
   
------------------delete imna_nbp_viewer_beheer_gebied_ambitie-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_beheer_gebied_ambitie;
   
------------------delete imna_nbp_viewer_bijzonder_gebied-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_bijzonder_gebied ;
  
------------------delete imna_nbp_viewer_deel_gebied-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_deel_gebied ;
   
------------------delete imna_nbp_viewer_zoek_gebied_agrarisch-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_zoek_gebied_agrarisch ;
   
------------------delete imna_nbp_viewer_zoek_gebied_landschap-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_zoek_gebied_landschap ;
   
------------------delete imna_nbp_viewer_zoek_gebied_water-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_zoek_gebied_water ;

------------------delete imna_nbp_viewer_natuur_beheer_plan-----------------------------------
DELETE FROM GEOSERVER.imna_nbp_viewer_natuur_beheer_plan ;
	
------------------insert imna_nbp_viewer_natuur_beheer_plan-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_natuur_beheer_plan(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    datum_vaststelling,
    plan_eigenaar,
    plan_eigenaar_desc,
    plan_verwijzing,
    beheer_gebied_status,
    beheer_gebied_status_desc,
    beheer_gebied_ambitie_status,
    beheer_gebied_ambitie_status_desc,
    bijzonder_gebied_status,
    bijzonder_gebied_status_desc,
    deel_gebied_status,
    deel_gebied_status_desc,
    zoek_gebied_landschap_status,
    zoek_gebied_landschap_status_desc,
    zoek_gebied_agrarisch_status,
    zoek_gebied_agrarisch_status_desc,
    zoek_gebied_water_status,
    zoek_gebied_water_status_desc,
    document_link)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    datum_vaststelling,
    plan_eigenaar,
    plan_eigenaar_desc,
    plan_verwijzing,
    beheer_gebied_status,
    beheer_gebied_status_desc,
    beheer_gebied_ambitie_status,
    beheer_gebied_ambitie_status_desc,
    bijzonder_gebied_status,
    bijzonder_gebied_status_desc,
    deel_gebied_status,
    deel_gebied_status_desc,
    zoek_gebied_landschap_status,
    zoek_gebied_landschap_status_desc,
    zoek_gebied_agrarisch_status,
    zoek_gebied_agrarisch_status_desc,
    zoek_gebied_water_status,
    zoek_gebied_water_status_desc,
    document_link
	FROM imna.v_gs_natuur_beheer_plan
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_zoek_gebied_water-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_zoek_gebied_water(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    water_natuur_type,
    water_natuur_type_desc,
    naam,
    deel_gebied_naam,
    toegestane_beheer_functies,
    toegestane_beheer_typen,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    water_natuur_type,
    water_natuur_type_desc,
    naam,
    deel_gebied_naam,
    toegestane_beheer_functies,
    toegestane_beheer_typen,
    document_link,
    geom
	FROM imna.v_gs_zoek_gebied_water
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_zoek_gebied_landschap-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_zoek_gebied_landschap(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    naam,
    toegestane_beheer_typen,
    niet_subsidiabele_beheer_pakketten,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    naam,
    toegestane_beheer_typen,
    niet_subsidiabele_beheer_pakketten,
    document_link,
    geom
	FROM imna.v_gs_zoek_gebied_landschap
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_zoek_gebied_agrarisch-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_zoek_gebied_agrarisch(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid,
    identificatie,
    begin_tijd,
    eind_tijd,
    agrarisch_natuur_type,
    agrarisch_natuur_type_desc,
    naam,
    deel_gebied_naam,
    toegestane_beheer_functies,
    toegestane_beheer_typen,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    identificatie,
    begin_tijd,
    eind_tijd,
    agrarisch_natuur_type,
    agrarisch_natuur_type_desc,
    naam,
    deel_gebied_naam,
    toegestane_beheer_functies,
    toegestane_beheer_typen,
    document_link,
    geom
	FROM imna.v_gs_zoek_gebied_agrarisch
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_deel_gebied-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_deel_gebied(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    gebieds_naam,
    beschrijving,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    gebieds_naam,
    beschrijving,
    document_link,
    geom
	FROM imna.v_gs_deel_gebied
	WHERE status = '2'::text OR status = '3'::text;


------------------insert imna_nbp_viewer_bijzonder_gebied-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_bijzonder_gebied(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid,
    identificatie,
    begin_tijd,
    eind_tijd,
    gebieds_code,
    gebieds_code_desc,
    gebieds_naam,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    identificatie,
    begin_tijd,
    eind_tijd,
    gebieds_code,
    gebieds_code_desc,
    gebieds_naam,
    document_link,
    geom
	FROM imna.v_gs_bijzonder_gebied
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_beheer_gebied_ambitie-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_beheer_gebied_ambitie(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid,
    identificatie,
    begin_tijd,
    eind_tijd,
    status_ehs,
    status_ehs_desc,
    beheer_type,
    beheer_type_desc,
    subsidiabel,
    indicatieve_verhouding_beheer_typen,
    toegestane_beheer_paketten,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    identificatie,
    begin_tijd,
    eind_tijd,
    status_ehs,
    status_ehs_desc,
    beheer_type,
    beheer_type_desc,
    subsidiabel,
    indicatieve_verhouding_beheer_typen,
    toegestane_beheer_paketten,
    document_link,
    geom
	FROM imna.v_gs_beheer_gebied_ambitie
	WHERE status = '2'::text OR status = '3'::text;

------------------insert imna_nbp_viewer_beheer_gebied-----------------------------------
INSERT INTO GEOSERVER.imna_nbp_viewer_beheer_gebied(
	provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    beheer_type,
    beheer_type_desc,
    subsidiabel,
    openstellings_bijdrage_type,
    openstellings_bijdrage_type_desc,
    toegestane_beheer_paketten,
    niet_subsidiabele_beheer_paketten,
    document_link,
    geom)
	SELECT provincie,
    provincie_desc,
    subsidie_jaar,
    status,
    status_desc,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    beheer_type,
    beheer_type_desc,
    subsidiabel,
    openstellings_bijdrage_type,
    openstellings_bijdrage_type_desc,
    toegestane_beheer_paketten,
    niet_subsidiabele_beheer_paketten,
    document_link,
    geom
	FROM imna.v_gs_beheer_gebied
	WHERE status = '2'::text OR status = '3'::text;
	
---------Delete BESCHIKKING-------------------
DELETE FROM GEOSERVER.imna_bes_beschikking;

---------Delete BESCHIKKING_RAPPORTAGE-------------------
DELETE FROM GEOSERVER.IMNA_BES_BESCHIKKING_RAPPORTAGE;
   
 ----------------Insert BESCHIKKING_RAPPORTAGE-----------------  
   
INSERT INTO geoserver.imna_bes_beschikking_rapportage(
	provincie, 
    provincie_desc,      
    beheer_jaar, 
    identificatie,
    begin_geldigheid, 
    eind_geldigheid)
SELECT provincie,provincie_desc,beheer_jaar,identificatie,begin_geldigheid,eind_geldigheid
			FROM imna.v_gs_beschikking_rapportage;

 ----------------Insert BESCHIKKING----------------- 							
INSERT INTO geoserver.imna_bes_beschikking(
	provincie, 
    provincie_desc,      
    beheer_jaar, 
    identificatie,
    begin_geldigheid, 
    eind_geldigheid,
	begin_tijd,
	eind_tijd,
	contract_nummer,
	datum_beschikking,
	status_aanvraag_subsidie,
	status_aanvraag_subsidie_desc,
	type_regeling,
	type_regeling_desc,
	beheer_type,
	beheer_type_desc,
	geom)
SELECT provincie,
    provincie_desc,
    beheer_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    contract_nummer,
    datum_beschikking,
    status_aanvraag_subsidie,
    status_aanvraag_subsidie_desc,
    type_regeling,
    type_regeling_desc,
    beheer_type,
    beheer_type_desc,
    geom
   FROM imna.v_gs_beschikking;
   
------------------delete imna_vrn_gebied_inrichting-----------------------------------
DELETE FROM GEOSERVER.imna_vrn_gebied_inrichting;
						 
------------------delete imna_vrn_gebied_natuur-----------------------------------

DELETE FROM GEOSERVER.imna_vrn_gebied_natuur ;
						 
------------------delete imna_vrn_gebied_verwerving-----------------------------------

DELETE FROM GEOSERVER.imna_vrn_gebied_verwerving ;
						 
------------------delete imna_vrn_natuur_netwerk_nederland-----------------------------------

DELETE FROM GEOSERVER.imna_vrn_natuur_netwerk_nederland ;
						 
------------------delete imna_vrn_resterende_inrichtings_ambitie-----------------------------------

DELETE FROM GEOSERVER.imna_vrn_resterende_inrichtings_ambitie ;
						 
------------------delete imna_vrn_voortgangs_rapportage-----------------------------------

DELETE FROM GEOSERVER.imna_vrn_voortgangs_rapportage ;
							
------------------insert imna_vrn_voortgangs_rapportage-----------------------------------
							
INSERT INTO GEOSERVER.imna_vrn_voortgangs_rapportage(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    opmerkingen)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    opmerkingen
	FROM imna.v_gs_voortgangs_rapportage;
	
------------------insert imna_vrn_resterende_inrichtings_ambitie-----------------------------------

INSERT INTO GEOSERVER.imna_vrn_resterende_inrichtings_ambitie(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    resterende_inrichtings_ambitie)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    resterende_inrichtings_ambitie
	FROM imna.v_gs_resterende_inrichtings_ambitie;
	
------------------insert imna_vrn_natuur_netwerk_nederland-----------------------------------
	
INSERT INTO GEOSERVER.imna_vrn_natuur_netwerk_nederland(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    geom)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    geom
	FROM imna.v_gs_natuur_netwerk_nederland;
	
------------------insert imna_vrn_gebied_verwerving-----------------------------------
	
INSERT INTO GEOSERVER.imna_vrn_gebied_verwerving(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    type_eigenaar,
    type_eigenaar_desc,
    contract_nummer,
    relatie_nummer,
    geom)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    type_eigenaar,
    type_eigenaar_desc,
    contract_nummer,
    relatie_nummer,
    geom
	FROM imna.v_gs_gebied_verwerving;
	
------------------insert imna_vrn_gebied_natuur-----------------------------------
	
INSERT INTO GEOSERVER.imna_vrn_gebied_natuur(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    status_natuur,
    status_natuur_desc,
    type_beheerder,
    type_beheerder_desc,
    eenheid_nummer,
    beheer_pakket,
    beheer_pakket_desc,
    contract_nummer,
    relatie_nummer,
    geom)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    status_natuur,
    status_natuur_desc,
    type_beheerder,
    type_beheerder_desc,
    eenheid_nummer,
    beheer_pakket,
    beheer_pakket_desc,
    contract_nummer,
    relatie_nummer,
    geom
	FROM imna.v_gs_gebied_natuur;

------------------insert imna_vrn_gebied_inrichting-----------------------------------

INSERT INTO GEOSERVER.imna_vrn_gebied_inrichting(
	bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid,
    begin_tijd,
    eind_tijd,
    type_beheerder,
    type_beheerder_desc,
    contract_nummer,
    relatie_nummer,
    geom)
	SELECT bron_houder,
    bron_houder_desc,
    rapportage_jaar,
    identificatie,
    begin_geldigheid,
    eind_geldigheid::timestamp,
    begin_tijd,
    eind_tijd,
    type_beheerder,
    type_beheerder_desc,
    contract_nummer,
    relatie_nummer,
    geom
	FROM imna.v_gs_gebied_inrichting;
   