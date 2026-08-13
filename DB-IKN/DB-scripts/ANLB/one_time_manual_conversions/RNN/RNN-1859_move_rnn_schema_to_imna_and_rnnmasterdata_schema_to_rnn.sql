	BEGIN;
    -- Step 0: Make all relevant foreign key constraints DEFERRABLE
    -- Repeat for each table that contains foreign keys referencing renumbered IDs

	
	-- waarneming_flora_en_fauna
	ALTER TABLE rnn.waarneming_flora_en_fauna ALTER CONSTRAINT FK_waarneming_flora_en_fauna_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-- originele_dossier_beheer_gebied
	ALTER TABLE rnn.originele_dossier_beheer_gebied ALTER CONSTRAINT FK_originele_dossier_beheer_gebied_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-- dossier_beheer_gebied
	ALTER TABLE rnn.dossier_beheer_gebied ALTER CONSTRAINT FK_dossier_beheer_gebied_originele_dossier_beheer_gebied DEFERRABLE INITIALLY DEFERRED;
	
	-- dossier_beoordelings_gebied
	ALTER TABLE rnn.dossier_beoordelings_gebied ALTER CONSTRAINT FK_dossier_beoordelings_gebied_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-- dossier_beheer_type
	ALTER TABLE rnn.dossier_beheer_type ALTER CONSTRAINT FK_dossier_beheer_type_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-- dossier_beheer_type_soorten
	ALTER TABLE rnn.dossier_beheer_type_soorten ALTER CONSTRAINT FK_dossier_beheer_type_soorten_dossier_beheer_type DEFERRABLE INITIALLY DEFERRED;
	
	-- dossier_beheer_type_soorten_tussenresultaat
	ALTER TABLE rnn.dossier_beheer_type_soorten_tussenresultaat ALTER CONSTRAINT FK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt DEFERRABLE INITIALLY DEFERRED;
	
	-- beheer_type_tussenresultaat
	ALTER TABLE rnn.beheer_type_tussenresultaat ALTER CONSTRAINT FK_beheer_type_tussenresultaat_dossier_beheer_type DEFERRABLE INITIALLY DEFERRED;
	
	-- beheer_type_beoordelingsresultaat
	ALTER TABLE rnn.beheer_type_beoordelingsresultaat ALTER CONSTRAINT FK_beheer_type_beoordelingsresultaat_dossier_beheer_type DEFERRABLE INITIALLY DEFERRED;
	
	-- originele_waarneming_standplaats_factoren
	ALTER TABLE rnn.originele_waarneming_standplaats_factoren ALTER CONSTRAINT FK_originele_waarneming_standplaats_factoren_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-- waarneming_standplaats_factoren
	ALTER TABLE rnn.waarneming_standplaats_factoren ALTER CONSTRAINT FK_waarneming_spf DEFERRABLE INITIALLY DEFERRED;
	ALTER TABLE rnn.waarneming_standplaats_factoren ALTER CONSTRAINT FK_waarneming_spf_originele_waarneming_spf DEFERRABLE INITIALLY DEFERRED;
	
	-- waarneming_standplaats_factor_tussenresultaat
	ALTER TABLE rnn.waarneming_standplaats_factor_tussenresultaat ALTER CONSTRAINT FK_waarneming_spf_tussenresultaat_waarneming_spf DEFERRABLE INITIALLY DEFERRED;
	
	-- waarneming_standplaats_factoren_beoordeling
	ALTER TABLE rnn.waarneming_standplaats_factoren_beoordeling ALTER CONSTRAINT FK_waarneming_spf_beoordeling_waarneming_spf DEFERRABLE INITIALLY DEFERRED;
	
	-- beheer_gebied_standplaats_tussenresultaat
	ALTER TABLE rnn.beheer_gebied_standplaats_tussenresultaat ALTER CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier DEFERRABLE INITIALLY DEFERRED;
	ALTER TABLE rnn.beheer_gebied_standplaats_tussenresultaat ALTER CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier_beheer_gebied DEFERRABLE INITIALLY DEFERRED;
	
	-- beheer_gebied_standplaats_beoordeling
	ALTER TABLE rnn.beheer_gebied_standplaats_beoordeling ALTER CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier_beheer_gebied DEFERRABLE INITIALLY DEFERRED;
	ALTER TABLE rnn.beheer_gebied_standplaats_beoordeling ALTER CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier DEFERRABLE INITIALLY DEFERRED;
	
	-----------------------------------------------------
	-----------------------------------------------------
	-- Step 1: Create mapping table and update 'dossier'
    CREATE TEMP TABLE temp_id_map_dossier (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_dossier(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.dossier;
	CREATE INDEX ON temp_id_map_dossier (old_id);

    UPDATE rnn.dossier d
    SET id = m.new_id
    FROM temp_id_map_dossier m
    WHERE d.id = m.old_id;

    -- Update referencing foreign keys
    UPDATE rnn.waarneming_flora_en_fauna t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;

    UPDATE rnn.originele_dossier_beheer_gebied t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;

    UPDATE rnn.dossier_beheer_type t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.dossier_beheer_type_soorten t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.dossier_beheer_type_soorten_tussenresultaat t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;

    UPDATE rnn.dossier_beoordelings_gebied t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.originele_waarneming_standplaats_factoren t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;

	UPDATE rnn.beheer_gebied_standplaats_tussenresultaat t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.beheer_gebied_standplaats_beoordeling t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.beheer_type_tussenresultaat t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;
	
	UPDATE rnn.beheer_type_beoordelingsresultaat t
    SET dossier_id = m.new_id
    FROM temp_id_map_dossier m
    WHERE t.dossier_id = m.old_id;

	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 2: 'originele_dossier_beheer_gebied'
    CREATE TEMP TABLE temp_id_map_orig_dossier_beheer (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_orig_dossier_beheer(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.originele_dossier_beheer_gebied;
	CREATE INDEX ON temp_id_map_orig_dossier_beheer (old_id);

    UPDATE rnn.originele_dossier_beheer_gebied t
    SET id = m.new_id
    FROM temp_id_map_orig_dossier_beheer m
    WHERE t.id = m.old_id;
	
	-- Update referencing foreign keys
	UPDATE rnn.dossier_beheer_gebied t
    SET originele_beheer_gebied_id = m.new_id
    FROM temp_id_map_orig_dossier_beheer m
    WHERE t.originele_beheer_gebied_id  = m.old_id;
	
	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 3: 'dossier_beheer_gebied'
    CREATE TEMP TABLE temp_id_map_dossier_beheer_gebied (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_dossier_beheer_gebied(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.dossier_beheer_gebied;
	CREATE INDEX ON temp_id_map_dossier_beheer_gebied (old_id);

    UPDATE rnn.dossier_beheer_gebied t
    SET id = m.new_id
    FROM temp_id_map_dossier_beheer_gebied m
    WHERE t.id = m.old_id;

    -- Update referencing foreign keys
    UPDATE rnn.waarneming_standplaats_factoren t
    SET dossier_beheergebied_id = m.new_id
    FROM temp_id_map_dossier_beheer_gebied m
    WHERE t.dossier_beheergebied_id = m.old_id;
	
	UPDATE rnn.beheer_gebied_standplaats_tussenresultaat t
    SET dossier_beheer_gebied_id = m.new_id
    FROM temp_id_map_dossier_beheer_gebied m
    WHERE t.dossier_beheer_gebied_id = m.old_id;
	
	UPDATE rnn.beheer_gebied_standplaats_beoordeling t
    SET dossier_beheer_gebied_id = m.new_id
    FROM temp_id_map_dossier_beheer_gebied m
    WHERE t.dossier_beheer_gebied_id = m.old_id;
	
	-----------------------------------------------------
	-----------------------------------------------------
	-- Step 4: 'waarneming_flora_en_fauna'	
    CREATE TEMP TABLE temp_id_map_wff (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_wff(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.waarneming_flora_en_fauna;
	CREATE INDEX ON temp_id_map_wff (old_id);

    UPDATE rnn.waarneming_flora_en_fauna t
    SET id = m.new_id
    FROM temp_id_map_wff m
    WHERE t.id = m.old_id;

	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 5: 'originele_waarneming_standplaats_factoren'
    CREATE TEMP TABLE temp_id_map_orig_wsf (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_orig_wsf(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.originele_waarneming_standplaats_factoren;
	CREATE INDEX ON temp_id_map_orig_wsf (old_id);

    UPDATE rnn.originele_waarneming_standplaats_factoren t
    SET id = m.new_id
    FROM temp_id_map_orig_wsf m
    WHERE t.id = m.old_id;
	
	-- Update referencing foreign keys
	UPDATE rnn.waarneming_standplaats_factoren t
    SET originele_waarneming_standplaats_factoren_id = m.new_id
    FROM temp_id_map_orig_wsf m
    WHERE t.originele_waarneming_standplaats_factoren_id = m.old_id;

	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 6: 'waarneming_standplaats_factoren'
    CREATE TEMP TABLE temp_id_map_wsf (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_wsf(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.waarneming_standplaats_factoren;
	CREATE INDEX ON temp_id_map_wsf (old_id);

    UPDATE rnn.waarneming_standplaats_factoren t
    SET id = m.new_id
    FROM temp_id_map_wsf m
    WHERE t.id = m.old_id;
	
	-- Update referencing foreign keys
	UPDATE rnn.waarneming_standplaats_factor_tussenresultaat t
    SET waarneming_standplaatsfactoren_id = m.new_id
    FROM temp_id_map_wsf m
    WHERE t.waarneming_standplaatsfactoren_id = m.old_id;
	
	UPDATE rnn.waarneming_standplaats_factoren_beoordeling t
    SET waarneming_standplaatsfactoren_id = m.new_id
    FROM temp_id_map_wsf m
    WHERE t.waarneming_standplaatsfactoren_id = m.old_id;
	
	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 6.5: 'waarneming_standplaats_factoren'
	CREATE TEMP TABLE temp_id_map_dbg (old_id bigint, new_id bigint);
    INSERT INTO temp_id_map_dbg(old_id, new_id)
    SELECT id, nextval('imna.imna_seq') FROM rnn.dossier_beoordelings_gebied;
	CREATE INDEX ON temp_id_map_dbg (old_id);

    UPDATE rnn.dossier_beoordelings_gebied t
    SET id = m.new_id
    FROM temp_id_map_dbg m
    WHERE t.id = m.old_id;
  
	COMMIT;
  
	BEGIN;
  
   	-- Undo DEFERRABLE INITIALLY DEFERRED for the listed foreign key constraints
	ALTER TABLE rnn.waarneming_flora_en_fauna ALTER CONSTRAINT FK_waarneming_flora_en_fauna_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.originele_dossier_beheer_gebied ALTER CONSTRAINT FK_originele_dossier_beheer_gebied_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.dossier_beheer_gebied ALTER CONSTRAINT FK_dossier_beheer_gebied_originele_dossier_beheer_gebied NOT DEFERRABLE;
	ALTER TABLE rnn.dossier_beoordelings_gebied ALTER CONSTRAINT FK_dossier_beoordelings_gebied_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.dossier_beheer_type ALTER CONSTRAINT FK_dossier_beheer_type_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.dossier_beheer_type_soorten ALTER CONSTRAINT FK_dossier_beheer_type_soorten_dossier_beheer_type NOT DEFERRABLE;
	ALTER TABLE rnn.dossier_beheer_type_soorten_tussenresultaat ALTER CONSTRAINT FK_dossier_beheer_type_srt_tussenrslt_dossier_beheer_type_srt NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_type_tussenresultaat ALTER CONSTRAINT FK_beheer_type_tussenresultaat_dossier_beheer_type NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_type_beoordelingsresultaat ALTER CONSTRAINT FK_beheer_type_beoordelingsresultaat_dossier_beheer_type NOT DEFERRABLE;
	ALTER TABLE rnn.originele_waarneming_standplaats_factoren ALTER CONSTRAINT FK_originele_waarneming_standplaats_factoren_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.waarneming_standplaats_factoren ALTER CONSTRAINT FK_waarneming_spf NOT DEFERRABLE;
	ALTER TABLE rnn.waarneming_standplaats_factoren ALTER CONSTRAINT FK_waarneming_spf_originele_waarneming_spf NOT DEFERRABLE;
	ALTER TABLE rnn.waarneming_standplaats_factor_tussenresultaat ALTER CONSTRAINT FK_waarneming_spf_tussenresultaat_waarneming_spf NOT DEFERRABLE;
	ALTER TABLE rnn.waarneming_standplaats_factoren_beoordeling ALTER CONSTRAINT FK_waarneming_spf_beoordeling_waarneming_spf NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_gebied_standplaats_tussenresultaat ALTER CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_gebied_standplaats_tussenresultaat ALTER CONSTRAINT FK_beheer_gebied_sp_tussenresultaat_dossier_beheer_gebied NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_gebied_standplaats_beoordeling ALTER CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier_beheer_gebied NOT DEFERRABLE;
	ALTER TABLE rnn.beheer_gebied_standplaats_beoordeling ALTER CONSTRAINT FK_beheer_gebied_sp_beoordeling_dossier NOT DEFERRABLE;
	
	COMMIT;
	
	
	BEGIN;
	-----------------------------------------------------
	-----------------------------------------------------
    -- Step 7: Set DEFAULTs to use imna.imna_seq
    ALTER TABLE rnn.dossier ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
    ALTER TABLE rnn.originele_dossier_beheer_gebied ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
    ALTER TABLE rnn.dossier_beheer_gebied ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
	ALTER TABLE rnn.dossier_beoordelings_gebied ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
    ALTER TABLE rnn.waarneming_flora_en_fauna ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
    ALTER TABLE rnn.originele_waarneming_standplaats_factoren ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');
    ALTER TABLE rnn.waarneming_standplaats_factoren ALTER COLUMN id SET DEFAULT nextval('imna.imna_seq');

    -- Step 8: Drop the old sequence
    DROP SEQUENCE IF EXISTS rnn.rnn_seq;

	COMMIT;

	BEGIN;

	-- Step 9: Move the RNN tables to the imna schema
	ALTER TABLE rnn.beheer_type_tussenresultaat SET SCHEMA imna;
	ALTER TABLE rnn.beheer_type_beoordelingsresultaat SET SCHEMA imna;
	ALTER TABLE rnn.dossier SET SCHEMA imna;
	ALTER TABLE rnn.dossier_beoordelings_gebied SET SCHEMA imna;
	ALTER TABLE rnn.dossier_beheer_type SET SCHEMA imna;
	ALTER TABLE rnn.waarneming_flora_en_fauna SET SCHEMA imna;
	ALTER TABLE rnn.beheer_gebied_standplaats_tussenresultaat SET SCHEMA imna;
	ALTER TABLE rnn.waarneming_standplaats_factoren_beoordeling SET SCHEMA imna;
	ALTER TABLE rnn.waarneming_standplaats_factoren SET SCHEMA imna;
	ALTER TABLE rnn.dossier_beheer_type_soorten SET SCHEMA imna;
	ALTER TABLE rnn.waarneming_standplaats_factor_tussenresultaat SET SCHEMA imna;
	ALTER TABLE rnn.dossier_beheer_type_soorten_tussenresultaat SET SCHEMA imna;
	ALTER TABLE rnn.beheer_gebied_standplaats_beoordeling SET SCHEMA imna;
	ALTER TABLE rnn.originele_waarneming_standplaats_factoren SET SCHEMA imna;
	ALTER TABLE rnn.originele_dossier_beheer_gebied SET SCHEMA imna;
	ALTER TABLE rnn.dossier_beheer_gebied SET SCHEMA imna;
	
	-- Step 10: Move the RNNMasterdata tables to the rnn schema
	ALTER TABLE rnnmasterdata.beoordelings_gebied SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.grid_100_by_100 SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.rode_lijst_configuratie_soort_groep SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.rode_lijst_configuratie SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.rode_lijst_configuratie_rode_lijst_categorie SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.kwalificerende_kenmerk SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.soort_per_beheer_type SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.rnn_soort_groep SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.maatlat SET SCHEMA rnn;
	ALTER TABLE rnnmasterdata.indicator_beheer_type SET SCHEMA rnn;

	

	-- Step 11: Move the RNNMasterdata sequence to the rnn schema
	ALTER SEQUENCE rnnmasterdata.rnnmasterdata_seq SET SCHEMA rnn;
	ALTER SEQUENCE rnn.rnnmasterdata_seq RENAME TO rnn_seq;

	-- Step 12: Remove the rnnmasterdata
	DROP SCHEMA rnnmasterdata;
	

	COMMIT;

	BEGIN;
	
    -- Step 7: Set DEFAULTs to use imna.imna_rnn
    ALTER TABLE rnn.kwalificerende_kenmerk ALTER COLUMN id SET DEFAULT nextval('rnn.rnn_seq');
    ALTER TABLE rnn.maatlat ALTER COLUMN id SET DEFAULT nextval('rnn.rnn_seq');
    ALTER TABLE rnn.rode_lijst_configuratie ALTER COLUMN id SET DEFAULT nextval('rnn.rnn_seq');
	ALTER TABLE rnn.beoordelings_gebied ALTER COLUMN id SET DEFAULT nextval('rnn.rnn_seq');

	COMMIT;