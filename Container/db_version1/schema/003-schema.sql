-- DDL Statements for Active Tables and Views
USE [$(DB_NAME)];
GO

IF OBJECT_ID(N'[MLB].[Attendance]', N'U') IS NOT NULL
BEGIN
	PRINT 'Schema already exists. Skipping 003-schema.sql';
	SET NOEXEC ON;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE SCHEMA MLB AUTHORIZATION test_user;
GO
CREATE SCHEMA NBA AUTHORIZATION test_user;
GO
CREATE SCHEMA NFL AUTHORIZATION test_user;
GO
CREATE SCHEMA NHL AUTHORIZATION test_user;
GO
CREATE SCHEMA PGA AUTHORIZATION test_user;
GO

CREATE TABLE [dbo].[MLBDemographics](
	[Id] [bigint] NOT NULL,
	[playerID] [varchar](10) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Weight] [int] NULL,
	[Height] [varchar](10) NULL,
	[DateOfBirth] [date] NOT NULL,
	[BirthCountry] [varchar](50) NOT NULL,
	[BirthPlace] [varchar](102) NOT NULL,
 CONSTRAINT [PK_TID] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MLBRoster]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MLBRoster](
	[ID] [bigint] NULL,
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
	[Season] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MLBStats]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MLBStats](
	[Id] [bigint] NULL,
	[playerID] [varchar](10) NOT NULL,
	[TeamName] [varchar](50) NOT NULL,
	[League] [varchar](4) NOT NULL,
	[Position] [nvarchar](4) NOT NULL,
	[Bats] [varchar](50) NULL,
	[Throws] [varchar](50) NULL,
	[Debut] [date] NOT NULL,
	[teamID] [varchar](10) NOT NULL,
	[Season] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [MLB].[Attendance]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MLB].[Attendance](
	[teamId] [varchar](5) NOT NULL,
	[yearId] [smallint] NOT NULL,
	[teamName] [varchar](50) NULL,
	[parkName] [varchar](150) NULL,
	[attendance] [bigint] NULL,
 CONSTRAINT [PK_MLBAttend] PRIMARY KEY NONCLUSTERED 
(
	[teamId] ASC,
	[yearId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [MLB].[Roster]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
 CONSTRAINT [PK_MLBRoster] PRIMARY KEY NONCLUSTERED 
(
	[playerID] ASC,
	[teamID] ASC,
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NBA].[Roster]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NBA].[Roster](
	[playerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Number] [varchar](5) NULL,
	[Height] [nvarchar](6) NOT NULL,
	[Weight] [nvarchar](3) NULL,
	[DateOfBirth] [date] NOT NULL,
	[College] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MLBRoster] PRIMARY KEY NONCLUSTERED 
(
	[playerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NFL].[Roster]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NFL].[Roster](
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
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
	[Age] [smallint] NULL,
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
PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [NHL].[Roster]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NHL].[Roster](
	[playerID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Number] [nvarchar](5) NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Handed] [nvarchar](1) NOT NULL,
	[Age] [tinyint] NOT NULL,
	[Drafted] [smallint] NOT NULL,
	[BirthPlace] [nvarchar](50) NULL,
	[BirthCountry] [nvarchar](50) NULL,
 CONSTRAINT [PK_NHL.Roster] PRIMARY KEY CLUSTERED 
(
	[playerID] ASC,
	[Team] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PGA].[TournamentLog]    Script Date: 5/27/2026 6:04:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PGA].[TournamentLog](
	[Player_initial_last] [nvarchar](150) NOT NULL,
	[tournament_id] [int] NOT NULL,
	[player_id] [int] NOT NULL,
	[hole_par] [smallint] NULL,
	[strokes] [smallint] NULL,
	[hole_DKP] [float] NULL,
	[hole_FDP] [float] NULL,
	[hole_SDP] [tinyint] NULL,
	[streak_DKP] [tinyint] NULL,
	[streak_FDP] [float] NULL,
	[streak_SDP] [tinyint] NULL,
	[n_rounds] [tinyint] NULL,
	[made_cut] [tinyint] NULL,
	[pos] [smallint] NULL,
	[finish_DKP] [tinyint] NULL,
	[finish_FDP] [tinyint] NULL,
	[finish_SDP] [tinyint] NULL,
	[total_DKP] [float] NULL,
	[total_FDP] [float] NULL,
	[total_SDP] [tinyint] NULL,
	[player] [nvarchar](150) NOT NULL,
	[Unnamed_2] [nvarchar](1) NULL,
	[Unnamed_3] [nvarchar](1) NULL,
	[Unnamed_4] [nvarchar](1) NULL,
	[tournament_name] [nvarchar](150) NULL,
	[course] [nvarchar](150) NULL,
	[date] [date] NULL,
	[purse] [float] NULL,
	[season] [varchar](50) NULL,
	[no_cut] [tinyint] NULL,
	[Finish] [nvarchar](50) NULL,
	[sg_putt] [float] NULL,
	[sg_arg] [float] NULL,
	[sg_app] [float] NULL,
	[sg_ott] [float] NULL,
	[sg_t2g] [float] NULL,
	[sg_total] [float] NULL
) ON [PRIMARY]
GO

declare @status varchar(100);
SELECT @status = 'AgilitySports Schema FINISHED! TableCount=' + CONVERT(varchar(20), COUNT(*))
FROM INFORMATION_SCHEMA.TABLES;
print @status;
GO

SET NOEXEC OFF;
GO