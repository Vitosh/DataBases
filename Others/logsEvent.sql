CREATE TABLE MoneyLogs
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ChangeDate DATETIME DEFAULT GETDATE() NOT NULL,
	Command NCHAR(6) NOT NULL,
	OldCell BIGINT NULL,
	NewCell BIGINT NULL,
	OldPaidPerCell BIGINT NULL,
	NewPaidPerCell BIGINT NULL,
	UserName NCHAR(100) NOT NULL
)

GO

CREATE TRIGGER money_chess_change
ON Money
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operation CHAR(6)
		SET @operation = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operation = 'Delete'
			INSERT INTO MoneyLogs (Command, ChangeDate, OldCell, OldPaidPerCell, UserName)
			SELECT @operation, GETDATE(),  d.Cell, d.PaidPerCell, USER_Name()
			FROM deleted d

	IF @operation = 'Insert'
			INSERT INTO MoneyLogs (Command, ChangeDate, NewCell,  NewPaidPerCell, UserName)
			SELECT @operation, GETDATE(), i.Cell, i.PaidPerCell,  USER_Name()
			FROM inserted i

	IF @operation = 'Update'
			INSERT INTO MoneyLogs (Command, ChangeDate, NewCell, OldCell, NewPaidPerCell,OldPaidPerCell, UserName)
			SELECT @operation, GETDATE(), d.Cell, i.Cell, d.PaidPerCell, i.PaidPerCell, USER_Name()
			FROM deleted d, inserted i
END
GO