-- SNL-216 Conversion script.
-- This script will convert the internal id's of the provincie domain to the similar id's of the bronhouder_compleet domain.
-- It will also update all foreign key reference to this domain
-- To be albe to do this, all foreign keys will have to be switch to DEFERRABLE, so that the integrity is only check at COMMIT and not directly on a update.
-- The script executes in 3 stages / commits:
-- 1) Switch foreign keys to DEFERRABLE INITIALLY DEFERRED
-- 2) Convert the data
-- 3) Switch foreign keys back to NOT DEFERRABLE
--
-- As this script requires multiple commits, it cannot be part of the CI/CD as the CI/CD is running in ONE transaction.


-- Set Foreign keys to deferable
BEGIN;
	ALTER TABLE geoweb.snl_nbp_upload 
		ALTER CONSTRAINT FK_snl_nbp_upload_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED; 

	ALTER TABLE geoweb.snl_bes_upload 
		ALTER CONSTRAINT FK_snl_bes_upload_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED; 	

	ALTER TABLE geoweb.snl_vrn_upload 
		ALTER CONSTRAINT FK_snl_vrn_upload_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED; 	
		
	ALTER TABLE masterdata.lnk_table_provincie_deelgebied 
		ALTER CONSTRAINT FK_lnk_table_provincie_deelgebied_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED; 		
		
	ALTER TABLE masterdata.lnk_table_provincie_type_regeling 
		ALTER CONSTRAINT FK_lnk_table_provincie_type_regeling_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED; 		
		
	ALTER TABLE imna.natuur_beheer_plan 
		ALTER CONSTRAINT FK_dmn_provincie_code_eigenaar1 DEFERRABLE INITIALLY DEFERRED;		
		
	ALTER TABLE imna.natuur_beheer_plan 
		ALTER CONSTRAINT FK_dmn_provincie_code_prov1 DEFERRABLE INITIALLY DEFERRED;			
		
	ALTER TABLE imna.beheer_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code1 DEFERRABLE INITIALLY DEFERRED;			

	ALTER TABLE imna.beheer_gebied_ambitie 
		ALTER CONSTRAINT FK_dmn_provincie_code2 DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.bijzonder_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code3 DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.deel_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code4 DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.zoek_gebied_agrarisch 
		ALTER CONSTRAINT FK_dmn_provincie_code5 DEFERRABLE INITIALLY DEFERRED;	
		
	ALTER TABLE imna.zoek_gebied_agrarisch 
		ALTER CONSTRAINT FK_zoek_gebied_agrarisch_lnk_table_provincie_deelgebied DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.zoek_gebied_landschap 
		ALTER CONSTRAINT FK_dmn_provincie_code6 DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.zoek_gebied_water 
		ALTER CONSTRAINT FK_dmn_provincie_code7 DEFERRABLE INITIALLY DEFERRED;

	ALTER TABLE imna.zoek_gebied_water 
		ALTER CONSTRAINT FK_zoek_gebied_water_lnk_table_provincie_deelgebied DEFERRABLE INITIALLY DEFERRED;

	ALTER TABLE imna.zoek_gebied_klimaat 
		ALTER CONSTRAINT FK_zoek_gebied_klimaat_dmn_provincie_code DEFERRABLE INITIALLY DEFERRED;

	ALTER TABLE imna.zoek_gebied_klimaat 
		ALTER CONSTRAINT FK_zoek_gebied_klimaat_lnk_table_provincie_deelgebied DEFERRABLE INITIALLY DEFERRED;

	ALTER TABLE imna.beschikking_rapportage 
		ALTER CONSTRAINT FK_dmn_provincie_code_16 DEFERRABLE INITIALLY DEFERRED;
		
	ALTER TABLE imna.beschikking 
		ALTER CONSTRAINT FK_dmn_provincie_code_17 DEFERRABLE INITIALLY DEFERRED;		
		
	ALTER TABLE imna.beschikking 
		ALTER CONSTRAINT FK_beschikking_lnk_table_provincie_type_regeling DEFERRABLE INITIALLY DEFERRED;

	ALTER TABLE imna.voortgangs_rapportage 
		ALTER CONSTRAINT FK_dmn_provincie_code_10 DEFERRABLE INITIALLY DEFERRED;				
		
	ALTER TABLE imna.gebied_natuur 
		ALTER CONSTRAINT FK_dmn_provincie_code_11 DEFERRABLE INITIALLY DEFERRED;				

	ALTER TABLE imna.gebied_inrichting 
		ALTER CONSTRAINT FK_dmn_provincie_code_12 DEFERRABLE INITIALLY DEFERRED;	

	ALTER TABLE imna.gebied_verwerving 
		ALTER CONSTRAINT FK_dmn_provincie_code_13 DEFERRABLE INITIALLY DEFERRED;	
		
	ALTER TABLE imna.resterende_inrichtings_ambitie 
		ALTER CONSTRAINT FK_dmn_provincie_code_15 DEFERRABLE INITIALLY DEFERRED;			

	ALTER TABLE imna.natuur_netwerk_nederland 
		ALTER CONSTRAINT FK_dmn_provincie_code_14 DEFERRABLE INITIALLY DEFERRED;			

