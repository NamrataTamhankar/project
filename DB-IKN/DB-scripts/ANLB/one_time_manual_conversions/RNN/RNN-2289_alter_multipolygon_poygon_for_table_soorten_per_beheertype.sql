
----------------------------------------------------------------
-- 0) Backups (safe copy of existing data)
----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS imna.dossier_beheer_type_soorten_bak AS
SELECT * FROM imna.dossier_beheer_type_soorten;

CREATE TABLE IF NOT EXISTS imna.dossier_beheer_type_soorten_tussenresultaat_bak AS
SELECT * FROM imna.dossier_beheer_type_soorten_tussenresultaat;


----------------------------------------------------------------
-- 1) Add nummer column if not present
----------------------------------------------------------------
ALTER TABLE imna.dossier_beheer_type_soorten
  ADD COLUMN IF NOT EXISTS nummer integer;

ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
  ADD COLUMN IF NOT EXISTS nummer integer;


----------------------------------------------------------------
-- 2) Drop FKs that reference the old PKs (if they exist)
----------------------------------------------------------------
ALTER TABLE IF EXISTS imna.dossier_beheer_type_soorten_tussenresultaat
  DROP CONSTRAINT IF EXISTS fk_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt;

ALTER TABLE IF EXISTS imna.dossier_beheer_type_soorten
  DROP CONSTRAINT IF EXISTS fk_dossier_beheer_type_soorten_dossier_beheer_type;

ALTER TABLE IF EXISTS imna.dossier_beheer_type_soorten_tussenresultaat
  DROP CONSTRAINT IF EXISTS fk_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk;


----------------------------------------------------------------
-- 3) Drop existing primary keys (if they exist)
----------------------------------------------------------------
ALTER TABLE IF EXISTS imna.dossier_beheer_type_soorten
  DROP CONSTRAINT IF EXISTS pk_dossier_beheer_type_soorten;

ALTER TABLE IF EXISTS imna.dossier_beheer_type_soorten_tussenresultaat
  DROP CONSTRAINT IF EXISTS pk_dossier_beheer_type_soorten_tussenresultaat;
  



----------------------------------------------------------------
-- 4) Explode MultiPolygons, keep NULL geoms, assign nummer
----------------------------------------------------------------
------------------------------------------------------------
-- 2. INSERT NULL-GEOMETRY RECORDS (nummer = 1)
------------------------------------------------------------
CREATE TABLE imna.dossier_beheer_type_soorten_new AS
WITH expanded AS (
    -- 1. Rows with geometry → dump multipolygon into polygons
    SELECT
        dossier_id,
        beheer_type_id,
        soort_id,
        waargenomen,
        (ST_Dump(geom)).geom::geometry(Polygon, 28992) AS geom,
        FALSE AS is_null_geom
    FROM imna.dossier_beheer_type_soorten_bak
    WHERE geom IS NOT NULL

    UNION ALL

    -- 2. Rows without geometry → keep one record, nummer = 1 later
    SELECT
        dossier_id,
        beheer_type_id,
        soort_id,
        waargenomen,
        NULL::geometry(Polygon, 28992) AS geom,
        TRUE AS is_null_geom
    FROM imna.dossier_beheer_type_soorten_bak
    WHERE geom IS NULL
)
SELECT
    dossier_id,
    beheer_type_id,
    soort_id,
    waargenomen,
    -- nummer per original record:
    ROW_NUMBER() OVER (
        PARTITION BY dossier_id, beheer_type_id, soort_id
        ORDER BY is_null_geom, geom  -- ensures NULL geom receives nummer=1
    ) AS nummer,
    geom
FROM expanded;



-- Ensure nummer is not null on new table
ALTER TABLE imna.dossier_beheer_type_soorten_new
  ALTER COLUMN nummer SET NOT NULL;


----------------------------------------------------------------
-- 5) Replace original table rows safely
--    (we truncate then insert from new table)
----------------------------------------------------------------
TRUNCATE imna.dossier_beheer_type_soorten;

ALTER TABLE imna.dossier_beheer_type_soorten
    ALTER COLUMN geom TYPE geometry(Polygon)
    USING geom::geometry(Polygon);
	

INSERT INTO imna.dossier_beheer_type_soorten (
    dossier_id, beheer_type_id, soort_id, waargenomen, nummer, geom
)
SELECT dossier_id, beheer_type_id, soort_id, waargenomen, nummer, geom
FROM imna.dossier_beheer_type_soorten_new;


