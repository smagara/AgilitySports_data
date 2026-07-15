WITH CTE_Dedupe AS (
    SELECT 
        playerID,
        firstName,
        lastName,
        teamCode,
        ROW_NUMBER() OVER (
            PARTITION BY firstName, lastName  -- Groups by the duplicate content
            ORDER BY playerID DESC  -- Numbers them 1, 2, 3... starting with the lowest ID
        ) AS RowNum
    FROM AgilitySports_V2.dbo.Players
)
select * 
INTO MLBDupes
frOM CTE_Dedupe
WHERE RowNum > 1       -- Keeps RowNum 1 (lowest ID), deletes the rest
order by 2,3


delete from AgilitySports_V2.dbo.Players
where playerID in (select playerID from MLBDupes)

