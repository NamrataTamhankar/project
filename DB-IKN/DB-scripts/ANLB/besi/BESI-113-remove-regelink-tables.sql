\echo "IMNA-113 Remove Regelink tables"
DROP VIEW IF EXISTS besi.v_gw_besi_star_regelink;

DROP TABLE IF EXISTS besi.regelink_functie_kans_versie;
DROP TABLE IF EXISTS besi.taxa_regelink_functie_geo_object_kans;
DROP TABLE IF EXISTS besi.effect_regelink_functie;
DROP TABLE IF EXISTS besi.geo_object;

