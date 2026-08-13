\echo "Deploying RNN-2500 Add identificatie column to soorten_per_beheertype"

ALTER TABLE imna.dossier_beheer_type_soorten ADD COLUMN IF NOT EXISTS identificatie varchar(100);

-- After identificatie is filled for every record in table soorten_per_beheertype
--ALTER TABLE imna.dossier_beheer_type_soorten ADD COLUMN IF NOT EXISTS identificatie varchar(100) NOT NULL;

SELECT pg_temp.create_constraint_if_not_exists ('imna','dossier_beheer_type_soorten','UN_dossier_beheer_type_dossier_id_identificatie',
'ALTER TABLE imna.dossier_beheer_type_soorten ADD CONSTRAINT UN_dossier_beheer_type_dossier_id_identificatie UNIQUE (identificatie, dossier_id)
;');

