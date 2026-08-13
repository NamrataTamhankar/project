-- NDVH-323 Conversion script.
-- This script will convert the internal id's of the bronhouder and bronhouder_vegetatie domain to the similar id's of the bronhouder_compleet domain.
-- It will also update all foreign key references to these two domains
-- To be albe to do this, all foreign keys will have to be switch to DEFERRABLE, so that the integrity is only check at COMMIT and not directly on a update.
-- The script executes in 3 stages / commits:
-- 1) Switch foreign keys to DEFERRABLE INITIALLY DEFERRED
-- 2) Convert the data
-- 3) Switch foreign keys back to NOT DEFERRABLE
--
-- As this script requires multiple commits, it cannot be part of the CI/CD as the CI/CD is running in ONE transaction.


-- Set Foreign keys to deferable
BEGIN;
	ALTER TABLE geoweb.ndvh_habitat_upload 
		ALTER CONSTRAINT fk_ndvh_habitat_upload_dmn_bronhouder DEFERRABLE INITIALLY DEFERRED; 
	
	ALTER TABLE geoweb.ndvh_vegetatie_upload 
		ALTER CONSTRAINT fk_ndvh_vegetatie_upload_dmn_bronhouder_vegetatie DEFERRABLE INITIALLY DEFERRED; 		
		
	ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer
		ALTER CONSTRAINT fk_natura_2000_gebied_voortouwnemer_dmn_bronhouder DEFERRABLE INITIALLY DEFERRED; 	
	
	ALTER TABLE imna.habitat_package 
		ALTER CONSTRAINT fk_habitat_package_dmn_bronhouder DEFERRABLE INITIALLY DEFERRED; 

	ALTER TABLE imna.habitat_package 
		ALTER CONSTRAINT fk_habitat_package_natura_2000_gebied_voortouwnemer DEFERRABLE INITIALLY DEFERRED; 	
	
	ALTER TABLE imna.vegetatie_kartering_package 
		ALTER CONSTRAINT fk_vegetatie_kartering_package_dmn_bronhouder_vegetatie DEFERRABLE INITIALLY DEFERRED; 	

COMMIT;
-- Do the update
BEGIN;
	UPDATE geoweb.ndvh_habitat_upload 
	SET bronhouder_id = (SELECT id 
							FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
																   FROM masterdata.dmn_bronhouder
																  WHERE dmn_bronhouder.id = ndvh_habitat_upload.bronhouder_id));
	UPDATE geoweb.ndvh_vegetatie_upload 
	SET bronhouder_id = (SELECT id 
							FROM masterdata.dmn_bronhouder_compleet
						   WHERE dmn_bronhouder_compleet.code = (SELECT code 
																   FROM masterdata.dmn_bronhouder_vegetatie
																  WHERE dmn_bronhouder_vegetatie.id = ndvh_vegetatie_upload.bronhouder_id));																    
	
	UPDATE natura_2000.natura_2000_gebied_voortouwnemer 
	SET voortouw_nemer_id = (SELECT id 
							   FROM masterdata.dmn_bronhouder_compleet
							  WHERE dmn_bronhouder_compleet.code = (SELECT code 
																	  FROM masterdata.dmn_bronhouder
																	 WHERE dmn_bronhouder.id = natura_2000_gebied_voortouwnemer.voortouw_nemer_id));

	UPDATE imna.habitat_package 
	SET package_bronhouder_id = (SELECT id 
								   FROM masterdata.dmn_bronhouder_compleet
								  WHERE dmn_bronhouder_compleet.code = (SELECT code 
																		  FROM masterdata.dmn_bronhouder
																		 WHERE dmn_bronhouder.id = habitat_package.package_bronhouder_id));
	UPDATE imna.vegetatie_kartering_package 
	SET package_bronhouder_id = (SELECT id 
								   FROM masterdata.dmn_bronhouder_compleet
								  WHERE dmn_bronhouder_compleet.code = (SELECT code 
																		  FROM masterdata.dmn_bronhouder_vegetatie
																		 WHERE dmn_bronhouder_vegetatie.id = vegetatie_kartering_package.package_bronhouder_id));

	UPDATE masterdata.dmn_bronhouder
	SET id = (SELECT id 
				FROM masterdata.dmn_bronhouder_compleet
			   WHERE dmn_bronhouder.code = dmn_bronhouder_compleet.code);
			   
	UPDATE masterdata.dmn_bronhouder_vegetatie
	SET id = (SELECT id 
				FROM masterdata.dmn_bronhouder_compleet
			   WHERE dmn_bronhouder_vegetatie.code = dmn_bronhouder_compleet.code);		   
COMMIT;

-- Set Foreign keys to NOT deferable
BEGIN;			 
	ALTER TABLE geoweb.ndvh_habitat_upload 
		ALTER CONSTRAINT fk_ndvh_habitat_upload_dmn_bronhouder NOT DEFERRABLE;
		
	ALTER TABLE geoweb.ndvh_vegetatie_upload 
		ALTER CONSTRAINT fk_ndvh_vegetatie_upload_dmn_bronhouder_vegetatie NOT DEFERRABLE;
		
	ALTER TABLE imna.habitat_package 
		ALTER CONSTRAINT fk_habitat_package_dmn_bronhouder NOT DEFERRABLE; 
		
	ALTER TABLE imna.habitat_package 
		ALTER CONSTRAINT fk_habitat_package_natura_2000_gebied_voortouwnemer NOT DEFERRABLE; 

	ALTER TABLE natura_2000.natura_2000_gebied_voortouwnemer
		ALTER CONSTRAINT fk_natura_2000_gebied_voortouwnemer_dmn_bronhouder NOT DEFERRABLE; 
		
	ALTER TABLE imna.vegetatie_kartering_package 
		ALTER CONSTRAINT fk_vegetatie_kartering_package_dmn_bronhouder_vegetatie NOT DEFERRABLE;
COMMIT;	