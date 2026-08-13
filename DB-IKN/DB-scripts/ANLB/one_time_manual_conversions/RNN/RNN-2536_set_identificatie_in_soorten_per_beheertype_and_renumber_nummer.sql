select dossier_id, beheer_type_id, soort_id, nummer from imna.dossier_beheer_type_soorten 
order by dossier_id desc, beheer_type_id, soort_id  

select dossier_id, beheer_type_id, soort_id, nummer, new_nummer from imna.dossier_beheer_type_soorten 
where dossier_id = 18718083 and beheer_type_id = 82 and soort_id = 767659 order by nummer

BEGIN;

--1. Backup tables
CREATE TABLE imna.bak_dossier_beheer_type_soorten AS
SELECT * FROM imna.dossier_beheer_type_soorten;

CREATE TABLE imna.bak_dossier_beheer_type_soorten_tussenresultaat AS
SELECT * FROM imna.dossier_beheer_type_soorten_tussenresultaat;

-- 2. Add new_nummer column to dossier_beheer_type_soorten
ALTER TABLE imna.dossier_beheer_type_soorten
ADD COLUMN new_nummer integer;


-- 3. Fill new_nummer
UPDATE imna.dossier_beheer_type_soorten t
SET new_nummer = r.new_nummer
FROM (
    SELECT
        ctid,
        ROW_NUMBER() OVER (
            PARTITION BY dossier_id, beheer_type_id, soort_id
            ORDER BY nummer
        ) AS new_nummer
    FROM imna.dossier_beheer_type_soorten
) r
WHERE t.ctid = r.ctid;

-- 4. Drop FK in tussenresultaat
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
DROP CONSTRAINT fk_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt;

-- 5. Drop PK in tussenresultaat
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
DROP CONSTRAINT pk_dossier_beheer_type_soorten_tussenresultaat;

-- 6. Drop PK in soorten
ALTER TABLE imna.dossier_beheer_type_soorten
DROP CONSTRAINT pk_dossier_beheer_type_soorten;

-- 7. Update nummer in tussenresultaat
UPDATE imna.dossier_beheer_type_soorten_tussenresultaat tr
SET nummer = s.new_nummer
FROM imna.dossier_beheer_type_soorten s
WHERE tr.dossier_id     = s.dossier_id
  AND tr.beheer_type_id = s.beheer_type_id
  AND tr.soort_id       = s.soort_id
  AND tr.nummer         = s.nummer;
  
-- 8. Replace nummer in soorten
ALTER TABLE imna.dossier_beheer_type_soorten
DROP COLUMN nummer;

ALTER TABLE imna.dossier_beheer_type_soorten
RENAME COLUMN new_nummer TO nummer;

-- 9. Recreate PK soorten
ALTER TABLE imna.dossier_beheer_type_soorten
ADD CONSTRAINT pk_dossier_beheer_type_soorten
PRIMARY KEY (dossier_id, beheer_type_id, soort_id, nummer);

-- 10. Recreate PK tussenresultaat
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
ADD CONSTRAINT pk_dossier_beheer_type_soorten_tussenresultaat
PRIMARY KEY (dossier_id, soort_id, beheer_type_id, kwalificerende_kenmerk_id, nummer);

-- 11. Recreate FK
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
ADD CONSTRAINT fk_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt
FOREIGN KEY (dossier_id, beheer_type_id, soort_id, nummer)
REFERENCES imna.dossier_beheer_type_soorten (dossier_id, beheer_type_id, soort_id, nummer);

ALTER TABLE imna.dossier_beheer_type_soorten
ALTER COLUMN nummer SET NOT NULL;
COMMIT;

-- 12. Cleanup (optional)
DROP TABLE imna.bak_dossier_beheer_type_soorten;
DROP TABLE imna.bak_dossier_beheer_type_soorten_tussenresultaat;



UPDATE imna.dossier_beheer_type_soorten AS s
SET identificatie = bt.code || '_' || tx.scientific || '_' || s.nummer
FROM masterdata.dmn_beheer_type AS bt,
     ndff.taxa AS tx
WHERE bt.id = s.beheer_type_id
  AND tx.id = s.soort_id;

