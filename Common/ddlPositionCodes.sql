/* Position codeset table definition for all Agility Sports */
create table dbo.PositionCodes
(
	Sport varchar(3) not null,
	PositionCode varchar(10) not null,
	PositionDesc varchar(40) not null,
	CONSTRAINT PK_PositionCodes PRIMARY KEY (Sport, PositionCode)
)