/* Fetch rows from the PositionCodes static table */
-- Test CI/CD SQL pipeline

SELECT Sport, PositionCode, PositionDesc
FROM dbo.PositionCodes
ORDER BY Sport, PositionCode