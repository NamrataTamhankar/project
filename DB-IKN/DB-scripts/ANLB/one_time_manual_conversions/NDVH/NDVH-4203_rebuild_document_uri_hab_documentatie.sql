-- Recreate the Private Document URI for IMNA.habitat_documentatie for the migration to VertiGis
UPDATE imna.habitat_documentatie 
  SET document_uri = 	   
       (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebNDVHGetPrivateAttachmentURL') || 
	   (SELECT nummer FROM natura_2000.natura_2000 WHERE id = (SELECT gebied_id FROM imna.habitat_package WHERE habitat_package.id = habitat_documentatie.package_id)) || '-' ||
	   (SELECT code FROM masterdata.dmn_habitat_package_type WHERE id = (SELECT package_type_id FROM imna.habitat_package WHERE habitat_package.id = habitat_documentatie.package_id)) || '-' ||
	   (SELECT code FROM masterdata.dmn_habitat_package_versie WHERE id = (SELECT package_versie_id FROM imna.habitat_package WHERE habitat_package.id = habitat_documentatie.package_id)) || '-' ||
	   (SELECT package_volgnummer FROM imna.habitat_package WHERE habitat_package.id = habitat_documentatie.package_id) || '/' ||
	   document_naam 
 WHERE verantwoordings_document = false;
 