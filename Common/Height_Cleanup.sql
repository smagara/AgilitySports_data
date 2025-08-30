/* 
	Update height fields to eliminate interior spaces.
	The formats were not consistent between sports.
	New format is 5'11" not 5' 11", for example.
*/

Use AgilitySports;
GO

BEGIN TRAN

	UPDATE NFL.Roster
		SET Height = replace(Height, ' ', '')
	OUTPUT
		INSERTED.PlayerId,
		INSERTED.LastName,
		DELETED.Height AS Old_Height,
		INSERTED.Height AS New_Height

	UPDATE NBA.Roster
		SET Height = replace(Height, ' ', '')
	OUTPUT
		INSERTED.PlayerId,
		INSERTED.LastName,
		DELETED.Height AS Old_Height,
		INSERTED.Height AS New_Height

COMMIT TRAN
