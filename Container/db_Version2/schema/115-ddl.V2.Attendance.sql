/*
Purpose: Create table for Sports live attendance data.
Object: stats.Attendance
Dependencies: reference.Teams

Change Log:
2026-07-14 Initial version
*/

-- drop table stats.Attendance

if OBJECT_ID(N'stats.Attendance', N'U') IS NOT NULL
    Print 'Table stats.Attendance already exists. Skipping creation.'
else begin

CREATE TABLE stats.Attendance(
	sportCode varchar(3) NOT NULL,
	yearId smallint NOT NULL,
	attendance bigint NULL,
 CONSTRAINT PK_Attendance PRIMARY KEY NONCLUSTERED(sportCode ASC, yearId ASC)
);

ALTER TABLE stats.Attendance  WITH CHECK ADD  CONSTRAINT FK_Attendance_Teams FOREIGN KEY(sportCode)
REFERENCES reference.Sports (sportCode);

ALTER TABLE stats.Attendance CHECK CONSTRAINT FK_Attendance_Teams;
end;


