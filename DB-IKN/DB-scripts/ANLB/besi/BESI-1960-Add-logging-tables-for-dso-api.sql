/* Create Tables */

CREATE TABLE IF NOT EXISTS besi.audit_logs
(
	message text,
	message_template text,
	level integer,
	timestamp timestamp without time zone NULL,
	exception text,
	log_event jsonb
)
;

ALTER TABLE besi.audit_logs
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.functional_logs
(
	message text,
	message_template text,
	level integer,
	timestamp timestamp without time zone NULL,
	exception text,
	log_event jsonb
)
;

ALTER TABLE besi.functional_logs
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.technical_logs
(
	message text,
	message_template text,
	level integer,
	timestamp timestamp without time zone NULL,
	exception text,
	log_event jsonb
)
;

ALTER TABLE besi.technical_logs
    OWNER to anlb;
	
CREATE TABLE IF NOT EXISTS besi.statistic_logs
(
	message text,
	message_template text,
	level integer,
	timestamp timestamp without time zone NULL,
	exception text,
	log_event jsonb
)
;

ALTER TABLE besi.statistic_logs
    OWNER to anlb;

/* Create Primary Keys, Indexes, Uniques, Checks */

CREATE INDEX IF NOT EXISTS IXFK_audit_logs_level ON besi.audit_logs (level ASC);
CREATE INDEX IF NOT EXISTS IXFK_audit_logs_timestamp ON besi.audit_logs (timestamp ASC);

CREATE INDEX IF NOT EXISTS IXFK_functional_logs_level ON besi.functional_logs (level ASC);
CREATE INDEX IF NOT EXISTS IXFK_functional_logs_timestamp ON besi.functional_logs (timestamp ASC);

CREATE INDEX IF NOT EXISTS IXFK_technical_logs_level ON besi.technical_logs (level ASC);
CREATE INDEX IF NOT EXISTS IXFK_technical_logs_timestamp ON besi.technical_logs (timestamp ASC);

CREATE INDEX IF NOT EXISTS IXFK_statistic_logs_level ON besi.statistic_logs (level ASC);
CREATE INDEX IF NOT EXISTS IXFK_statistic_logs_timestamp ON besi.statistic_logs (timestamp ASC);

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE besi.audit_logs
	IS 'Table to store the log for audit purposes'
;

COMMENT ON TABLE besi.functional_logs
	IS 'Table to store the log for audit purposes'
;

COMMENT ON TABLE besi.technical_logs
	IS 'Table to store the log for audit purposes'
;

COMMENT ON TABLE besi.statistic_logs
	IS 'Table to store the log for audit purposes'
;

CREATE INDEX IF NOT EXISTS IDX_audit_logs_correlationid ON besi.audit_logs ((log_event->'Properties'->>'CorrelationId'));
CREATE INDEX IF NOT EXISTS IDX_audit_logs_ipaddress ON besi.audit_logs ((log_event->'Properties'->>'IpAddress'));
CREATE INDEX IF NOT EXISTS IDX_audit_logs_is_dso_api_key ON besi.audit_logs ((log_event->'Properties'->>'IsDSOAPIKey'));
 

CREATE INDEX IF NOT EXISTS IDX_functional_logs_correlationid ON besi.functional_logs ((log_event->'Properties'->>'CorrelationId'));
CREATE INDEX IF NOT EXISTS IDX_technical_logs_correlationid ON besi.technical_logs ((log_event->'Properties'->>'CorrelationId'));
CREATE INDEX IF NOT EXISTS IDX_statistic_logs_correlationid ON besi.statistic_logs ((log_event->'Properties'->>'CorrelationId'));
CREATE INDEX IF NOT EXISTS IDX_statistic_logs_execution_duration ON besi.statistic_logs ((log_event->'Properties'->>'Execution duration'));

GRANT SELECT ON ALL TABLES IN SCHEMA besi TO anlb_sqlpad;
GRANT SELECT ON ALL TABLES IN SCHEMA besi TO besi_readonly;

GRANT INSERT ON besi.audit_logs TO besi_dsoapi;
GRANT INSERT ON besi.functional_logs TO besi_dsoapi;
GRANT INSERT ON besi.statistic_logs TO besi_dsoapi;
GRANT INSERT ON besi.technical_logs TO besi_dsoapi;