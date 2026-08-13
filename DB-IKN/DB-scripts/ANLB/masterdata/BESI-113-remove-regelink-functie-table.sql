\echo "IMNA-113 Remove Functie Regelink from masterdata tables"

DROP VIEW IF EXISTS masterdata.all_domain_features;
DROP VIEW IF EXISTS masterdata.all_domains;
DROP TABLE IF EXISTS masterdata.dmn_regelink_functie;