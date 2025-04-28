/* 
	Modify the existing NFL.Roster table so that PlayerID is an Identity and Primary Key. 
		-Create a tempory table to hold existing data
		-Copy the existing NFL Roster data to the temp table
		-Drop existing NFL Roster table
		-Create New NFL Roster table, making PlayerId an Identity and Primary Key
		-Copy the saved data to the new table
*/

-- Create a temp table to save the existing NFL roster data
CREATE TABLE #NFLRoster
(
	[PlayerId] [int] NULL,
	[Name] [varchar](100) NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Team] [varchar](10) NULL,
	[Position] [varchar](10) NULL,
	[FantasyPosition] [varchar](10) NULL,
	[PositionCategory] [varchar](10) NULL,
	[Height] [varchar](100) NULL,
	[Weight] [int] NULL,
	[Number] [int] NULL,
	[CurrentStatus] [varchar](100) NULL,
	[CurrentStatusColor] [varchar](100) NULL,
	[BirthDateShortString] [date] NULL,
	[Age] [varchar](100) NULL,
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
	[CSName] [varchar](100) NULL
)

-- Save existing data
insert into #NFLRoster (PlayerId, Name, FirstName, LastName, Team, Position, 
	FantasyPosition, PositionCategory, Height, Weight, Number, CurrentStatus, CurrentStatusColor, BirthDateShortString, Age, 
	AgeExact, College, CollegeDraftRound, CollegeDraftPick, ExperienceDigit, PlayerUrlString, TeamName, TeamUrlString, PhotoUrl, 
	PreferredHostedHeadshotUrl, LowResPreferredHostedHeadshotUrl, IsAvailableToPlay, Status, InjuryStatus, InjuryBodyPart, ShortName, TeamDetails, CSName)
SELECT PlayerId, Name, FirstName, LastName, Team, Position, 
	FantasyPosition, PositionCategory, Height, Weight, Number, CurrentStatus, CurrentStatusColor, BirthDateShortString, Age, 
	AgeExact, College, CollegeDraftRound, CollegeDraftPick, ExperienceDigit, PlayerUrlString, TeamName, TeamUrlString, PhotoUrl, 
	PreferredHostedHeadshotUrl, LowResPreferredHostedHeadshotUrl, IsAvailableToPlay, Status, InjuryStatus, InjuryBodyPart, ShortName, TeamDetails, CSName
FROM NFL.Roster

--Recreate new Roster Table with Identity and Primary Key PlayerId
DROP TABLE NFL.Roster
CREATE TABLE NFL.Roster
(
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
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
	[Age] smallint NULL,
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
	PRIMARY KEY ([PlayerId])
)

--Copy saved data to new Table and carry on
SET IDENTITY_INSERT NFL.Roster ON
insert into NFL.Roster (PlayerId, Name, FirstName, LastName, Team, Position, 
	FantasyPosition, PositionCategory, Height, Weight, Number, CurrentStatus, CurrentStatusColor, BirthDateShortString, Age, 
	AgeExact, College, CollegeDraftRound, CollegeDraftPick, ExperienceDigit, PlayerUrlString, TeamName, TeamUrlString, PhotoUrl, 
	PreferredHostedHeadshotUrl, LowResPreferredHostedHeadshotUrl, IsAvailableToPlay, Status, InjuryStatus, InjuryBodyPart, ShortName, TeamDetails, CSName)
SELECT PlayerId, Name, FirstName, LastName, Team, Position, 
	FantasyPosition, PositionCategory, Height, Weight, Number, CurrentStatus, CurrentStatusColor, BirthDateShortString, Age, 
	AgeExact, College, CollegeDraftRound, CollegeDraftPick, ExperienceDigit, PlayerUrlString, TeamName, TeamUrlString, PhotoUrl, 
	PreferredHostedHeadshotUrl, LowResPreferredHostedHeadshotUrl, IsAvailableToPlay, Status, InjuryStatus, InjuryBodyPart, ShortName, TeamDetails, CSName
FROM #NFLRoster
SET IDENTITY_INSERT NFL.Roster OFF