COMMIT;
-- Do the update
BEGIN;
	UPDATE geoweb.snl_nbp_upload 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = snl_nbp_upload.provincie_id));
																   	
	UPDATE geoweb.snl_bes_upload 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = snl_bes_upload.provincie_id));																	
																	
	UPDATE geoweb.snl_vrn_upload 
	SET provincie_id = (SELECT id 
					      FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = snl_vrn_upload.provincie_id));																				
																	
	UPDATE masterdata.lnk_table_provincie_deelgebied 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
					     WHERE dmn_bronhouder_compleet.code = (SELECT code 
															    FROM masterdata.dmn_provincie_code
														   	    WHERE dmn_provincie_code.id = lnk_table_provincie_deelgebied.provincie_id));																			
																	
	UPDATE masterdata.lnk_table_provincie_type_regeling 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															    FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = lnk_table_provincie_type_regeling.provincie_id));	
	UPDATE imna.natuur_beheer_plan 
	SET plan_eigenaar_id = (SELECT id 
							  FROM masterdata.dmn_bronhouder_compleet
						     WHERE dmn_bronhouder_compleet.code = (SELECT code 
															         FROM masterdata.dmn_provincie_code
																    WHERE dmn_provincie_code.id = natuur_beheer_plan.plan_eigenaar_id));																			
																	
	UPDATE imna.natuur_beheer_plan 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = natuur_beheer_plan.provincie_id));																				
																	
	UPDATE imna.beheer_gebied 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = beheer_gebied.provincie_id));																				
	UPDATE imna.beheer_gebied_ambitie 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = beheer_gebied_ambitie.provincie_id));				

	UPDATE imna.bijzonder_gebied 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = bijzonder_gebied.provincie_id));		

	UPDATE imna.deel_gebied 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = deel_gebied.provincie_id));		
	UPDATE imna.zoek_gebied_agrarisch 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = zoek_gebied_agrarisch.provincie_id));		

	UPDATE imna.zoek_gebied_landschap 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = zoek_gebied_landschap.provincie_id));	

	UPDATE imna.zoek_gebied_water 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = zoek_gebied_water.provincie_id));	
	UPDATE imna.zoek_gebied_klimaat 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = zoek_gebied_klimaat.provincie_id));	

	UPDATE imna.beschikking_rapportage 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = beschikking_rapportage.provincie_id));	

	UPDATE imna.beschikking 
	SET provincie_id = (SELECT id 
						  FROM masterdata.dmn_bronhouder_compleet
						 WHERE dmn_bronhouder_compleet.code = (SELECT code 
															     FROM masterdata.dmn_provincie_code
															    WHERE dmn_provincie_code.id = beschikking.provincie_id));

	UPDATE imna.voortgangs_rapportage 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = voortgangs_rapportage.bron_houder_id));

	UPDATE imna.gebied_natuur 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = gebied_natuur.bron_houder_id));

	UPDATE imna.gebied_inrichting 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = gebied_inrichting.bron_houder_id));

	UPDATE imna.gebied_verwerving 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = gebied_verwerving.bron_houder_id));

	UPDATE imna.resterende_inrichtings_ambitie 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = resterende_inrichtings_ambitie.bron_houder_id));

	UPDATE imna.natuur_netwerk_nederland 
	SET bron_houder_id = (SELECT id 
						    FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
															       FROM masterdata.dmn_provincie_code
															      WHERE dmn_provincie_code.id = natuur_netwerk_nederland.bron_houder_id));

	UPDATE masterdata.dmn_provincie_code
	SET id = (SELECT id 
				FROM masterdata.dmn_bronhouder_compleet
			   WHERE dmn_provincie_code.code = dmn_bronhouder_compleet.code);
			   
   
COMMIT;

