SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create foreign key constraint dbo.PIM_AGRSTY_PIM_AGRMNT_FK
PRINT N'Create foreign key constraint dbo.PIM_AGRSTY_PIM_AGRMNT_FK'
GO
ALTER TABLE [dbo].[PIMS_AGREEMENT]
	ADD CONSTRAINT [PIM_AGRSTY_PIM_AGRMNT_FK]
	FOREIGN KEY([AGREEMENT_STATUS_TYPE_CODE])
	REFERENCES [dbo].[PIMS_AGREEMENT_STATUS_TYPE]([AGREEMENT_STATUS_TYPE_CODE])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
   IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
   PRINT 'The database update failed'
END
GO
