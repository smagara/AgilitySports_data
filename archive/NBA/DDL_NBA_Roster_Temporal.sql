/* Implement SQL Server temporal table audit tracking for the NBA.Roster table. */

-- Add Temporal Period timestamp fields to the existing Roster table
if NOT EXISTS (select 1 from INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='SysStartTime' AND TABLE_SCHEMA='NBA' and TABLE_Name='Roster') 
ALTER TABLE NBA.Roster
ADD
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_NBARoster_SysStartTime DEFAULT SYSUTCDATETIME(),
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_NBARoster_SysEndTime DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

-- Create the history table, with matching schema
if NOT EXISTS (select * from SYS.TABLES WHERE name='RosterHistory' and SCHEMA_NAME(schema_id) = 'NBA')
CREATE TABLE NBA.RosterHistory
(
	[playerID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Number] [varchar](5) NULL,
	[Height] [nvarchar](6) NOT NULL,
	[Weight] [nvarchar](3) NULL,
	[DateOfBirth] [date] NOT NULL,
	[College] [nvarchar](50) NOT NULL,
    SysStartTime DATETIME2 NOT NULL,
    SysEndTime DATETIME2 NOT NULL,
)

-- Turn on the change auditing to the history table
ALTER TABLE NBA.Roster
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = NBA.RosterHistory, DATA_CONSISTENCY_CHECK = ON));

-- Create some indexes to optimize history research
CREATE INDEX IX_RosterHistoryDates ON NBA.RosterHistory (SysStartTime, SysEndTime);
CREATE INDEX IX_RosterHistoryPlayer ON NBA.RosterHistory (playerID, SysStartTime, SysEndTime);

--Validate the settings
select 
	SCHEMA_NAME(schema_id), 
	name, 
	temporal_type, 
	temporal_type_desc, 
	history_table = OBJECT_NAME(history_table_id) 
from SYS.TABLES where name = 'roster'