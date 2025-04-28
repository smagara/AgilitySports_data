USE [AgilitySports]
GO

/****** Create the MLB.Roster table for the AgilitySports training app ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'[AgilitySports].[MLB].[Roster]', N'U') IS NULL
	BEGIN

		CREATE TABLE [MLB].[Roster](
			[playerID] [varchar](10) NOT NULL,
			[FirstName] [varchar](50) NOT NULL,
			[LastName] [varchar](50) NOT NULL,
			[TeamName] [varchar](50) NOT NULL,
			[League] [varchar](4) NOT NULL,
			[Position] [nvarchar](4) NOT NULL,
			[Weight] [varchar](6) NOT NULL,
			[Height] [varchar](6) NOT NULL,
			[Bats] [varchar](50) NULL,
			[Throws] [varchar](50) NULL,
			[DateOfBirth] [date] NOT NULL,
			[BirthCountry] [varchar](50) NOT NULL,
			[BirthPlace] [varchar](102) NOT NULL,
			[Debut] [date] NOT NULL,
			[teamID] [varchar](10) NOT NULL,
			[Season] [smallint] NOT NULL,
		 CONSTRAINT [PK_MLBRoster] PRIMARY KEY NONCLUSTERED ([playerID], [teamID], [Position] ASC) ON [PRIMARY]
		) ON [PRIMARY]

	END
ELSE RAISERROR('MLB.Roster table already exists', 16, 1);
GO



