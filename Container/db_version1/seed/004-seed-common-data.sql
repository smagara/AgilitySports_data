/****** Populate the shared sports PositionCodes table  ******/
IF OBJECT_ID(N'[dbo].[PositionCodes]', N'U') IS NOT NULL
BEGIN
	DECLARE @PositionCodesHasRows bit = 0;
	EXEC sp_executesql
		N'SELECT @HasRows = CASE WHEN EXISTS (SELECT 1 FROM [dbo].[PositionCodes]) THEN 1 ELSE 0 END',
		N'@HasRows bit OUTPUT',
		@HasRows = @PositionCodesHasRows OUTPUT;

	IF @PositionCodesHasRows = 1
	BEGIN
		PRINT 'PositionCodes already seeded. Skipping 004-seed-common-data.sql';
		SET NOEXEC ON;
	END
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[dbo].[PositionCodes]', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[PositionCodes](
	[Sport] [varchar](3) NOT NULL,
	[PositionCode] [varchar](10) NOT NULL,
	[PositionDesc] [varchar](40) NOT NULL,
 CONSTRAINT [PK_PositionCodes] PRIMARY KEY CLUSTERED 
(
	[Sport] ASC,
	[PositionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[PositionCodes] ([Sport], [PositionCode], [PositionDesc]) VALUES
(N'NBA', N'C', N'Center'),
(N'NBA', N'F', N'Forward'),
(N'NBA', N'G', N'Guard'),
(N'NBA', N'PF', N'Power Forward'),
(N'NBA', N'PG', N'Point Guard'),
(N'NBA', N'SF', N'Small Forward'),
(N'NBA', N'SG', N'Shooting Guard'),
(N'NFL', N'C', N'Center'),
(N'NFL', N'CB', N'Cornerback'),
(N'NFL', N'DB', N'Defensive Back'),
(N'NFL', N'DE', N'Defensive End'),
(N'NFL', N'DL', N'Defensive Lineman'),
(N'NFL', N'DT', N'Defensive Tackle'),
(N'NFL', N'FB', N'Fullback'),
(N'NFL', N'G', N'Guard'),
(N'NFL', N'ILB', N'Inside Linebacker'),
(N'NFL', N'K', N'Kicker'),
(N'NFL', N'LB', N'Linebacker'),
(N'NFL', N'LS', N'Long Snapper'),
(N'NFL', N'NT', N'Nose Tackle'),
(N'NFL', N'OL', N'Offensive Lineman'),
(N'NFL', N'OLB', N'Outside Linebacker'),
(N'NFL', N'OT', N'Offensive Tackle'),
(N'NFL', N'P', N'Punter'),
(N'NFL', N'QB', N'Quarterback'),
(N'NFL', N'RB', N'Running Back'),
(N'NFL', N'S', N'Safety'),
(N'NFL', N'TE', N'Tight End'),
(N'NFL', N'WR', N'Wide Receiver'),
(N'NHL', N'C', N'Center'),
(N'NHL', N'D', N'Defenseman'),
(N'NHL', N'F', N'Forward'),
(N'NHL', N'G', N'Goalie'),
(N'NHL', N'LW', N'Left Winger'),
(N'NHL', N'RW', N'Right Winger')
GO
declare @status varchar(100);
SELECT @status='PositionCodes FINISHED! Volume=' + convert(varchar(100), count(*)) + '. Timestamp:' + convert(varchar(50), getdate(), 120) from PositionCodes;
print @status;
GO

SET NOEXEC OFF;
GO



