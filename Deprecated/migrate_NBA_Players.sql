/*
Purpose: Migrate the messy NBA.Roster to the normalized dbo.Players
Object: dbo.Players

Change Log:
2026-07-06  Initial version
*/

Delete from dbo.Players where sportCode = 'NBA';

INSERT INTO dbo.Players (
    sportCode,
    firstName,
    lastName,
    teamCode,
    positionCode,
    number,
    dateOfBirth,
    height,
    weight,
    college
)
SELECT
    'NBA' as sportCode,
    firstName,
    lastName,
    Team,
    Position,
    case when ISNUMERIC(Number) = 0 then 0 else cast(Number as int) end as Number,
    dateOfBirth,
    Height,
    [Weight],
    College
FROM AgilitySports.NBA.Roster
WHERE NUMBER IS NOT NULL
AND firstName not like '%<%'
AND LASTNAME not like '%TABLE%'
AND LASTNAME not like '%INTO%'
AND LASTNAME not like '%=%'
AND LASTNAME <> 'SMITH'
AND LASTNAME <> 'MOUSE'

print 'Done. Migrated ' + convert(varchar(10),@@rowcount) + ' NBA players to dbo.Players.';
