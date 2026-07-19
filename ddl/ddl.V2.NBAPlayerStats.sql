/*
Purpose: Create a table for NBA-specific Player attributes in the NHL schema.
Object: stats.NBAPlayerStats
Dependencies: core.Players

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'stats.NBAPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.NBAPlayerStats already exists. Skipping creation.'
else
CREATE TABLE stats.NBAPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	pointsPerGame decimal(4, 1) NULL,
	reboundsPerGame decimal(4, 1) NULL,
	assistsPerGame decimal(4, 1) NULL,
 CONSTRAINT PK_NBAPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)
GO

ALTER TABLE stats.NBAPlayerStats  WITH CHECK ADD  CONSTRAINT FK_NBAPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)
GO

ALTER TABLE stats.NBAPlayerStats CHECK CONSTRAINT FK_NBAPlayerStats_Player
GO

ALTER TABLE stats.NBAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NBAPlayerStats_assistsPerGame CHECK  ((assistsPerGame IS NULL OR assistsPerGame>=(0.0)))
GO

ALTER TABLE stats.NBAPlayerStats CHECK CONSTRAINT CK_NBAPlayerStats_assistsPerGame
GO

ALTER TABLE stats.NBAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NBAPlayerStats_pointsPerGame CHECK  ((pointsPerGame IS NULL OR pointsPerGame>=(0.0)))
GO

ALTER TABLE stats.NBAPlayerStats CHECK CONSTRAINT CK_NBAPlayerStats_pointsPerGame
GO

ALTER TABLE stats.NBAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NBAPlayerStats_reboundsPerGame CHECK  ((reboundsPerGame IS NULL OR reboundsPerGame>=(0.0)))
GO

ALTER TABLE stats.NBAPlayerStats CHECK CONSTRAINT CK_NBAPlayerStats_reboundsPerGame
GO

ALTER TABLE stats.NBAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NBAPlayerStats_sportCode CHECK  ((sportCode='NBA'))
GO

ALTER TABLE stats.NBAPlayerStats CHECK CONSTRAINT CK_NBAPlayerStats_sportCode
GO


