-- Recreate the Private Document URI for IMNA.vegetatie_documentatie
UPDATE imna.vegetatie_documentatie 
   SET document_uri = 
   	   (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebNDVHVegetatieGetPrivateAttachmentURL') || 
	   (SELECT identificatie  || '-' || TO_CHAR(begin_geldigheid,'YYYYMMDDHH24MISS') FROM imna.vegetatie_kartering_package WHERE vegetatie_kartering_package.id = vegetatie_documentatie.package_id) || '/' ||
	   document_naam
 WHERE verantwoordings_document = false;