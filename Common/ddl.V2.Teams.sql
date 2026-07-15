
/*
Purpose: Create table of supported Teams in the AgilitySports schema.
Object: core.Teams
Dependencies: reference.Sports

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
CREATE TABLE [core].[Teams](
	[teamCode] [varchar](15) NOT NULL,
	[sportCode] [varchar](3) NOT NULL,
	[teamShortName] [varchar](30) NULL,
	[teamName] [varchar](50) NOT NULL,
	[league] [varchar](50) NULL,
	[ESPNteamCode] [varchar](3) NULL,
 CONSTRAINT [PK_Teams_sportCode_teamCode] PRIMARY KEY CLUSTERED ([sportCode] ASC, [teamCode] ASC)
)
GO

ALTER TABLE [core].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_Sports] FOREIGN KEY([sportCode])
REFERENCES [reference].[Sports] ([sportCode])
GO

ALTER TABLE [core].[Teams] CHECK CONSTRAINT [FK_Teams_Sports]
GO