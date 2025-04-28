/* Implement SQL Server temporal table audit tracking for the NFL.Roster table. */

-- Add Temporal Period timestamp fields to the existing Roster table
if NOT EXISTS (select 1 from INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='SysStartTime' AND TABLE_SCHEMA='NFL' and TABLE_Name='Roster') 
ALTER TABLE NFL.Roster
ADD
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_NFLRoster_SysStartTime DEFAULT SYSUTCDATETIME(),
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_NFLRoster_SysEndTime DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

-- Create the history table, with matching schema
if NOT EXISTS (select * from SYS.TABLES WHERE name='RosterHistory' and SCHEMA_NAME(schema_id) = 'NFL')
CREATE TABLE NFL.RosterHistory
(
	[PlayerId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[Team] [varchar](10) NOT NULL,
	[Position] [varchar](10) NULL,
	[FantasyPosition] [varchar](10) NULL,
	[PositionCategory] [varchar](10) NULL,
	[Height] [varchar](100) NULL,
	[Weight] [int] NULL,
	[Number] [int] NULL,
	[CurrentStatus] [varchar](100) NULL,
	[CurrentStatusColor] [varchar](100) NULL,
	[BirthDateShortString] [date] NULL,
	[Age] [smallint] NULL,
	[AgeExact] [float] NULL,
	[College] [varchar](100) NULL,
	[CollegeDraftRound] [varchar](100) NULL,
	[CollegeDraftPick] [varchar](100) NULL,
	[ExperienceDigit] [varchar](100) NULL,
	[PlayerUrlString] [varchar](100) NULL,
	[TeamName] [varchar](100) NULL,
	[TeamUrlString] [varchar](100) NULL,
	[PhotoUrl] [varchar](300) NULL,
	[PreferredHostedHeadshotUrl] [varchar](300) NULL,
	[LowResPreferredHostedHeadshotUrl] [varchar](300) NULL,
	[IsAvailableToPlay] [bit] NULL,
	[Status] [varchar](100) NULL,
	[InjuryStatus] [varchar](100) NULL,
	[InjuryBodyPart] [varchar](100) NULL,
	[ShortName] [varchar](100) NULL,
	[TeamDetails] [varchar](100) NULL,
	[CSName] [varchar](100) NULL,
    SysStartTime DATETIME2 NOT NULL,
    SysEndTime DATETIME2 NOT NULL
)

-- Turn on the change auditing to the history table
ALTER TABLE NFL.Roster
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = NFL.RosterHistory, DATA_CONSISTENCY_CHECK = ON));

-- Create some indexes to optimize history research
CREATE INDEX IX_RosterHistoryDates ON NFL.RosterHistory (SysStartTime, SysEndTime);
CREATE INDEX IX_RosterHistoryPlayer ON NFL.RosterHistory (playerID, SysStartTime, SysEndTime);

--Validate the settings
select 
	SCHEMA_NAME(schema_id), 
	name, 
	temporal_type, 
	temporal_type_desc, 
	history_table = OBJECT_NAME(history_table_id) 
from SYS.TABLES where name = 'roster'