-- Set Foreign keys to NOT deferable
BEGIN;			 
	
	ALTER TABLE geoweb.snl_nbp_upload 
		ALTER CONSTRAINT FK_snl_nbp_upload_dmn_provincie_code NOT DEFERRABLE; 

	ALTER TABLE geoweb.snl_bes_upload 
		ALTER CONSTRAINT FK_snl_bes_upload_dmn_provincie_code NOT DEFERRABLE; 	

	ALTER TABLE geoweb.snl_vrn_upload 
		ALTER CONSTRAINT FK_snl_vrn_upload_dmn_provincie_code NOT DEFERRABLE; 	
		
	ALTER TABLE masterdata.lnk_table_provincie_deelgebied 
		ALTER CONSTRAINT FK_lnk_table_provincie_deelgebied_dmn_provincie_code NOT DEFERRABLE; 		
		
	ALTER TABLE masterdata.lnk_table_provincie_type_regeling 
		ALTER CONSTRAINT FK_lnk_table_provincie_type_regeling_dmn_provincie_code NOT DEFERRABLE; 		
		
	ALTER TABLE imna.natuur_beheer_plan 
		ALTER CONSTRAINT FK_dmn_provincie_code_eigenaar1 NOT DEFERRABLE;		
		
	ALTER TABLE imna.natuur_beheer_plan 
		ALTER CONSTRAINT FK_dmn_provincie_code_prov1 NOT DEFERRABLE;			
		
	ALTER TABLE imna.beheer_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code1 NOT DEFERRABLE;			

	ALTER TABLE imna.beheer_gebied_ambitie 
		ALTER CONSTRAINT FK_dmn_provincie_code2 NOT DEFERRABLE;	

	ALTER TABLE imna.bijzonder_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code3 NOT DEFERRABLE;	

	ALTER TABLE imna.deel_gebied 
		ALTER CONSTRAINT FK_dmn_provincie_code4 NOT DEFERRABLE;	

	ALTER TABLE imna.zoek_gebied_agrarisch 
		ALTER CONSTRAINT FK_dmn_provincie_code5 NOT DEFERRABLE;	
		
	ALTER TABLE imna.zoek_gebied_agrarisch 
		ALTER CONSTRAINT FK_zoek_gebied_agrarisch_lnk_table_provincie_deelgebied NOT DEFERRABLE;			
		

	ALTER TABLE imna.zoek_gebied_landschap 
		ALTER CONSTRAINT FK_dmn_provincie_code6 NOT DEFERRABLE;	

	ALTER TABLE imna.zoek_gebied_water 
		ALTER CONSTRAINT FK_dmn_provincie_code7 NOT DEFERRABLE;
		
	ALTER TABLE imna.zoek_gebied_water 
		ALTER CONSTRAINT FK_zoek_gebied_water_lnk_table_provincie_deelgebied NOT DEFERRABLE;		

	ALTER TABLE imna.zoek_gebied_klimaat 
		ALTER CONSTRAINT FK_zoek_gebied_klimaat_dmn_provincie_code NOT DEFERRABLE;
		
	ALTER TABLE imna.zoek_gebied_klimaat 
		ALTER CONSTRAINT FK_zoek_gebied_klimaat_lnk_table_provincie_deelgebied NOT DEFERRABLE;		

	ALTER TABLE imna.beschikking_rapportage 
		ALTER CONSTRAINT FK_dmn_provincie_code_16 NOT DEFERRABLE;
		
	ALTER TABLE imna.beschikking 
		ALTER CONSTRAINT FK_dmn_provincie_code_17 NOT DEFERRABLE;		
		
	ALTER TABLE imna.beschikking 
		ALTER CONSTRAINT FK_beschikking_lnk_table_provincie_type_regeling NOT DEFERRABLE;
		
	ALTER TABLE imna.voortgangs_rapportage 
		ALTER CONSTRAINT FK_dmn_provincie_code_10 NOT DEFERRABLE;				
		
	ALTER TABLE imna.gebied_natuur 
		ALTER CONSTRAINT FK_dmn_provincie_code_11 NOT DEFERRABLE;				

	ALTER TABLE imna.gebied_inrichting 
		ALTER CONSTRAINT FK_dmn_provincie_code_12 NOT DEFERRABLE;	

	ALTER TABLE imna.gebied_verwerving 
		ALTER CONSTRAINT FK_dmn_provincie_code_13 NOT DEFERRABLE;	
		
	ALTER TABLE imna.resterende_inrichtings_ambitie 
		ALTER CONSTRAINT FK_dmn_provincie_code_15 NOT DEFERRABLE;			

	ALTER TABLE imna.natuur_netwerk_nederland 
		ALTER CONSTRAINT FK_dmn_provincie_code_14 NOT DEFERRABLE;			
		
		

COMMIT;	