-- drop helper table
DROP TABLE imna.dossier_beheer_type_soorten_new;


----------------------------------------------------------------
-- 6) Rebuild tussenresultaat: duplicate rows per new nummer
----------------------------------------------------------------
CREATE TABLE imna.dossier_beheer_type_soorten_tussenresultaat_new AS
SELECT
    t.dossier_id,
    t.beheer_type_id,
    t.soort_id,
    s.nummer,
    t.kwalificerende_kenmerk_id,
    t.waarde
FROM imna.dossier_beheer_type_soorten_tussenresultaat t
JOIN imna.dossier_beheer_type_soorten s
  ON s.dossier_id = t.dossier_id
 AND s.beheer_type_id = t.beheer_type_id
 AND s.soort_id = t.soort_id;


-- make nummer not null in the new table
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat_new
  ALTER COLUMN nummer SET NOT NULL;


-- replace original tussenresultaat
TRUNCATE imna.dossier_beheer_type_soorten_tussenresultaat;

INSERT INTO imna.dossier_beheer_type_soorten_tussenresultaat (
    dossier_id, beheer_type_id, soort_id, nummer, kwalificerende_kenmerk_id, waarde
)
SELECT dossier_id, beheer_type_id, soort_id, nummer, kwalificerende_kenmerk_id, waarde
FROM imna.dossier_beheer_type_soorten_tussenresultaat_new;

DROP TABLE imna.dossier_beheer_type_soorten_tussenresultaat_new;


----------------------------------------------------------------
-- 7) Recreate primary keys (include nummer)
----------------------------------------------------------------
ALTER TABLE imna.dossier_beheer_type_soorten
  ADD CONSTRAINT pk_dossier_beheer_type_soorten
    PRIMARY KEY (dossier_id, beheer_type_id, soort_id, nummer);

ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
  ADD CONSTRAINT pk_dossier_beheer_type_soorten_tussenresultaat
    PRIMARY KEY (dossier_id, soort_id, beheer_type_id, kwalificerende_kenmerk_id, nummer);


----------------------------------------------------------------
-- 8) Recreate foreign keys (include nummer where appropriate)
----------------------------------------------------------------
-- soorten -> dossier_beheer_type (unchanged)
ALTER TABLE imna.dossier_beheer_type_soorten
  ADD CONSTRAINT fk_dossier_beheer_type_soorten_dossier_beheer_type
    FOREIGN KEY (dossier_id, beheer_type_id)
    REFERENCES imna.dossier_beheer_type (dossier_id, beheer_type_id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- tussenresultaat -> soorten (now includes nummer)
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
  ADD CONSTRAINT fk_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt
    FOREIGN KEY (dossier_id, beheer_type_id, soort_id, nummer)
    REFERENCES imna.dossier_beheer_type_soorten (dossier_id, beheer_type_id, soort_id, nummer)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

-- tussenresultaat -> kwalificerende_kenmerk (unchanged)
ALTER TABLE imna.dossier_beheer_type_soorten_tussenresultaat
  ADD CONSTRAINT fk_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk
    FOREIGN KEY (kwalificerende_kenmerk_id)
    REFERENCES masterdata.dmn_kwalificerende_kenmerk (id)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;






-- Drop back up and temp table
DROP TABLE IF EXISTS imna.dossier_beheer_type_soorten_bak;
DROP TABLE IF EXISTS imna.dossier_beheer_type_soorten_tussenresultaat_bak;


CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_soorten_dossier_beheer_type ON imna.dossier_beheer_type_soorten (dossier_id ASC,beheer_type_id ASC);
CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_soorten_soort ON imna.dossier_beheer_type_soorten (soort_id ASC);
CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt ON imna.dossier_beheer_type_soorten_tussenresultaat (dossier_id ASC,beheer_type_id ASC,soort_id ASC);
CREATE INDEX IF NOT EXISTS IXFK_dossier_beheer_type_srt_tussenrslt_kwalificerende_kenmerk ON imna.dossier_beheer_type_soorten_tussenresultaat (kwalificerende_kenmerk_id ASC);


ALTER TABLE imna.dossier_beheer_type_soorten ADD CONSTRAINT FK_dossier_beheer_type_soorten_soort
	FOREIGN KEY (soort_id) REFERENCES ndff.taxa (id) ON DELETE No Action ON UPDATE No Action;

