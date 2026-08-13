-- imna_cat1_categorie_1_natuurkaart
CREATE OR REPLACE VIEW geoserver.imna_cat1_categorie_1_natuurkaart AS 
SELECT * 
  FROM cat1.categorie_1_natuurkaart;

-- GRANT ACCESS TO snl_sqlpad
ALTER TABLE geoserver.imna_cat1_categorie_1_natuurkaart
    OWNER TO anlb;

GRANT ALL ON TABLE geoserver.imna_cat1_categorie_1_natuurkaart TO anlb;
GRANT SELECT ON TABLE geoserver.imna_cat1_categorie_1_natuurkaart TO anlb_sqlpad;