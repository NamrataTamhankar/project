\echo "Starting deployment of BESI-2611 for besi schema"

CREATE TABLE IF NOT EXISTS besi.maatregelenblad
(
	werkzaamheid_id bigint NOT NULL,
	maatregelenblad_tekst varchar(8000) NULL
);

ALTER TABLE besi.maatregelenblad
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

SELECT pg_temp.create_constraint_if_not_exists ('besi','maatregelenblad','PK_maatregelenblad_werkzaamheid',
'ALTER TABLE besi.maatregelenblad ADD CONSTRAINT PK_maatregelenblad_werkzaamheid
	PRIMARY KEY (werkzaamheid_id)
;');

CREATE INDEX IF NOT EXISTS IXFK_maatregelenblad_werkzaamheid ON besi.maatregelenblad (werkzaamheid_id ASC);

/* Create Foreign Key Constraints */

SELECT pg_temp.create_constraint_if_not_exists ('besi','maatregelenblad','FK_maatregelenblad_werkzaamheid',
'ALTER TABLE besi.maatregelenblad ADD CONSTRAINT FK_maatregelenblad_werkzaamheid
	FOREIGN KEY (werkzaamheid_id) REFERENCES dso.werkzaamheid (id) ON DELETE No Action ON UPDATE No Action
;');

COMMENT ON TABLE besi.maatregelenblad
	IS 'The maatregelenblad table stores text that contains nature information about the '
;

GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;