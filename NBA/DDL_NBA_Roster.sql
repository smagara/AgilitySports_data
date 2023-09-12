USE [AgilitySports]
GO

/****** Object:  Table [NBA].[Roster]    Script Date: 9/12/2023 2:39:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NBA].[Roster](
	playerID int identity(1,1) NOT null,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Number] [varchar](5) NULL,
	[Height] [nvarchar](6) NOT NULL,
	[Weight] [nvarchar](3) NULL,
	[DateOfBirth] date NOT NULL,
	[College] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_MLBRoster] PRIMARY KEY NONCLUSTERED ([playerID]) ON [PRIMARY]
	)

GO


