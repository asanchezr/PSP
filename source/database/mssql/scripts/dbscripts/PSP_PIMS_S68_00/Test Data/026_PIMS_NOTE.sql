DELETE
FROM   PIMS_NOTE;
GO

DECLARE @i INT = 0
WHILE @i < 50
  BEGIN
  SET @i = @i + 1
  INSERT INTO [dbo].[PIMS_NOTE] ([NOTE_TXT], [CONCURRENCY_CONTROL_NUMBER]) 
	  VALUES(N'Billy Bob notes '      + LEFT(NEWID(),7), 1);
	END
GO
