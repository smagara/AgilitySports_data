/*
Purpose: Migrate the messy NHL.Roster to the normalized dbo.Players
Object: dbo.Players

Change Log:
2026-07-06  Initial version
*/
Delete from dbo.Players where sportCode = 'NHL';

INSERT INTO dbo.Players (
    sportCode,
    firstName,
    lastName,
    teamCode,
    positionCode,
    number,
    --dateOfBirth,
    --height,
    --weight,
    --college,
    draftYear,
    birthCityState,
    birthCountry
)
SELECT
    'NHL' as sportCode,
    CASE
        WHEN CHARINDEX(' ', LTRIM(RTRIM([Name]))) > 0
            THEN LEFT(LTRIM(RTRIM([Name])), CHARINDEX(' ', LTRIM(RTRIM([Name]))) - 1)
        ELSE LTRIM(RTRIM([Name]))
    END AS firstName,
    CASE
        WHEN CHARINDEX(' ', LTRIM(RTRIM([Name]))) > 0
            THEN LTRIM(SUBSTRING(
                LTRIM(RTRIM([Name])),
                CHARINDEX(' ', LTRIM(RTRIM([Name]))) + 1,
                LEN(LTRIM(RTRIM([Name])))
            ))
        ELSE NULL
    END AS lastName,
    Team,
    Position,
    case when ISNUMERIC(Number) = 0 then null else cast(Number as int) end as Number,
    --dateOfBirth,
    --Height,
    --[Weight],
    --College,
    Drafted as draftYear,
    BirthPlace as birthCityState,
    BirthCountry as birthCountry
FROM AgilitySports.NHL.Roster
WHERE NUMBER IS NOT NULL
AND [Name] not like '%<%'
AND [Name] not like '%TABLE%'
AND [Name] not like '%INTO%'
AND [Name] not like '%=%'
AND [Name] not like '%SMITH'
AND [Name] not like '%MOUSE'
AND [Name] not like 'string%'
AND BirthPlace not like '%nowhere%'
print 'Done. Migrated ' + convert(varchar(10),@@rowcount) + ' NHL players to dbo.Players.';
