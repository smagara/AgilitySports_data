/*
Purpose: Create table for Players in the AgilitySports schema.
Object: core.Players
Dependencies: core.Teams, reference.Sports, stats.*

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'core.Players', N'U') IS NOT NULL
    Print 'Table core.Players already exists. Skipping creation.'
else
CREATE TABLE core.Players
(
	playerID int IDENTITY(9000000,1) NOT NULL,
	sportCode varchar(3) NOT NULL,
	teamCode varchar(15) NOT NULL,
	positionCode varchar(3) NULL,
	firstName nvarchar(50) NULL,
	lastName nvarchar(50) NULL,
	dateOfBirth date NULL,
	heightInches int NULL,
	weight int NULL,
	number int NULL,
	college nvarchar(100) NULL,
	birthCountry nvarchar(100) NULL,
	birthCityState nvarchar(100) NULL,
	draftYear smallint NULL,
	seasonYear smallint NULL,
 CONSTRAINT PK_Players_ID PRIMARY KEY CLUSTERED (	playerID ASC)
 CONSTRAINT UQ_Players_playerID_sportCode UNIQUE NONCLUSTERED (playerID ASC, sportCode ASC)
) 
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT FK_Players_PositionCodes FOREIGN KEY(sportCode, positionCode)
REFERENCES reference.PositionCodes (sportCode, positionCode)
GO

ALTER TABLE core.Players CHECK CONSTRAINT FK_Players_PositionCodes
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT FK_Players_Teams FOREIGN KEY(sportCode, teamCode)
REFERENCES core.Teams (sportCode, teamCode)
GO

ALTER TABLE core.Players CHECK CONSTRAINT FK_Players_Teams
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT CK_Players_draftYear CHECK  ((draftYear IS NULL OR draftYear>=(1970) AND draftYear<=(2100)))
GO

ALTER TABLE core.Players CHECK CONSTRAINT CK_Players_draftYear
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT CK_Players_heightInches CHECK  ((heightInches IS NULL OR heightInches>(48)))
GO

ALTER TABLE core.Players CHECK CONSTRAINT CK_Players_heightInches
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT CK_Players_seasonYear CHECK  ((seasonYear IS NULL OR seasonYear>=(1970) AND seasonYear<=(2100)))
GO

ALTER TABLE core.Players CHECK CONSTRAINT CK_Players_seasonYear
GO

ALTER TABLE core.Players  WITH CHECK ADD  CONSTRAINT CK_Players_weight CHECK  ((weight IS NULL OR weight>(80)))
GO

ALTER TABLE core.Players CHECK CONSTRAINT CK_Players_weight
GO