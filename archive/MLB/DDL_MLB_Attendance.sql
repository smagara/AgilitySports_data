USE [AgilitySports]
GO

/****** Object:  Table [MLB].[Attendance]    Script Date: 9/18/2023 6:13:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [MLB].[Attendance](
	[teamId] [varchar](5) NOT NULL,
	[yearId] smallint NOT NULL,
	[teamName] [varchar](50) NULL,
	[parkName] [varchar](150) NULL,
	[attendance] bigint NULL,
	CONSTRAINT [PK_MLBAttend] PRIMARY KEY NONCLUSTERED (teamId, yearId) ON [PRIMARY]
) ON [PRIMARY]
GO


