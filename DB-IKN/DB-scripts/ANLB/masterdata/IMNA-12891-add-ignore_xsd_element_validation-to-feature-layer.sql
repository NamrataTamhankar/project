\echo "IMNA-12891  Add ignore_xsd_element_validation to masterdata.feature-layer."


ALTER TABLE IF EXISTS masterdata.feature_layer
ADD COLUMN IF NOT EXISTS ignore_xsd_element_validation BOOLEAN NOT NULL DEFAULT FALSE;