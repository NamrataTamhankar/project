\echo "Deploying IMNA-10928 adding dmn_status_nnn"

/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_status_nnn
(
	id bigint NOT NULL,
	code char(20) NOT NULL,
	description char(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

/* Create Primary Keys, Indexes, Uniques, Checks */


SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_nnn','PK_dmn_status_nnn',
'ALTER TABLE masterdata.dmn_status_nnn ADD CONSTRAINT PK_dmn_status_nnn
	PRIMARY KEY (id)
;');

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_status_nnn','un_code_status_nnn',
'ALTER TABLE masterdata.dmn_status_nnn ADD CONSTRAINT un_code_status_nnn UNIQUE (code)
;');

ALTER TABLE IF EXISTS masterdata.dmn_status_nnn
    OWNER to anlb;

GRANT SELECT ON masterdata.dmn_status_nnn TO anlb_sqlpad;


