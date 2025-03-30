/* 
    Drop the "name" field on the existing NFL.Roster table. 
        -Disable System Versioning
        -Drop "name" from both the main and history tables
        -Reenable versioning
*/
USE AgilitySports
go

ALTER TABLE NFL.Roster SET (SYSTEM_VERSIONING = OFF);

ALTER TABLE NFL.Roster DROP COLUMN [name];
ALTER TABLE NFL.RosterHistory DROP COLUMN [name];

ALTER TABLE NFL.Roster
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = NFL.RosterHistory));