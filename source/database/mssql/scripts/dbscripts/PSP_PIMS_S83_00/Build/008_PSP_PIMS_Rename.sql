/* -----------------------------------------------------------------------------
Rename the TERM table and columns to PERIOD
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
Author        Date         Comment
------------  -----------  -----------------------------------------------------
Doug Filteau  2024-Jun-20  Initial version.
----------------------------------------------------------------------------- */

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO


-- ----------------------------------------------
-- Rename Tables and Columns
-- ----------------------------------------------

-- Alter PIMS_LEASE_PAYMENT
PRINT N'Alter PIMS_LEASE_PAYMENT'
GO
exec sp_rename 'dbo.PIMS_LEASE_PAYMENT.LEASE_TERM_ID', 'LEASE_PERIOD_ID', 'COLUMN';
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter PIMS_LEASE_PAYMENT_HIST
PRINT N'Alter PIMS_LEASE_PAYMENT_HIST'
GO
exec sp_rename 'dbo.PIMS_LEASE_PAYMENT_HIST.LEASE_TERM_ID', 'LEASE_PERIOD_ID', 'COLUMN';
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO


-- ----------------------------------------------
-- Process Indices
-- ----------------------------------------------

-- Drop index dbo.LSPYMT_LEASE_PERIOD_ID_IDX
PRINT N'Drop index dbo.LSPYMT_LEASE_PERIOD_ID_IDX'
GO
DROP INDEX IF EXISTS [dbo].[PIMS_LEASE_PAYMENT].[LSPYMT_LEASE_PERIOD_ID_IDX]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- ----------------------------------------------
-- Process Triggers
-- ----------------------------------------------

-- Drop trigger dbo.PIMS_LSPYMT_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_LSPYMT_A_S_IUD_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_LSPYMT_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create triger PIMS_LSPYMT_A_S_IUD_TR
PRINT N'Create triger PIMS_LSPYMT_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LSPYMT_A_S_IUD_TR] ON PIMS_LEASE_PAYMENT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_LEASE_PAYMENT_HIST set END_DATE_HIST = @curr_date where LEASE_PAYMENT_ID in (select LEASE_PAYMENT_ID from deleted) and END_DATE_HIST is null;
  
  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_LEASE_PAYMENT_HIST ([LEASE_PAYMENT_ID], [LEASE_PERIOD_ID], [LEASE_PAYMENT_METHOD_TYPE_CODE], [LEASE_PAYMENT_STATUS_TYPE_CODE], [LEASE_PAYMENT_CATEGORY_TYPE_CODE], [LEASE_PMT_FREQ_TYPE_CODE], [PAYMENT_RECEIVED_DATE], [PAYMENT_AMOUNT_PRE_TAX], [PAYMENT_AMOUNT_PST], [PAYMENT_AMOUNT_GST], [PAYMENT_AMOUNT_TOTAL], [NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _LEASE_PAYMENT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [LEASE_PAYMENT_ID], [LEASE_PERIOD_ID], [LEASE_PAYMENT_METHOD_TYPE_CODE], [LEASE_PAYMENT_STATUS_TYPE_CODE], [LEASE_PAYMENT_CATEGORY_TYPE_CODE], [LEASE_PMT_FREQ_TYPE_CODE], [PAYMENT_RECEIVED_DATE], [PAYMENT_AMOUNT_PRE_TAX], [PAYMENT_AMOUNT_PST], [PAYMENT_AMOUNT_GST], [PAYMENT_AMOUNT_TOTAL], [NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_LEASE_PAYMENT_H_ID_SEQ]) as [_LEASE_PAYMENT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_LSPYMT_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_LSPYMT_I_S_I_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_LSPYMT_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create triger PIMS_LSPYMT_I_S_I_TR
PRINT N'Create triger PIMS_LSPYMT_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LSPYMT_I_S_I_TR] ON PIMS_LEASE_PAYMENT INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted) 
    RETURN;
  
  insert into PIMS_LEASE_PAYMENT ("LEASE_PAYMENT_ID",
      "LEASE_PERIOD_ID",
      "LEASE_PAYMENT_METHOD_TYPE_CODE",
      "LEASE_PAYMENT_STATUS_TYPE_CODE",
      "LEASE_PAYMENT_CATEGORY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE",
      "PAYMENT_RECEIVED_DATE",
      "PAYMENT_AMOUNT_PRE_TAX",
      "PAYMENT_AMOUNT_PST",
      "PAYMENT_AMOUNT_GST",
      "PAYMENT_AMOUNT_TOTAL",
      "NOTE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "LEASE_PAYMENT_ID",
      "LEASE_PERIOD_ID",
      "LEASE_PAYMENT_METHOD_TYPE_CODE",
      "LEASE_PAYMENT_STATUS_TYPE_CODE",
      "LEASE_PAYMENT_CATEGORY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE",
      "PAYMENT_RECEIVED_DATE",
      "PAYMENT_AMOUNT_PRE_TAX",
      "PAYMENT_AMOUNT_PST",
      "PAYMENT_AMOUNT_GST",
      "PAYMENT_AMOUNT_TOTAL",
      "NOTE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY"
    from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_LSPYMT_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_LSPYMT_I_S_U_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_LSPYMT_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create triger PIMS_LSPYMT_I_S_U_TR
PRINT N'Create triger PIMS_LSPYMT_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_LSPYMT_I_S_U_TR] ON PIMS_LEASE_PAYMENT INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.LEASE_PAYMENT_ID = deleted.LEASE_PAYMENT_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)

  -- update statement
  update PIMS_LEASE_PAYMENT
    set "LEASE_PAYMENT_ID" = inserted."LEASE_PAYMENT_ID",
      "LEASE_PERIOD_ID" = inserted."LEASE_PERIOD_ID",
      "LEASE_PAYMENT_METHOD_TYPE_CODE" = inserted."LEASE_PAYMENT_METHOD_TYPE_CODE",
      "LEASE_PAYMENT_STATUS_TYPE_CODE" = inserted."LEASE_PAYMENT_STATUS_TYPE_CODE",
      "LEASE_PAYMENT_CATEGORY_TYPE_CODE" = inserted."LEASE_PAYMENT_CATEGORY_TYPE_CODE",
      "LEASE_PMT_FREQ_TYPE_CODE" = inserted."LEASE_PMT_FREQ_TYPE_CODE",
      "PAYMENT_RECEIVED_DATE" = inserted."PAYMENT_RECEIVED_DATE",
      "PAYMENT_AMOUNT_PRE_TAX" = inserted."PAYMENT_AMOUNT_PRE_TAX",
      "PAYMENT_AMOUNT_PST" = inserted."PAYMENT_AMOUNT_PST",
      "PAYMENT_AMOUNT_GST" = inserted."PAYMENT_AMOUNT_GST",
      "PAYMENT_AMOUNT_TOTAL" = inserted."PAYMENT_AMOUNT_TOTAL",
      "NOTE" = inserted."NOTE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_LEASE_PAYMENT
    inner join inserted
    on (PIMS_LEASE_PAYMENT.LEASE_PAYMENT_ID = inserted.LEASE_PAYMENT_ID);
    
END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;
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