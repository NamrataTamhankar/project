\echo "IMNA-13735 Switch VegetationPackage Geom from Polygon to Geometry"

DO
$$
BEGIN
    -- Look for our constraint
    IF EXISTS (SELECT 1 
				 FROM geometry_columns 
				WHERE f_table_schema = 'geoserver' 
				  AND f_table_name = 'ndvh_vegetatie_package' 
				  AND f_geometry_column = 'geom'
	              AND type = 'POLYGON')
    THEN
        EXECUTE '
			ALTER TABLE geoserver.ndvh_vegetatie_package 
				ALTER COLUMN geom type geometry;
		';
		RAISE NOTICE 'Change geometry on ndvh_vegetatie_package.geom';
    END IF;
END;
$$ LANGUAGE 'plpgsql';
