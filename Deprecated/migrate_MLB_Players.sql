/*
Purpose: Migrate the messy MLB.Roster to the normalized dbo.Players
Object: dbo.Players

Change Log:
2026-07-06  Initial version
*/

Delete from dbo.Players where sportCode = 'MLB';

INSERT INTO dbo.Players (
    sportCode,
    firstName,
    lastName,
    teamCode,
    positionCode,
    --number,
    --dateOfBirth,
    height,
    weight,
    --college
    draftYear,
    birthCityState,
    birthCountry
)
SELECT
    'MLB' as sportCode,
    firstName,
    lastName,
        CASE
        WHEN CHARINDEX(' ', LTRIM(RTRIM(TeamName))) = 0 THEN NULL
        ELSE RIGHT(
            LTRIM(RTRIM(TeamName)),
            CHARINDEX(' ', REVERSE(LTRIM(RTRIM(TeamName)))) -1
        )
    END AS teamCode,
    Position,
    --case when ISNUMERIC(Number) = 0 then null else cast(Number as int) end as Number,
    --BirthDateShortString as dateOfBirth,
    Height,
    [Weight],
    --College,
    Year(Debut) as draftYear,
    BirthPlace as birthCityState,
    BirthCountry as birthCountry
FROM AgilitySports.MLB.Roster
where Season = '2022'

print 'Done. Migrated ' + convert(varchar(10),@@rowcount) + ' NFL players to dbo.Players.';


