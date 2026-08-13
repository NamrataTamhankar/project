\echo "Deploying RNN-2500 Add column bronhouder_id to table dossier"

ALTER TABLE imna.dossier ADD COLUMN IF NOT EXISTS dossier_bronhouder_id bigint NULL;
ALTER TABLE imna.dossier ALTER COLUMN eigenaar DROP NOT NULL;


CREATE INDEX IF NOT EXISTS IXFK_dossier_dmn_bronhouder_rnn ON imna.dossier (dossier_bronhouder_id ASC);

/* Create Foreign Key Constraints */
SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier','FK_dossier_dmn_bronhouder_rnn',
'ALTER TABLE imna.dossier ADD CONSTRAINT FK_dossier_dmn_bronhouder_rnn
	FOREIGN KEY (dossier_bronhouder_id) REFERENCES masterdata.dmn_bronhouder_rnn (id) ON DELETE No Action ON UPDATE No Action
;');


COMMENT ON COLUMN imna.dossier.dossier_bronhouder_id
	IS 'Reference to rnn_bronhouder'
;
