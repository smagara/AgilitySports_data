/*
Purpose: Create table of supported sports in the AgilitySports schema.
Object: reference.Sports
Dependencies: None

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
if OBJECT_ID(N'reference.Sports', N'U') IS NOT NULL
    Print 'Table reference.Sports already exists. Skipping creation.'
else
CREATE TABLE [reference].[Sports](
	[sportCode] [varchar](3) NOT NULL,
	[sportName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sports_sportCode] PRIMARY KEY CLUSTERED ([sportCode] ASC)
)
GO


