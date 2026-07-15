/*
Purpose: Migrate the messy NFL.Roster to the normalized dbo.Players
Object: dbo.Players

Change Log:
2026-07-06  Initial version
*/

Delete from dbo.Players where sportCode = 'NFL';

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
    --draftYear,
    --birthCityState,
    --birthCountry
)
SELECT
    'NFL' as sportCode,
    firstName,
    lastName,
    case when Team = 'PHI' then 'Eagles'
    when Team = 'WAS' then 'Senetors'
    when Team = 'NYG' then 'Giants'
    when Team = 'DAL' then 'Cowboys'
    else null
    end as teamCode,
    Position,
    case when ISNUMERIC(Number) = 0 then null else cast(Number as int) end as Number,
    BirthDateShortString as dateOfBirth,
    Height,
    [Weight],
    College
    --Drafted as draftYear,
    --BirthPlace as birthCityState,
    --BirthCountry as birthCountry
FROM AgilitySports.NFL.Roster
WHERE NUMBER IS NOT NULL
AND lastName not like '%<%'
AND lastName not like '%TABLE%'
AND lastName not like '%INTO%'
AND lastName not like '%=%'
AND lastName not like '%MOUSE'
AND lastName not like 'string%'
print 'Done. Migrated ' + convert(varchar(10),@@rowcount) + ' NFL players to dbo.Players.';
