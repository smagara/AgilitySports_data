/* normalize existing the NHL Position codes */
SELECT distinct OldPos = Position, NewPostion = LEFT(Position, CHARINDEX('/', Position) - 1)
from NHL.Roster
where Position like '%/%'

UPDATE NHL.Roster
SET Position = LEFT(Position, CHARINDEX('/', Position) - 1)
OUTPUT deleted.Position as OldPosition, inserted.Position as NewPosition
from NHL.Roster
where Position like '%/%'