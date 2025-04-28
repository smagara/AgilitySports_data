SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Bill Wolff's AgilitySports training application
--
-- Populate the MLB Roster table from the Lahman Database schema 
-- One time usage
--
-- History
-- 09/12/2023 - Created
-- ================================================
CREATE PROCEDURE MLB.populatePlayer 

AS
BEGIN

	INSERT INTO AgilitySports.MLB.Roster(
		[playerID]
		,[FirstName]
		,[LastName]
		,[TeamName]
		,[League]
		,[Position]
		,[Weight]
		,[Height]
		,[Bats]
		,[Throws]
		,[DateOfBirth]
		,[BirthCountry]
		,[BirthPlace]
		,[Debut]
		,[teamID]
		,[Season])
	SELECT 
		[playerID]
		,[FirstName]
		,[LastName]
		,[TeamName]
		,[League]
		,[Position]
		,[Weight]
		,[Height]
		,[Bats]
		,[Throws]
		,[DateOfBirth]
		,[BirthCountry]
		,[BirthPlace]
		,[Debut]
		,[teamID]
		,[Season]
	FROM MLB.vwPlayer
		
END

