BEGIN;

UPDATE imna.dossier 
SET maatlat_versie = 'Maatlatten-versie-mei-2025'
WHERE datum_beoordeling > DATE '2025-09-17'
RETURNING *;

--COMMIT;
--ROLLBACK;