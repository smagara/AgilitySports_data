/*
Purpose: Create a table for FIFA/soccer-specific Player attributes
Object: stats.FIFPlayerStats
Dependencies: core.Players

Change Log:
2026-07-31  Initial version for FIFA World Cup (FIF)
*/
if OBJECT_ID(N'stats.FIFPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.FIFPlayerStats already exists. Skipping creation.'
else begin
CREATE TABLE stats.FIFPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	totalGoals int NULL,
	assists int NULL,
	saves int NULL,
 CONSTRAINT PK_FIFPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)

ALTER TABLE stats.FIFPlayerStats  WITH CHECK ADD  CONSTRAINT FK_FIFPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)

ALTER TABLE stats.FIFPlayerStats CHECK CONSTRAINT FK_FIFPlayerStats_Player

ALTER TABLE stats.FIFPlayerStats  WITH CHECK ADD  CONSTRAINT CK_FIFPlayerStats_totalGoals CHECK  ((totalGoals IS NULL OR totalGoals>=(0)))

ALTER TABLE stats.FIFPlayerStats CHECK CONSTRAINT CK_FIFPlayerStats_totalGoals

ALTER TABLE stats.FIFPlayerStats  WITH CHECK ADD  CONSTRAINT CK_FIFPlayerStats_assists CHECK  ((assists IS NULL OR assists>=(0)))

ALTER TABLE stats.FIFPlayerStats CHECK CONSTRAINT CK_FIFPlayerStats_assists

ALTER TABLE stats.FIFPlayerStats  WITH CHECK ADD  CONSTRAINT CK_FIFPlayerStats_saves CHECK  ((saves IS NULL OR saves>=(0)))

ALTER TABLE stats.FIFPlayerStats CHECK CONSTRAINT CK_FIFPlayerStats_saves

ALTER TABLE stats.FIFPlayerStats  WITH CHECK ADD  CONSTRAINT CK_FIFPlayerStats_sportCode CHECK  ((sportCode='FIF'))

ALTER TABLE stats.FIFPlayerStats CHECK CONSTRAINT CK_FIFPlayerStats_sportCode

end;
