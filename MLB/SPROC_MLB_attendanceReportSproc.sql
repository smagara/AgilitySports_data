-- USE AgilitySports do this manually on Azure SQL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Bill Wolff's AgilitySports training application
--
-- Fetch dataset for a trend report of MLB attendance over the decades
--
-- History
-- 12/13/2023 - Created
--
-- EXEC MLB.[attendanceReportSproc] @beginDecade = 1940, @endDecade = 1980
-- ================================================
CREATE PROCEDURE MLB.[attendanceReportSproc] 
	@beginDecade int, @endDecade int
AS
BEGIN

SELECT 
	YearId = yearId / 10 * 10,
	attendance = sum(attendance)
	FROM MLB.Attendance 
	WHERE yearId between @beginDecade and (@endDecade + 9)
	GROUP BY yearId / 10 * 10
	Order by 1 		
END

GO

-- GRANT EXEC on MLB.[attendanceReportSproc] to agility_user; -- do this manually on Azure SQL

