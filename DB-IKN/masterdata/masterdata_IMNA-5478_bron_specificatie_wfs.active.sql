ALTER TABLE masterdata.bron_specificatie_wfs 
	ADD COLUMN active boolean NOT NULL   DEFAULT false    -- indicates if this specific WFS source is currently active and data should be loaded from it
;

COMMENT ON COLUMN masterdata.bron_specificatie_wfs.active
	IS 'indicates if this specific WFS source is currently active and data should be loaded from it'
; 	