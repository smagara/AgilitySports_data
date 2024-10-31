/* normalize existing the NBA Position codes */
SELECT distinct OldPos = Position, NewPostion = LEFT(Position, CHARINDEX('/', Position) - 1)
from NBA.Roster
where Position like '%/%'

UPDATE NBA.Roster
SET Position = LEFT(Position, CHARINDEX('/', Position) - 1)
OUTPUT deleted.Position as OldPosition, inserted.Position as NewPosition
from NBA.Roster
where Position like '%/%'