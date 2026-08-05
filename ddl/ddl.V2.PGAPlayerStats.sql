/*
Purpose: Create a table for PGA/golf-specific Player attributes
Object: stats.PGAPlayerStats
Dependencies: core.Players

Change Log:
2026-08-03  Initial version for PGA Tour 2026 season
*/
if OBJECT_ID(N'stats.PGAPlayerStats', N'U') IS NOT NULL
    Print 'Table stats.PGAPlayerStats already exists. Skipping creation.'
else begin
CREATE TABLE stats.PGAPlayerStats(
	playerID int NOT NULL,
	sportCode varchar(3) NOT NULL,
	wins int NULL,
	majors int NULL,
	drivingDistance decimal(5, 1) NULL,
	scoringAverage decimal(4, 1) NULL,
	eventsPlayed int NULL,
	cutsMade int NULL,
 CONSTRAINT PK_PGAPlayerStats PRIMARY KEY CLUSTERED (playerID ASC, sportCode ASC)
)

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT FK_PGAPlayerStats_Player FOREIGN KEY(playerID, sportCode)
REFERENCES core.Players (playerID, sportCode)

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT FK_PGAPlayerStats_Player

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_wins CHECK  ((wins IS NULL OR wins>=(0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_wins

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_majors CHECK  ((majors IS NULL OR majors>=(0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_majors

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_drivingDistance CHECK  ((drivingDistance IS NULL OR drivingDistance>=(0.0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_drivingDistance

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_scoringAverage CHECK  ((scoringAverage IS NULL OR scoringAverage>=(0.0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_scoringAverage

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_eventsPlayed CHECK  ((eventsPlayed IS NULL OR eventsPlayed>=(0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_eventsPlayed

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_cutsMade CHECK  ((cutsMade IS NULL OR cutsMade>=(0)))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_cutsMade

ALTER TABLE stats.PGAPlayerStats  WITH CHECK ADD  CONSTRAINT CK_PGAPlayerStats_sportCode CHECK  ((sportCode='PGA'))

ALTER TABLE stats.PGAPlayerStats CHECK CONSTRAINT CK_PGAPlayerStats_sportCode

end;
