USE AgilitySports
GO

/* create the NHL Roster table, with wikipedia's schema */

CREATE TABLE [NHL].[Roster](
	[playerID] [smallint] identity(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Team] [nvarchar](50) NOT NULL,
	[Number] [nvarchar](5) NULL,
	[Position] [nvarchar](10) NOT NULL,
	[Handed] [nvarchar](1) NOT NULL,
	[Age] [tinyint] NOT NULL,
	[Drafted] [smallint] NOT NULL,
	[BirthPlace] [nvarchar](50) NULL,
	[BirthCountry] [nvarchar](50) NULL,
 CONSTRAINT [PK_NHL.Roster] PRIMARY KEY CLUSTERED ([playerID] , [Team])
) ON [PRIMARY]
GO


