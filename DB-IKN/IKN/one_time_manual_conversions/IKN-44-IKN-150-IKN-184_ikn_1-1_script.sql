BEGIN;

-- *************************** Update old policies in bronspecificatie to inactive ***************************

-- **** SELECT STATEMENT ****
-- SELECT * FROM masterdata.bron_specificatie_wfs wfs
-- JOIN masterdata.dmn_beleid_naam bn on bn.id = wfs.beleid_naam_id
-- WHERE valid_to IS NOT NULL

UPDATE masterdata.bron_specificatie_wfs wfs
SET active = FALSE
FROM masterdata.dmn_beleid_naam bn
WHERE bn.id = wfs.beleid_naam_id
  AND bn.valid_to IS NOT NULL
RETURNING 
	wfs.*,
	bn.code,
    bn.valid_to;
  
-- *************************** Update is_arcgis_harvast for new policies for Groningen, Friesland, Zuid-Holland and Utrecht to TRUE ***************************

-- **** SELECT STATEMENT ****
-- SELECT * FROM masterdata.bron_specificatie_wfs wfs
-- JOIN masterdata.dmn_bronhouder bh on bh.id = wfs.bronhouder_id
-- WHERE bh.code IN ('26', '27', '20', '21');

UPDATE masterdata.bron_specificatie_wfs wfs
SET is_arcgis_harvast = TRUE
FROM masterdata.dmn_bronhouder bh
WHERE bh.id = wfs.bronhouder_id
  AND bh.code IN ('26', '27', '20', '21')
RETURNING 
	wfs.*,
	bh.code,
	bh.description;


-- *************************** Remove data from History and Huidig ***************************

-- **** SELECT STATEMENT ****
-- SELECT COUNT(*) FROM geoserver.beleid_totaal_historie h 
-- JOIN masterdata.dmn_beleid_naam bn on bn.code = h.beleid_naam_code
-- WHERE bn.valid_to IS NOT NULL 

DELETE FROM geoserver.beleid_totaal_historie h
USING masterdata.dmn_beleid_naam bn
WHERE bn.code = h.beleid_naam_code
  AND bn.valid_to IS NOT NULL
RETURNING 
	h.*,
	bn.code,
    bn.valid_to;

-- **** SELECT STATEMENT ****
-- SELECT COUNT(*) FROM geoserver.beleid_totaal_huidig h 
-- JOIN masterdata.dmn_beleid_naam bn on bn.code = h.beleid_naam_code
-- WHERE bn.valid_to IS NOT NULL 

DELETE FROM geoserver.beleid_totaal_huidig h
USING masterdata.dmn_beleid_naam bn
WHERE bn.code = h.beleid_naam_code
  AND bn.valid_to IS NOT NULL
RETURNING 
	h.*,
	bn.code,
    bn.valid_to;

-- *************************** Remove data from upload History ***************************

-- **** SELECT STATEMENT ****
-- SELECT count(*) FROM geoweb.ikn_upload_files f
-- JOIN geoweb.ikn_upload u ON u.id = f.ikn_upload_id
-- JOIN masterdata.dmn_beleid_naam bn on bn.id = u.beleid_naam_id
-- WHERE bn.valid_to IS NOT NULL 

DELETE FROM geoweb.ikn_upload_files f
USING geoweb.ikn_upload u,
      masterdata.dmn_beleid_naam bn
WHERE u.id = f.ikn_upload_id
  AND bn.id = u.beleid_naam_id
  AND bn.valid_to IS NOT NULL
RETURNING
    f.*,
    bn.code,
    bn.valid_to;

-- **** SELECT STATEMENT ****
-- SELECT count(*) FROM geoweb.ikn_upload u
-- JOIN masterdata.dmn_beleid_naam bn on bn.id = u.beleid_naam_id
-- WHERE bn.valid_to IS NOT NULL 

DELETE FROM geoweb.ikn_upload u
USING masterdata.dmn_beleid_naam bn
WHERE bn.id = u.beleid_naam_id
  AND bn.valid_to IS NOT NULL
RETURNING
    u.*,
    bn.code,
    bn.valid_to;


-- *************************** Remove data from imna tables ***************************

-- **** SELECT STATEMENT ****
-- SELECT count(*) FROM imna.informatie_kaart_natuur n
-- JOIN masterdata.dmn_beleid_naam bn on bn.id = n.beleid_naam_id
 -- WHERE bn.valid_to IS NOT NULL 

DELETE FROM imna.informatie_kaart_natuur n
USING masterdata.dmn_beleid_naam bn
WHERE bn.id = n.beleid_naam_id
  AND bn.valid_to IS NOT NULL
RETURNING 
	n.*,
	bn.code,
    bn.valid_to;

-- **** SELECT STATEMENT ****
-- SELECT count(*) FROM imna.informatie_kaart_aanlevering a
-- JOIN masterdata.dmn_beleid_naam bn on bn.id = a.beleid_naam_id
 -- WHERE bn.valid_to IS NOT NULL 

DELETE FROM imna.informatie_kaart_aanlevering a
USING masterdata.dmn_beleid_naam bn
WHERE bn.id = a.beleid_naam_id
  AND bn.valid_to IS NOT NULL
RETURNING 
	a.*, 
	bn.code,
    bn.valid_to;;


	
-- *************************** Rename datamart Ganzenfoerageergebied to Ganzenrustgebied ***************************
-- Rename table
ALTER TABLE geoserver.ganzen_foerageergebied
RENAME TO ganzen_rustgebied;

-- Rename primary key constraint
ALTER TABLE geoserver.ganzen_rustgebied
RENAME CONSTRAINT pk_ganzen_foerageergebied
TO pk_ganzen_rustgebied;


--COMMIT;
--ROLLBACK;