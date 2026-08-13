/* Create Tables */

CREATE TABLE IF NOT EXISTS masterdata.dmn_kwaliteits_bepaling_expert_oordeel
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_sec'::text)::regclass),
	code varchar(20) NOT NULL,
	description varchar(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_kwaliteits_bepaling_expert_oordeel
    OWNER to anlb;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_kwaliteits_bepaling_expert_oordeel','PK_dmn_kwaliteits_bepaling_expert_oordeel',
'ALTER TABLE masterdata.dmn_kwaliteits_bepaling_expert_oordeel ADD CONSTRAINT PK_dmn_kwaliteits_bepaling_expert_oordeel
	PRIMARY KEY (id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_kwaliteits_bepaling_expert_oordeel','UN_code_kwaliteits_bepaling_expert_oordeel',
'ALTER TABLE masterdata.dmn_kwaliteits_bepaling_expert_oordeel ADD CONSTRAINT UN_code_kwaliteits_bepaling_expert_oordeel UNIQUE (code)
;');

GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;