----------------------------NNN datamart----------------------------
SELECT count(*) FROM geoserver.natuur_netwerk_nederland WHERE beleid_naam_code ='NNN'; -- Prod 206678
SELECT count(*) FROM geoserver.natuur_netwerk_nederland WHERE beleid_naam_code ='NNN' AND eind_geldigheid IS NULL; -- Prod 46755


SELECT * FROM imna.informatie_kaart_natuur cur
WHERE cur.beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam WHERE code = 'NNN')
AND  cur.eind_geldigheid IS NULL -- Prod 46755



----------------------------natura_2000_beheerplannen----------------------------
SELECT count(*) FROM geoserver.natura_2000_beheerplannen WHERE beleid_naam_code ='N2000-BehPlan'; -- Prod 21905
SELECT count(*) FROM geoserver.natura_2000_beheerplannen WHERE beleid_naam_code ='N2000-BehPlan' AND eind_geldigheid IS NULL; -- Prod 790


SELECT * FROM imna.informatie_kaart_natuur cur
WHERE cur.beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam WHERE code = 'N2000-BehPlan')
AND cur.classificatie_1_id IS NOT NULL
AND  cur.eind_geldigheid IS NULL -- Prod 790



----------------------------natuur_netwerk_rijkswateren----------------------------
SELECT count(*) FROM geoserver.natuur_netwerk_rijkswateren WHERE beleid_naam_code ='NNN-Rijksw'; -- Prod 122
SELECT count(*) FROM geoserver.natuur_netwerk_rijkswateren WHERE beleid_naam_code ='NNN-Rijksw' AND eind_geldigheid IS NULL; -- Prod 106


SELECT * FROM imna.informatie_kaart_natuur cur
WHERE cur.beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam WHERE code = 'NNN-Rijksw')
AND  cur.eind_geldigheid IS NULL -- Prod 106


-----------------------------From here the script starts!!!!!----------------------

BEGIN;
----------Start with restoring NNN datamart ---------------
DELETE FROM geoserver.natuur_netwerk_nederland WHERE beleid_naam_code = 'NNN' AND eind_geldigheid IS NOT NULL;

----------Second continue with restoring Natura 2000 Beheerplannen datamart ---------------

------------------Delete geoserver.natura_2000_beheerplannen-----------------------------------
DELETE FROM geoserver.natura_2000_beheerplannen WHERE beleid_naam_code ='N2000-BehPlan' AND eind_geldigheid IS NOT NULL;
      

----------Third continue with restoring Natura 2000 Beheerplannen datamart ---------------

------------------Delete geoserver.natuur_netwerk_rijkswateren-----------------------------------
DELETE FROM geoserver.natuur_netwerk_rijkswateren WHERE beleid_naam_code = 'NNN-Rijksw' AND eind_geldigheid IS NOT NULL;
      
-- COMMIT;
-- ROLLBACK;
