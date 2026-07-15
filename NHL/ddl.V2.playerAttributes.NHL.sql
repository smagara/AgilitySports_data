/*
Purpose: Create a table for NHL-specific Player attributes
Object: stats.NHLPlayerStats
Dependencies: core.Players

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'stats.NHLPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.NHLPlayerStats already exists. Skipping creation.'
else
CREATE TABLE stats.NHLPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	handed char(1) NULL,
	goals int NULL,
	penaltyMinutes int NULL,
	points int NULL,
	savePct decimal(3, 2) NULL,
 CONSTRAINT PK_NHLPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)
GO

ALTER TABLE stats.NHLPlayerStats  WITH CHECK ADD  CONSTRAINT FK_NHLPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)
GO

ALTER TABLE stats.NHLPlayerStats CHECK CONSTRAINT FK_NHLPlayerStats_Player
GO

ALTER TABLE stats.NHLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NHLPlayerStats_handed CHECK  ((handed IS NULL OR (handed='B' OR handed='R' OR handed='L')))
GO

ALTER TABLE stats.NHLPlayerStats CHECK CONSTRAINT CK_NHLPlayerStats_handed
GO

ALTER TABLE stats.NHLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NHLPlayerStats_savePct CHECK  ((savePct IS NULL OR savePct>=(0) AND savePct<=(1)))
GO

ALTER TABLE stats.NHLPlayerStats CHECK CONSTRAINT CK_NHLPlayerStats_savePct
GO

ALTER TABLE stats.NHLPlayerStats  WITH CHECK ADD  CONSTRAINT CK_NHLPlayerStats_sportCode CHECK  ((sportCode='NHL'))
GO

ALTER TABLE stats.NHLPlayerStats CHECK CONSTRAINT CK_NHLPlayerStats_sportCode
GO
