/* rollback -- untemporal the table

	-- Turn Off the change auditing to the history table
	ALTER TABLE NBA.Roster
	SET (SYSTEM_VERSIONING = OFF);

	-- Drop temporal columns
	ALTER TABLE AgilitySports.NBA.Roster DROP PERIOD FOR SYSTEM_TIME;
	ALTER TABLE NBA.Roster DROP CONSTRAINT DF_NBARoster_SysStartTime;
	ALTER TABLE NBA.Roster DROP CONSTRAINT DF_NBARoster_SysEndTime;
	ALTER TABLE NBA.Roster DROP COLUMN SysStartTime;
	ALTER TABLE NBA.Roster DROP COLUMN SysEndTime;

	-- Drop history table
	DROP TABLE NBA.RosterHistory

	--Validate
	select 
		[Schema] = SCHEMA_NAME(schema_id), 
		name, 
		temporal_type, 
		temporal_type_desc, 
		history_table = SCHEMA_NAME(schema_id) + '.' + OBJECT_NAME(history_table_id) 
	from SYS.TABLES where name = 'roster'

*/