-- Unit test Temporal auditing of the NHL.Roster table
UPDATE NHL.Roster
SET Age = Age + 1
WHERE PlayerID = 8

UPDATE NHL.Roster
SET Age = Age - 1
WHERE PlayerID = 8

SELECT *
FROM NHL.RosterHistory