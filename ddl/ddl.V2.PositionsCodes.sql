/*
Purpose: Create table for Player Positions in the AgilitySports schema.
Object: reference.PositionCodes
Dependencies: reference.Sports

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/

/* Position codeset table definition for all Agility Sports */
if OBJECT_ID(N'reference.PositionCodes', N'U') IS NOT NULL
    Print 'Table reference.PositionCodes already exists. Skipping creation.'
else
CREATE TABLE [reference].[PositionCodes](
	[sportCode] [varchar](3) NOT NULL,
	[positionCode] [varchar](3) NOT NULL,
	[positionDesc] [varchar](40) NOT NULL,
 CONSTRAINT [PK_PositionCodes] PRIMARY KEY CLUSTERED ([sportCode] ASC, [positionCode] ASC)
)
GO

ALTER TABLE [reference].[PositionCodes]  WITH CHECK ADD  CONSTRAINT [FK_PositionCodes_Sports] FOREIGN KEY([sportCode])
REFERENCES [reference].[Sports] ([sportCode])
GO

ALTER TABLE [reference].[PositionCodes] CHECK CONSTRAINT [FK_PositionCodes_Sports]
GO