-- Update eind_geldigheid for the beschikking_rapportage and beschikking tables for the provincie Overijssel
--beschikking_rapportage*
update imna.beschikking_rapportage
set eind_geldigheid =  to_timestamp('2025-07-25 18:01:06', 'YYYY-MM-DD HH24:MI:SS')
where id = 14465770 and provincie_id=81297 and beheer_jaar = 2024;

update imna.beschikking_rapportage
set eind_geldigheid =  to_timestamp('2025-07-25 18:05:15', 'YYYY-MM-DD HH24:MI:SS')
where id = 16115102 and provincie_id=81297 and beheer_jaar = 2025;

update imna.beschikking_rapportage
set eind_geldigheid =  to_timestamp('2025-08-01 09:44:23', 'YYYY-MM-DD HH24:MI:SS')
where id = 16203234 and provincie_id=81297 and beheer_jaar = 2025;

update imna.beschikking_rapportage
set eind_geldigheid =  to_timestamp('2025-08-01 09:47:31', 'YYYY-MM-DD HH24:MI:SS')
where id = 16203240 and provincie_id=81297 and beheer_jaar = 2025;



--beschikking*
update imna.beschikking
set eind_geldigheid =  to_timestamp('2025-07-25 18:05:15', 'YYYY-MM-DD HH24:MI:SS')
where beschikking_rapportage_id = 16115102 and provincie_id=81297;

update imna.beschikking
set eind_geldigheid =  to_timestamp('2025-08-01 09:47:31', 'YYYY-MM-DD HH24:MI:SS')
where beschikking_rapportage_id = 16203240 and provincie_id=81297;

