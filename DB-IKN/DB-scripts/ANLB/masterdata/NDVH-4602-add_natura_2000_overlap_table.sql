\echo "Starting deployment of NDVH masterdata NDVH-4602 - table natura_2000_overlap"

CREATE TABLE IF NOT EXISTS masterdata.natura_2000_overlap
(
	gebiedsnummer_1 integer NOT NULL,
	gebiedsnummer_2 integer NOT NULL
)
;

ALTER TABLE masterdata.natura_2000_overlap
    OWNER to anlb;

GRANT SELECT ON masterdata.natura_2000_overlap TO anlb_sqlpad;

/* Create Primary Keys, Indexes, Uniques, Checks */
SELECT pg_temp.create_constraint_if_not_exists ('masterdata','natura_2000_overlap','PK_natura_2000_overlap',
'ALTER TABLE masterdata.natura_2000_overlap ADD CONSTRAINT PK_natura_2000_overlap
	PRIMARY KEY (gebiedsnummer_1,gebiedsnummer_2)
;');

/* Create Table Comments, Sequences for Autonumber Columns */
COMMENT ON TABLE masterdata.natura_2000_overlap
	IS 'Masterdata table loaded from the domain sheet. Combinations of areas in this table will be allowed to overlap '
;