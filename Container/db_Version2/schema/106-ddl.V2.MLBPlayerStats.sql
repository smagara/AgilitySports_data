/*
Purpose: Create a table for MLB-specific Player attributes in the MLB schema.
Object: stats.MLBPlayerStats
Dependencies: core.Players

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'stats.MLBPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.MLBPlayerStats already exists. Skipping creation.'
else begin
CREATE TABLE stats.MLBPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	bats char(1) NULL,
	throws char(1) NULL,
	battingAverage decimal(4, 3) NULL,
	homeRuns int NULL,
	ERA decimal(5, 2) NULL,
 CONSTRAINT PK_MLBPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)

ALTER TABLE stats.MLBPlayerStats  WITH CHECK ADD  CONSTRAINT FK_MLBPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)

ALTER TABLE stats.MLBPlayerStats CHECK CONSTRAINT FK_MLBPlayerStats_Player

ALTER TABLE stats.MLBPlayerStats  WITH CHECK ADD  CONSTRAINT CK_MLBPlayerStats_battingAverage CHECK  ((battingAverage IS NULL OR battingAverage>=(0) AND battingAverage<=(1)))

ALTER TABLE stats.MLBPlayerStats CHECK CONSTRAINT CK_MLBPlayerStats_battingAverage

ALTER TABLE stats.MLBPlayerStats  WITH CHECK ADD  CONSTRAINT CK_MLBPlayerStats_sportCode CHECK  ((sportCode='MLB'))

ALTER TABLE stats.MLBPlayerStats CHECK CONSTRAINT CK_MLBPlayerStats_sportCode

ALTER TABLE stats.MLBPlayerStats  WITH CHECK ADD  CONSTRAINT CK_MLBPlayerStats_throws CHECK  ((throws IS NULL OR (throws='B' OR throws='R' OR throws='L')))

ALTER TABLE stats.MLBPlayerStats CHECK CONSTRAINT CK_MLBPlayerStats_throws

end;