-- Script generated by Aqua Data Studio Schema Synchronization for MS SQL Server 2016 on Fri Aug 11 10:53:27 PDT 2023
-- Execute this script on:
-- 		PSP_PIMS_S60_00/dbo - This database/schema will be modified
-- to synchronize it with MS SQL Server 2016:
-- 		PSP_PIMS_S61_00/dbo

-- We recommend backing up the database prior to executing the script.

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_ACQNFL_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_ACQNFL_I_S_U_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_ACQNFL_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_CMPREQ_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_CMPREQ_I_S_U_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_CMPREQ_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_ACQNFL_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_ACQNFL_A_S_IUD_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_ACQNFL_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_CMPREQ_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_CMPREQ_A_S_IUD_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_CMPREQ_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_CMPREQ_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_CMPREQ_I_S_I_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_CMPREQ_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_ACQNFL_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_ACQNFL_I_S_I_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_ACQNFL_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop table dbo.TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE
PRINT N'Drop table dbo.TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE'
GO
DROP TABLE IF EXISTS [dbo].[TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create table dbo.TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE
PRINT N'Create table dbo.TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE'
GO
CREATE TABLE [dbo].[TMP_PIMS_PROP_PROP_ADJACENT_LAND_TYPE]  ( 
	[PROPERTY_ID]                     	bigint NULL,
	[PROPERTY_ADJACENT_LAND_TYPE_CODE]	nvarchar(50) NULL 
	)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_ACQUISITION_FILE
PRINT N'Alter table dbo.PIMS_ACQUISITION_FILE'
GO
ALTER TABLE [dbo].[PIMS_ACQUISITION_FILE]
	DROP COLUMN IF EXISTS [ALTERNATE_PROJECT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_COMPENSATION_REQUISITION
PRINT N'Alter table dbo.PIMS_COMPENSATION_REQUISITION'
GO
ALTER TABLE [dbo].[PIMS_COMPENSATION_REQUISITION]
	ADD [ALTERNATE_PROJECT_ID] bigint NULL
GO
EXEC sp_addextendedproperty 
	@name = N'MS_Description', @value = N'Link a file to an "Alternate Project", so the user can make alternate payments that may be due after the original file''s project closes.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'PIMS_COMPENSATION_REQUISITION', 
	@level2type = N'Column', @level2name = N'ALTERNATE_PROJECT_ID'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_COMPENSATION_REQUISITION_HIST
PRINT N'Alter table dbo.PIMS_COMPENSATION_REQUISITION_HIST'
GO
ALTER TABLE [dbo].[PIMS_COMPENSATION_REQUISITION_HIST]
	ADD [ALTERNATE_PROJECT_ID] bigint NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_ACQUISITION_FILE_HIST
PRINT N'Alter table dbo.PIMS_ACQUISITION_FILE_HIST'
GO
ALTER TABLE [dbo].[PIMS_ACQUISITION_FILE_HIST]
	DROP COLUMN IF EXISTS [ALTERNATE_PROJECT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_INTEREST_HOLDER_HIST
PRINT N'Alter table dbo.PIMS_INTEREST_HOLDER_HIST'
GO

-- Drop dynamically-named default constraints
PRINT N'Drop dynamically-named default constraints'
GO
DECLARE @sqlQry  VARCHAR(1000)
DECLARE @defName VARCHAR(100)
SET @defName = (SELECT obj.NAME
                FROM   SYSOBJECTS obj                          INNER JOIN
                       SYSCOLUMNS col on obj.ID = col.CDEFAULT INNER JOIN
                       SYSOBJECTS tbl on col.ID = tbl.ID
                WHERE  obj.XTYPE = 'D'
                   AND tbl.NAME = 'PIMS_INTEREST_HOLDER_HIST' 
                   AND col.NAME = 'INTEREST_HOLDER_TYPE_CODE')
SET @sqlQry = 'ALTER TABLE [dbo].[PIMS_INTEREST_HOLDER_HIST] DROP CONSTRAINT IF EXISTS [' + @defName + ']'
EXEC (@sqlQry)
IF @@ERROR <> 0 SET NOEXEC ON
GO

ALTER TABLE [dbo].[PIMS_INTEREST_HOLDER_HIST] DROP CONSTRAINT IF EXISTS [DF__PIMS_INTE__INTER__45943E77]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_INTEREST_HOLDER_HIST] ADD DEFAULT N'INTHLDR' FOR [INTEREST_HOLDER_TYPE_CODE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create index dbo.CMPREQ_ALTERNATE_PROJECT_ID_IDX
PRINT N'Create index dbo.CMPREQ_ALTERNATE_PROJECT_ID_IDX'
GO
CREATE NONCLUSTERED INDEX [CMPREQ_ALTERNATE_PROJECT_ID_IDX]
	ON [dbo].[PIMS_COMPENSATION_REQUISITION]([ALTERNATE_PROJECT_ID])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create foreign key constraint dbo.PIM_PROJCT_PIM_CMPREQ_FK
PRINT N'Create foreign key constraint dbo.PIM_PROJCT_PIM_CMPREQ_FK'
GO
ALTER TABLE [dbo].[PIMS_COMPENSATION_REQUISITION]
	ADD CONSTRAINT [PIM_PROJCT_PIM_CMPREQ_FK]
	FOREIGN KEY([ALTERNATE_PROJECT_ID])
	REFERENCES [dbo].[PIMS_PROJECT]([ID])
	ON DELETE NO ACTION 
	ON UPDATE NO ACTION 
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_ACQNFL_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_ACQNFL_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_ACQNFL_I_S_I_TR] ON PIMS_ACQUISITION_FILE INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted) 
    RETURN;

  
  insert into PIMS_ACQUISITION_FILE ("ACQUISITION_FILE_ID",
      "PROJECT_ID",
      "PRODUCT_ID",
      "ACQUISITION_FILE_STATUS_TYPE_CODE",
      "ACQUISITION_TYPE_CODE",
      "ACQUISITION_FUNDING_TYPE_CODE",
      "ACQ_PHYS_FILE_STATUS_TYPE_CODE",
      "REGION_CODE",
      "FILE_NAME",
      "FILE_NO",
      "FILE_NUMBER",
      "LEGACY_FILE_NUMBER",
      "LEGACY_STAKEHOLDER",
      "FUNDING_OTHER",
      "ASSIGNED_DATE",
      "DELIVERY_DATE",
      "COMPLETION_DATE",
      "PAIMS_ACQUISITION_FILE_ID",
      "TOTAL_ALLOWABLE_COMPENSATION",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "ACQUISITION_FILE_ID",
      "PROJECT_ID",
      "PRODUCT_ID",
      "ACQUISITION_FILE_STATUS_TYPE_CODE",
      "ACQUISITION_TYPE_CODE",
      "ACQUISITION_FUNDING_TYPE_CODE",
      "ACQ_PHYS_FILE_STATUS_TYPE_CODE",
      "REGION_CODE",
      "FILE_NAME",
      "FILE_NO",
      "FILE_NUMBER",
      "LEGACY_FILE_NUMBER",
      "LEGACY_STAKEHOLDER",
      "FUNDING_OTHER",
      "ASSIGNED_DATE",
      "DELIVERY_DATE",
      "COMPLETION_DATE",
      "PAIMS_ACQUISITION_FILE_ID",
      "TOTAL_ALLOWABLE_COMPENSATION",
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

-- Create trigger dbo.PIMS_CMPREQ_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_CMPREQ_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_CMPREQ_I_S_I_TR] ON PIMS_COMPENSATION_REQUISITION INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted) 
    RETURN;

  
  insert into PIMS_COMPENSATION_REQUISITION ("COMPENSATION_REQUISITION_ID",
      "ACQUISITION_FILE_ID",
      "ACQUISITION_OWNER_ID",
      "INTEREST_HOLDER_ID",
      "ACQUISITION_FILE_PERSON_ID",
      "CHART_OF_ACCOUNTS_ID",
      "RESPONSIBILITY_ID",
      "YEARLY_FINANCIAL_ID",
      "ALTERNATE_PROJECT_ID",
      "LEGACY_PAYEE",
      "IS_DRAFT",
      "IS_PAYMENT_IN_TRUST",
      "GST_NUMBER",
      "FISCAL_YEAR",
      "AGREEMENT_DT",
      "EXPROP_NOTICE_SERVED_DT",
      "EXPROP_VESTING_DT",
      "GENERATION_DT",
      "FINALIZED_DATE",
      "SPECIAL_INSTRUCTION",
      "DETAILED_REMARKS",
      "IS_DISABLED",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "COMPENSATION_REQUISITION_ID",
      "ACQUISITION_FILE_ID",
      "ACQUISITION_OWNER_ID",
      "INTEREST_HOLDER_ID",
      "ACQUISITION_FILE_PERSON_ID",
      "CHART_OF_ACCOUNTS_ID",
      "RESPONSIBILITY_ID",
      "YEARLY_FINANCIAL_ID",
      "ALTERNATE_PROJECT_ID",
      "LEGACY_PAYEE",
      "IS_DRAFT",
      "IS_PAYMENT_IN_TRUST",
      "GST_NUMBER",
      "FISCAL_YEAR",
      "AGREEMENT_DT",
      "EXPROP_NOTICE_SERVED_DT",
      "EXPROP_VESTING_DT",
      "GENERATION_DT",
      "FINALIZED_DATE",
      "SPECIAL_INSTRUCTION",
      "DETAILED_REMARKS",
      "IS_DISABLED",
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

-- Create trigger dbo.PIMS_CMPREQ_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_CMPREQ_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_CMPREQ_A_S_IUD_TR] ON PIMS_COMPENSATION_REQUISITION FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_COMPENSATION_REQUISITION_HIST set END_DATE_HIST = @curr_date where COMPENSATION_REQUISITION_ID in (select COMPENSATION_REQUISITION_ID from deleted) and END_DATE_HIST is null;
  
  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_COMPENSATION_REQUISITION_HIST ([COMPENSATION_REQUISITION_ID], [ACQUISITION_FILE_ID], [ACQUISITION_OWNER_ID], [INTEREST_HOLDER_ID], [ACQUISITION_FILE_PERSON_ID], [CHART_OF_ACCOUNTS_ID], [RESPONSIBILITY_ID], [YEARLY_FINANCIAL_ID], [ALTERNATE_PROJECT_ID], [LEGACY_PAYEE], [IS_DRAFT], [IS_PAYMENT_IN_TRUST], [GST_NUMBER], [FISCAL_YEAR], [AGREEMENT_DT], [EXPROP_NOTICE_SERVED_DT], [EXPROP_VESTING_DT], [GENERATION_DT], [FINALIZED_DATE], [SPECIAL_INSTRUCTION], [DETAILED_REMARKS], [IS_DISABLED], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _COMPENSATION_REQUISITION_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [COMPENSATION_REQUISITION_ID], [ACQUISITION_FILE_ID], [ACQUISITION_OWNER_ID], [INTEREST_HOLDER_ID], [ACQUISITION_FILE_PERSON_ID], [CHART_OF_ACCOUNTS_ID], [RESPONSIBILITY_ID], [YEARLY_FINANCIAL_ID], [ALTERNATE_PROJECT_ID], [LEGACY_PAYEE], [IS_DRAFT], [IS_PAYMENT_IN_TRUST], [GST_NUMBER], [FISCAL_YEAR], [AGREEMENT_DT], [EXPROP_NOTICE_SERVED_DT], [EXPROP_VESTING_DT], [GENERATION_DT], [FINALIZED_DATE], [SPECIAL_INSTRUCTION], [DETAILED_REMARKS], [IS_DISABLED], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_COMPENSATION_REQUISITION_H_ID_SEQ]) as [_COMPENSATION_REQUISITION_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_ACQNFL_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_ACQNFL_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_ACQNFL_A_S_IUD_TR] ON PIMS_ACQUISITION_FILE FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_ACQUISITION_FILE_HIST set END_DATE_HIST = @curr_date where ACQUISITION_FILE_ID in (select ACQUISITION_FILE_ID from deleted) and END_DATE_HIST is null;
  
  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_ACQUISITION_FILE_HIST ([ACQUISITION_FILE_ID], [PROJECT_ID], [PRODUCT_ID], [ACQUISITION_FILE_STATUS_TYPE_CODE], [ACQUISITION_TYPE_CODE], [ACQUISITION_FUNDING_TYPE_CODE], [ACQ_PHYS_FILE_STATUS_TYPE_CODE], [REGION_CODE], [FILE_NAME], [FILE_NO], [FILE_NUMBER], [LEGACY_FILE_NUMBER], [LEGACY_STAKEHOLDER], [FUNDING_OTHER], [ASSIGNED_DATE], [DELIVERY_DATE], [COMPLETION_DATE], [PAIMS_ACQUISITION_FILE_ID], [TOTAL_ALLOWABLE_COMPENSATION], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _ACQUISITION_FILE_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [ACQUISITION_FILE_ID], [PROJECT_ID], [PRODUCT_ID], [ACQUISITION_FILE_STATUS_TYPE_CODE], [ACQUISITION_TYPE_CODE], [ACQUISITION_FUNDING_TYPE_CODE], [ACQ_PHYS_FILE_STATUS_TYPE_CODE], [REGION_CODE], [FILE_NAME], [FILE_NO], [FILE_NUMBER], [LEGACY_FILE_NUMBER], [LEGACY_STAKEHOLDER], [FUNDING_OTHER], [ASSIGNED_DATE], [DELIVERY_DATE], [COMPLETION_DATE], [PAIMS_ACQUISITION_FILE_ID], [TOTAL_ALLOWABLE_COMPENSATION], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_ACQUISITION_FILE_H_ID_SEQ]) as [_ACQUISITION_FILE_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_CMPREQ_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_CMPREQ_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_CMPREQ_I_S_U_TR] ON PIMS_COMPENSATION_REQUISITION INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.COMPENSATION_REQUISITION_ID = deleted.COMPENSATION_REQUISITION_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_COMPENSATION_REQUISITION
    set "COMPENSATION_REQUISITION_ID" = inserted."COMPENSATION_REQUISITION_ID",
      "ACQUISITION_FILE_ID" = inserted."ACQUISITION_FILE_ID",
      "ACQUISITION_OWNER_ID" = inserted."ACQUISITION_OWNER_ID",
      "INTEREST_HOLDER_ID" = inserted."INTEREST_HOLDER_ID",
      "ACQUISITION_FILE_PERSON_ID" = inserted."ACQUISITION_FILE_PERSON_ID",
      "CHART_OF_ACCOUNTS_ID" = inserted."CHART_OF_ACCOUNTS_ID",
      "RESPONSIBILITY_ID" = inserted."RESPONSIBILITY_ID",
      "YEARLY_FINANCIAL_ID" = inserted."YEARLY_FINANCIAL_ID",
      "ALTERNATE_PROJECT_ID" = inserted."ALTERNATE_PROJECT_ID",
      "LEGACY_PAYEE" = inserted."LEGACY_PAYEE",
      "IS_DRAFT" = inserted."IS_DRAFT",
      "IS_PAYMENT_IN_TRUST" = inserted."IS_PAYMENT_IN_TRUST",
      "GST_NUMBER" = inserted."GST_NUMBER",
      "FISCAL_YEAR" = inserted."FISCAL_YEAR",
      "AGREEMENT_DT" = inserted."AGREEMENT_DT",
      "EXPROP_NOTICE_SERVED_DT" = inserted."EXPROP_NOTICE_SERVED_DT",
      "EXPROP_VESTING_DT" = inserted."EXPROP_VESTING_DT",
      "GENERATION_DT" = inserted."GENERATION_DT",
      "FINALIZED_DATE" = inserted."FINALIZED_DATE",
      "SPECIAL_INSTRUCTION" = inserted."SPECIAL_INSTRUCTION",
      "DETAILED_REMARKS" = inserted."DETAILED_REMARKS",
      "IS_DISABLED" = inserted."IS_DISABLED",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_COMPENSATION_REQUISITION
    inner join inserted
    on (PIMS_COMPENSATION_REQUISITION.COMPENSATION_REQUISITION_ID = inserted.COMPENSATION_REQUISITION_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_ACQNFL_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_ACQNFL_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_ACQNFL_I_S_U_TR] ON PIMS_ACQUISITION_FILE INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.ACQUISITION_FILE_ID = deleted.ACQUISITION_FILE_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_ACQUISITION_FILE
    set "ACQUISITION_FILE_ID" = inserted."ACQUISITION_FILE_ID",
      "PROJECT_ID" = inserted."PROJECT_ID",
      "PRODUCT_ID" = inserted."PRODUCT_ID",
      "ACQUISITION_FILE_STATUS_TYPE_CODE" = inserted."ACQUISITION_FILE_STATUS_TYPE_CODE",
      "ACQUISITION_TYPE_CODE" = inserted."ACQUISITION_TYPE_CODE",
      "ACQUISITION_FUNDING_TYPE_CODE" = inserted."ACQUISITION_FUNDING_TYPE_CODE",
      "ACQ_PHYS_FILE_STATUS_TYPE_CODE" = inserted."ACQ_PHYS_FILE_STATUS_TYPE_CODE",
      "REGION_CODE" = inserted."REGION_CODE",
      "FILE_NAME" = inserted."FILE_NAME",
      "FILE_NO" = inserted."FILE_NO",
      "FILE_NUMBER" = inserted."FILE_NUMBER",
      "LEGACY_FILE_NUMBER" = inserted."LEGACY_FILE_NUMBER",
      "LEGACY_STAKEHOLDER" = inserted."LEGACY_STAKEHOLDER",
      "FUNDING_OTHER" = inserted."FUNDING_OTHER",
      "ASSIGNED_DATE" = inserted."ASSIGNED_DATE",
      "DELIVERY_DATE" = inserted."DELIVERY_DATE",
      "COMPLETION_DATE" = inserted."COMPLETION_DATE",
      "PAIMS_ACQUISITION_FILE_ID" = inserted."PAIMS_ACQUISITION_FILE_ID",
      "TOTAL_ALLOWABLE_COMPENSATION" = inserted."TOTAL_ALLOWABLE_COMPENSATION",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_ACQUISITION_FILE
    inner join inserted
    on (PIMS_ACQUISITION_FILE.ACQUISITION_FILE_ID = inserted.ACQUISITION_FILE_ID);

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