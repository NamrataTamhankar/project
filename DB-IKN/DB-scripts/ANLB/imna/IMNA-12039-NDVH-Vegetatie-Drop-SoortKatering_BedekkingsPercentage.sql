\echo "IMNA-12039 Drop soort_katering.bedekkings_percentage"

ALTER TABLE IF EXISTS imna.soort_kartering 
DROP COLUMN IF EXISTS bedekkings_percentage;