/* GRANT USAGE ON SCHEMA */

\echo "Starting deployment of IMNa schema for IKN automatic deployment"

GRANT USAGE ON SCHEMA imna TO ikn_geoweb;

GRANT SELECT ON imna.informatie_kaart_natuur TO ikn_geoweb;

