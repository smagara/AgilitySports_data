GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Bill Wolff's AgilitySports training application
--
-- Fetch dataset for a trend report of Sports attendance over the decades
--
-- History
-- 12/13/2023 - Created
-- 07/15/2026 - Upgrade to V2
--
-- EXEC stats.[attendanceReportSproc] @sportCode = 'MLB', @beginDecade = 1940, @endDecade = 1980
-- ================================================
CREATE OR ALTER PROCEDURE stats.[attendanceReportSproc] 
	@sportCode varchar(3), @beginDecade int, @endDecade int
AS
BEGIN

	SELECT 
		YearId = yearId / 10 * 10,
		attendance = sum(attendance),
		sportCode
	FROM stats.Attendance 
	WHERE yearId between @beginDecade and (@endDecade + 9)
	GROUP BY sportCode, yearId / 10 * 10
	Order by 1		

END

GRANT EXEC ON [stats].[attendanceReportSproc] to public;
GO

declare @status varchar(100);
SELECT @status = 'AgilitySports Procs FINISHED! ProcCount=' + CONVERT(varchar(20), COUNT(*))
FROM INFORMATION_SCHEMA.ROUTINES;
print @status;
GO