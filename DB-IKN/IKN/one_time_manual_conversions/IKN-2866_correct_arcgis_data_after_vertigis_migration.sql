BEGIN;

---------------------NOORD-HOLLAND - NNN --------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for NNN for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for NNN for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of NNN for Noord-Holland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of NNN for Noord-Holland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;


---------------------NOORD-HOLLAND - WWK_NNN --------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'WWK_NNN'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for WWK_NNN for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'WWK_NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for WWK_NNN for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'WWK_NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of WWK_NNN for Noord-Holland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'WWK_NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'WWK_NNN'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of WWK_NNN for Noord-Holland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'WWK_NNN'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'WWK_NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'WWK_NNN'
    )
)
RETURNING *;



---------------------NOORD-HOLLAND - Besch-Houtopstanden --------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Besch-Houtopstanden'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for Besch-Houtopstanden for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Besch-Houtopstanden'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for Besch-Houtopstanden for Noord-Holland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Besch-Houtopstanden'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of Besch-Houtopstanden for Noord-Holland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Besch-Houtopstanden'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Besch-Houtopstanden'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of Besch-Houtopstanden for Noord-Holland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '27')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Besch-Houtopstanden'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '27'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Besch-Houtopstanden'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '27'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Besch-Houtopstanden'
    )
)
RETURNING *;


----------------------------------------------------------------
--------------------- GRONINGEN - NNN --------------------------
----------------------------------------------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '20'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for NNN for GRONINGEN to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '20'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for NNN for GRONINGEN to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '20'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of NNN for GRONINGEN
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '20'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '20'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of NNN for GRONINGEN
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '20')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '20'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '20'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;


----------------------------------------------------------------
--------------------- Friesland - NNN --------------------------
----------------------------------------------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for NNN for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for NNN for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of NNN for Friesland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of NNN for Friesland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'NNN'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'NNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'NNN'
    )
)
RETURNING *;


--------------------- Friesland - GFG --------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'GFG'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for GFG for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'GFG'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for GFG for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'GFG'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of GFG for Friesland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'GFG'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'GFG'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of GFG for Friesland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'GFG'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'GFG'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'GFG'
    )
)
RETURNING *;

--------------------- Friesland - Bos-Natuur-BuitenNNN --------------------------

-- Remove last delivery files from geoweb.ikn_upload_files
 SELECT * FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'))));

DELETE FROM geoweb.ikn_upload_files 
 WHERE ikn_upload_id = (SELECT id FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'))))
	 RETURNING *;

-- Remove last delivery files from geoweb.ikn_upload
 SELECT * FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')));


 DELETE FROM geoweb.ikn_upload
 WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND informatie_kaart_aanlevering_id = (SELECT id FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')))
	 RETURNING *;

-- SET revision to revision - 1 day
SELECT *, (laatste_revisie - INTERVAL '1 day') AS new_revision_date FROM masterdata.bron_specificatie_wfs 
WHERE bronhouder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN');

-- Set revision back 1 day
UPDATE masterdata.bron_specificatie_wfs
SET laatste_revisie = laatste_revisie - INTERVAL '1 day'
WHERE bronhouder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Bos-Natuur-BuitenNNN'
)
RETURNING *;


-- Set previous data in imna.informatie_kaart_natuur for Bos-Natuur-BuitenNNN for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_natuur
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN');

-- Set previous data in imna.informatie_kaart_natuur to null
UPDATE imna.informatie_kaart_natuur
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Bos-Natuur-BuitenNNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
RETURNING *;

-- Set previous data delivery in imna.informatie_kaart_aanlevering for Bos-Natuur-BuitenNNN for Friesland to last begin_geldigheid
SELECT * FROM imna.informatie_kaart_aanlevering
WHERE eind_geldigheid = (SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'))
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN');
	 
-- Set previous data delivery in imna.informatie_kaart_aanlevering to null
UPDATE imna.informatie_kaart_aanlevering
SET eind_geldigheid = NULL
WHERE eind_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Bos-Natuur-BuitenNNN'
    )
)
AND bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
RETURNING *;

 -- Remove data in imna.informatie_kaart_natuur for the latest harves of Bos-Natuur-BuitenNNN for Friesland
SELECT * FROM imna.informatie_kaart_natuur
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_natuur
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'));
	 
-- Remove latest harvest from imna.informatie_kaart_natuur
DELETE FROM imna.informatie_kaart_natuur
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Bos-Natuur-BuitenNNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_natuur
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Bos-Natuur-BuitenNNN'
    )
)
RETURNING *;
 
 -- Remove data in imna.informatie_kaart_aanlevering for the latest harves of Bos-Natuur-BuitenNNN for Friesland
 SELECT * FROM imna.informatie_kaart_aanlevering
 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN')
 AND begin_geldigheid = 
 	(SELECT MAX(begin_geldigheid) 
	 FROM imna.informatie_kaart_aanlevering
	 WHERE bron_houder_id = (SELECT id FROM masterdata.dmn_bronhouder where code = '21')
	 AND beleid_naam_id = (SELECT id FROM masterdata.dmn_beleid_naam where code = 'Bos-Natuur-BuitenNNN'));

-- Remove latest harvest from imna.informatie_kaart_aanlevering
DELETE FROM imna.informatie_kaart_aanlevering
WHERE bron_houder_id = (
    SELECT id
    FROM masterdata.dmn_bronhouder
    WHERE code = '21'
)
AND beleid_naam_id = (
    SELECT id
    FROM masterdata.dmn_beleid_naam
    WHERE code = 'Bos-Natuur-BuitenNNN'
)
AND begin_geldigheid = (
    SELECT MAX(begin_geldigheid)
    FROM imna.informatie_kaart_aanlevering
    WHERE bron_houder_id = (
        SELECT id
        FROM masterdata.dmn_bronhouder
        WHERE code = '21'
    )
    AND beleid_naam_id = (
        SELECT id
        FROM masterdata.dmn_beleid_naam
        WHERE code = 'Bos-Natuur-BuitenNNN'
    )
)
RETURNING *;



----------------------------------------------------------------
--------------------- Utrecht - NNN --------------------------
----------------------------------------------------------------


-- COMMIT;
-- ROLLBACK;