DROP VIEW geoserver.imna_vrn_resterende_inrichtings_ambitie;
DROP VIEW geoserver.imna_vrn_gebied_verwerving;
DROP VIEW imna.v_gs_resterende_inrichtings_ambitie;
DROP VIEW imna.v_gs_gebied_verwerving;

ALTER TABLE imna.resterende_inrichtings_ambitie 
DROP COLUMN IF EXISTS resterende_inrichting_natuurpact,
DROP COLUMN IF EXISTS resterende_inrichting_aanvullend,
ADD COLUMN resterende_inrichtings_ambitie integer NOT NULL;


DROP INDEX IF EXISTS imna.IXFK_dmn_status_verwerving
;

ALTER TABLE imna.gebied_verwerving 
DROP CONSTRAINT FK_dmn_status_verwerving ,
DROP COLUMN IF EXISTS status_verwerving_id
;


