/*
Purpose: Create a table for NFL-specific Player attributes
Object: stats.NFLPlayerStats
Dependencies: core.Players

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'stats.NFLPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.NFLPlayerStats already exists. Skipping creation.'
else
CREATE TABLE stats.NFLPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	sacks decimal(4, 1) NULL,
	touchdowns int NULL,
 CONSTRAINT PK_NFLPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)
GO

ALTER TABLE stats.NFLPlayerStats  WITH CHECK ADD  CONSTRAINT FK_NFLPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)
GO

ALTER TABLE stats.NFLPlayerStats CHECK CONSTRAINT FK_NFLPlayerStats_Player
GO

ALTER TABLE stats.NFLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NFLPlayerStats_sacks CHECK  ((sacks IS NULL OR sacks>=(0.0)))
GO

ALTER TABLE stats.NFLPlayerStats CHECK CONSTRAINT CK_NFLPlayerStats_sacks
GO

ALTER TABLE stats.NFLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NFLPlayerStats_sportCode CHECK  ((sportCode='NFL'))
GO

ALTER TABLE stats.NFLPlayerStats CHECK CONSTRAINT CK_NFLPlayerStats_sportCode
GO

ALTER TABLE stats.NFLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NFLPlayerStats_touchdowns CHECK  ((touchdowns IS NULL OR touchdowns>=(0)))
GO

ALTER TABLE stats.NFLPlayerStats CHECK CONSTRAINT CK_NFLPlayerStats_touchdowns
GO
