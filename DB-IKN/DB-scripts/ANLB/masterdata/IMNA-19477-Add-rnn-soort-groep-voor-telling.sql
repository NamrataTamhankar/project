CREATE TABLE IF NOT EXISTS masterdata.dmn_rnn_soort_groep_voor_telling
(
	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata.masterdata_sec'::text)::regclass),
	code varchar(20) NOT NULL,
	description varchar(100) NULL,
	valid_from timestamp NOT NULL,
	valid_to timestamp NULL
)
;

ALTER TABLE masterdata.dmn_rnn_soort_groep_voor_telling
    OWNER to anlb;

SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_rnn_soort_groep_voor_telling','PK_dmn_rnn_soort_groep_voor_telling',
'ALTER TABLE masterdata.dmn_rnn_soort_groep_voor_telling ADD CONSTRAINT PK_dmn_rnn_soort_groep_voor_telling
	PRIMARY KEY (id)
;');


SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_rnn_soort_groep_voor_telling','UN_code_rnn_soort_groep_voor_telling',
'ALTER TABLE masterdata.dmn_rnn_soort_groep_voor_telling ADD CONSTRAINT UN_code_rnn_soort_groep_voor_telling UNIQUE (code)
;');



GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;