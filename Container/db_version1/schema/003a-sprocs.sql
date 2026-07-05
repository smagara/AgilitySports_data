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
CREATE OR ALTER PROCEDURE MLB.[attendanceReportSproc] 
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
IF USER_ID(N'$(TEST_USER_LOGIN)') IS NOT NULL
BEGIN
	DECLARE @grantExecSql NVARCHAR(MAX);
	SET @grantExecSql = N'GRANT EXEC ON [MLB].[attendanceReportSproc] TO [' + N'$(TEST_USER_LOGIN)' + N'];';
	PRINT @grantExecSql;
	EXEC (@grantExecSql);
END
GRANT EXEC ON [MLB].[attendanceReportSproc] to public;
GO

declare @status varchar(100);
SELECT @status = 'AgilitySports Procs FINISHED! ProcCount=' + CONVERT(varchar(20), COUNT(*))
FROM INFORMATION_SCHEMA.ROUTINES;
print @status;
GO