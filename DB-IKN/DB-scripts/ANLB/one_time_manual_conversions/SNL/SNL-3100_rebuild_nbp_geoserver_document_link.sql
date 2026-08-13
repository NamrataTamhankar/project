-- Recreate the Document_link for geoserver.imna_nbp_viewer*

UPDATE geoserver.imna_nbp_viewer_natuur_beheer_plan
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );
  
UPDATE geoserver.imna_nbp_viewer_beheer_gebied
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );

UPDATE geoserver.imna_nbp_viewer_beheer_gebied_ambitie
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );
	   
UPDATE geoserver.imna_nbp_viewer_bijzonder_gebied
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );

UPDATE geoserver.imna_nbp_viewer_deel_gebied
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );

UPDATE geoserver.imna_nbp_viewer_zoek_gebied_agrarisch
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );
	   
UPDATE geoserver.imna_nbp_viewer_zoek_gebied_landschap
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );

UPDATE geoserver.imna_nbp_viewer_zoek_gebied_water
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       );
	   
UPDATE geoserver.imna_nbp_viewer_zoek_gebied_klimaat
   SET document_link = 
       (
        (SELECT value FROM masterdata.parameters WHERE name = 'GeoWebSNL-NBPGetPublicFileURL' ) ||
        SUBSTRING(document_link,POSITION('NBP_Attachements/' IN document_link )+ LENGTH('NBP_Attachements/' ))
       ); 	   