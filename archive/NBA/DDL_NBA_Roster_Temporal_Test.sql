-- Unit test Temporal auditing of the NBA.Roster table

DECLARE @Savecollege varchar(50);

SELECT @Savecollege = College
FROM NBA.Roster
WHERE PlayerID = 8

UPDATE NBA.Roster
SET College = 'Audit test'
WHERE PlayerID = 8

UPDATE NBA.Roster
SET college = @Savecollege
WHERE PlayerID = 8

SELECT *
FROM NBA.RosterHistory