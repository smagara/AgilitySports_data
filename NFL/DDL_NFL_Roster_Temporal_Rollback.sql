/* rollback -- untemporal the table

	-- Turn Off the change auditing to the history table
	ALTER TABLE NFL.Roster
	SET (SYSTEM_VERSIONING = OFF);

	-- Drop temporal columns
	ALTER TABLE AgilitySports.NFL.Roster DROP PERIOD FOR SYSTEM_TIME;
	ALTER TABLE NFL.Roster DROP CONSTRAINT DF_NFLRoster_SysStartTime;
	ALTER TABLE NFL.Roster DROP CONSTRAINT DF_NFLRoster_SysEndTime;
	ALTER TABLE NFL.Roster DROP COLUMN SysStartTime;
	ALTER TABLE NFL.Roster DROP COLUMN SysEndTime;

	-- Drop history table
	DROP TABLE NFL.RosterHistory

	--Validate
	select 
		[Schema] = SCHEMA_NAME(schema_id), 
		name, 
		temporal_type, 
		temporal_type_desc, 
		history_table = SCHEMA_NAME(schema_id) + '.' + OBJECT_NAME(history_table_id) 
	from SYS.TABLES where name = 'roster'

*/