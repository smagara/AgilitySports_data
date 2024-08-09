/* Implement SQL Server temporal table audit tracking for the NHL.Roster table. */

-- Add Temporal Period timestamp fields to the existing Roster table
if NOT EXISTS (select 1 from INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='SysStartTime' AND TABLE_SCHEMA='NHL' and TABLE_Name='Roster') 
ALTER TABLE NHL.Roster
ADD
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_NHLRoster_SysStartTime DEFAULT SYSUTCDATETIME(),
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_NHLRoster_SysEndTime DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

-- Create the history table, with the same schema
if NOT EXISTS (select * from SYS.TABLES WHERE name='RosterHistory')
CREATE TABLE NHL.RosterHistory
(
	[playerID] [smallint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Number] [nvarchar](5) NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Handed] [nvarchar](1) NOT NULL,
	[Age] [tinyint] NOT NULL,
	[Drafted] [smallint] NOT NULL,
	[BirthPlace] [nvarchar](50) NULL,
	[BirthCountry] [nvarchar](50) NULL,
    SysStartTime DATETIME2 NOT NULL,
    SysEndTime DATETIME2 NOT NULL,
)

-- Turn on the change auditing to the history table
ALTER TABLE NHL.Roster
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = NHL.RosterHistory, DATA_CONSISTENCY_CHECK = ON));

-- Create some indexes to optimize history research
CREATE INDEX IX_RosterHistoryDates ON NHL.RosterHistory (SysStartTime, SysEndTime);
CREATE INDEX IX_RosterHistoryPlayer ON NHL.RosterHistory (playerID, SysStartTime, SysEndTime);

--Validate the settings
select 
	SCHEMA_NAME(schema_id), 
	name, 
	temporal_type, 
	temporal_type_desc, 
	history_table = OBJECT_NAME(history_table_id) 
from SYS.TABLES where name = 'roster'