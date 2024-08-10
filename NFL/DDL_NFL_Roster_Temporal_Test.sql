-- Unit test Temporal auditing of the NFL.Roster table

DECLARE @SaveTeam varchar(50);

SELECT @SaveTeam = Team
FROM NFL.Roster
WHERE PlayerID = 21936

UPDATE NFL.Roster
SET Team = 'Audit test'
WHERE PlayerID = 21936

UPDATE NFL.Roster
SET Team = @SaveTeam
WHERE PlayerID = 21936

SELECT *
FROM NFL.RosterHistory