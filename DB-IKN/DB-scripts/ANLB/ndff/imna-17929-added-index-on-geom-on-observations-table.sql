DROP INDEX IF EXISTS "ndff"."IDX_basis_grid_geom";

CREATE INDEX IF NOT EXISTS "IDX_ndff_waarnemingen_geom"
    ON ndff.ndff_waarnemingen USING gist
    (geom);
	
CREATE INDEX IF NOT EXISTS IXFK_ndff_waarnemingen_begin_geldigheid ON ndff.ndff_waarnemingen (begin_geldigheid ASC)
;

CREATE INDEX IF NOT EXISTS IXFK_ndff_waarnemingen_eind_geldigheid ON ndff.ndff_waarnemingen (eind_geldigheid ASC)
;