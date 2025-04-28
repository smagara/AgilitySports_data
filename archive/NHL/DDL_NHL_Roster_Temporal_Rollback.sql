/* rollback -- untemporal the table

	-- Turn Off the change auditing to the history table
	ALTER TABLE NHL.Roster
	SET (SYSTEM_VERSIONING = OFF);

	-- Drop temporal columns
	ALTER TABLE AgilitySports.NHL.Roster DROP PERIOD FOR SYSTEM_TIME;
	ALTER TABLE NHL.Roster DROP CONSTRAINT DF_NHLRoster_SysStartTime;
	ALTER TABLE NHL.Roster DROP CONSTRAINT DF_NHLRoster_SysEndTime;
	ALTER TABLE NHL.Roster DROP COLUMN SysStartTime;
	ALTER TABLE NHL.Roster DROP COLUMN SysEndTime;

	-- Drop history table
	DROP TABLE NHL.RosterHistory

	--Validate
	select 
		SCHEMA_NAME(schema_id), 
		name, 
		temporal_type, 
		temporal_type_desc, 
		history_table = OBJECT_NAME(history_table_id) 
	from SYS.TABLES where name = 'roster'

*/