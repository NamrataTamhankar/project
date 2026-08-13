


/* Create Tables */

--CREATE TABLE IF NOT EXISTS masterdata.dmn_regelink_functie
--(
--	id bigint NOT NULL   DEFAULT NEXTVAL(('masterdata_seq'::text)::regclass),
--	code varchar(20) NOT NULL,
--	description varchar(100) NULL,
--	valid_from timestamp NOT NULL,
--	valid_to timestamp NULL
--)
--;
--
--ALTER TABLE masterdata.dmn_regelink_functie
--    OWNER to anlb;
--
--GRANT SELECT ON TABLE masterdata.dmn_regelink_functie TO besi_readonly;
--
--/* Create Primary Keys, Indexes, Uniques, Checks */
--
--SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_regelink_functie','PK_dmn_regelink_functie',
--'ALTER TABLE masterdata.dmn_regelink_functie ADD CONSTRAINT PK_dmn_regelink_functie
--	PRIMARY KEY (id)
--;');
--
--SELECT pg_temp.create_constraint_if_not_exists ('masterdata','dmn_regelink_functie','UN_code_regelink_functie',
--'ALTER TABLE masterdata.dmn_regelink_functie ADD CONSTRAINT UN_code_regelink_functie UNIQUE (code)
--;');
--
--GRANT SELECT ON ALL TABLES IN SCHEMA masterdata TO anlb_sqlpad;