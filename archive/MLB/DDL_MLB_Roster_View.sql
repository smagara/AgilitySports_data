USE [Xfer]
GO

/****** Object:  View [MLB].[vwPlayer]    Script Date: 9/12/2023 11:06:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** View of player data in the baseball schema from the Lahman Database ******/
ALTER view [MLB].[vwPlayer]  AS
SELECT
	Season = a.yearID
	,TeamName = t.[name]
	,League = t.lgID
	,Position=f.pos
	,[Weight]=[weight]
	,Height=CONVERT(VARCHAR(6),[height] /12) + '''' + CONVERT(VARCHAR(6),[height] %12)+'"'
	,Bats=[bats]
	,Throws=[throws]
 	,DateOfBirth=[birthMonth]+'-'+[birthDay]+'-'+[birthYear]
	,BirthCountry=[birthCountry]
	,BirthPlace=[birthCity] + ', ' + [birthState]
	,Debut=[debut]
	,t.teamID
	,p.[playerID]
FROM [Xfer].MLB.[People] p
inner join xfer.MLB.Appearances a
on p.playerID = a.playerID
inner join xfer.MLB.Teams t
on a.teamID = t.TeamID
and a.yearID = t.yearID
and p.playerid=a.playerid
inner join MLB.Fielding f
on p.playerID = f.playerID
and f.yearID=t.yearID
and f.stint = 1 /* first assignment */
where t.yearID = 2022

GO


