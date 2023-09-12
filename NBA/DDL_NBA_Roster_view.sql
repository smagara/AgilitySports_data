USE [Xfer]
go


/****** View of player data in the NBA schema from Wikipedia website ******/
CREATE view [NBA].[vwPlayer]  AS
SELECT
      [Name]
	  ,
      FirstName=Replace(
		SUBSTRING([Name],
                 CHARINDEX(', ', [Name]) + 2,
                 LEN([Name]) - CHARINDEX(', ', [Name])),
		'(TW)', '')  -- two way contract

	  ,LastName=
		SUBSTRING([Name], 1, CHARINDEX(', ', [Name]) - 1)    
	,Team
	,Position=[Pos]
	,Number=[No]
	,Height=Height2
	,[Weight]=Left([Weight],3)
	,DateOfBirth=[DOB_YYYY_MM_DD]
	,College=[From]
FROM [Xfer].NBA.Roster

GO


