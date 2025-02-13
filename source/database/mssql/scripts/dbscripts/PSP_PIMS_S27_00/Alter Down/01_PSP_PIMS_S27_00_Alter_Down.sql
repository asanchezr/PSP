-- Script generated by Aqua Data Studio Schema Synchronization for MS SQL Server 2016 on Mon Apr 25 22:11:26 PDT 2022
-- Execute this script on:
-- 		PSP_PIMS_S27_00/dbo - This database/schema will be modified
-- to synchronize it with MS SQL Server 2016:
-- 		PSP_PIMS_S26_00/dbo

-- We recommend backing up the database prior to executing the script.

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_I_S_I_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_SDRTRN_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_I_S_U_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_SDRTRN_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_SDRTRN_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_SDRTRN_A_S_IUD_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_SDRTRN_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_TENANT_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_TENANT_I_S_I_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_TENANT_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_TENANT_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_TENANT_I_S_U_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_TENANT_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_TENANT_A_S_IUD_TR
PRINT N'Drop trigger dbo.PIMS_TENANT_A_S_IUD_TR'
GO
DROP TRIGGER IF EXISTS [dbo].[PIMS_TENANT_A_S_IUD_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop foreign key constraint dbo.PIM_PERSON_PIM_PRIMARY_CONTACT_FK
PRINT N'Drop foreign key constraint dbo.PIM_PERSON_PIM_PRIMARY_CONTACT_FK'
GO
ALTER TABLE [dbo].[PIMS_LEASE_TENANT]
	DROP CONSTRAINT [PIM_PERSON_PIM_PRIMARY_CONTACT_FK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop index dbo.TENANT_PRIMARY_CONTACT_ID_IDX
PRINT N'Drop index dbo.TENANT_PRIMARY_CONTACT_ID_IDX'
GO
DROP INDEX [dbo].[PIMS_LEASE_TENANT].[TENANT_PRIMARY_CONTACT_ID_IDX]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop primary key constraint dbo.RSFLPR_PK
PRINT N'Drop primary key constraint dbo.RSFLPR_PK'
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE]
	DROP CONSTRAINT [RSFLPR_PK]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop constraint LEASE_HAS_PHYSICAL_FILE_DEF
PRINT N'Drop constraint LEASE_HAS_PHYSICAL_FILE_DEF'
GO
ALTER TABLE [dbo].[PIMS_LEASE]
	DROP CONSTRAINT IF EXISTS [LEASE_HAS_PHYSICAL_FILE_DEF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop constraint LEASE_HAS_DIGITAL_FILE_DEF
PRINT N'Drop constraint LEASE_HAS_DIGITAL_FILE_DEF'
GO
ALTER TABLE [dbo].[PIMS_LEASE]
	DROP CONSTRAINT IF EXISTS [LEASE_HAS_DIGITAL_FILE_DEF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop constraint LEASE_HAS_PHYSICIAL_LICENSE_DEF
PRINT N'Drop constraint LEASE_HAS_PHYSICIAL_LICENSE_DEF'
GO
ALTER TABLE [dbo].[PIMS_LEASE]
	DROP CONSTRAINT IF EXISTS [LEASE_HAS_PHYSICIAL_LICENSE_DEF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop constraint LEASE_HAS_DIGITAL_LICENSE_DEF
PRINT N'Drop constraint LEASE_HAS_DIGITAL_LICENSE_DEF'
GO
ALTER TABLE [dbo].[PIMS_LEASE]
	DROP CONSTRAINT IF EXISTS [LEASE_HAS_DIGITAL_LICENSE_DEF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE
PRINT N'Alter table dbo.PIMS_LEASE'
GO
UPDATE [dbo].[PIMS_LEASE] 
SET    [HAS_PHYSICAL_FILE]          = (CONVERT([bit],(0)))
     , [CONCURRENCY_CONTROL_NUMBER] = [CONCURRENCY_CONTROL_NUMBER] + 1
WHERE  [HAS_PHYSICAL_FILE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ALTER COLUMN [HAS_PHYSICAL_FILE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ADD CONSTRAINT [LEASE_HAS_PHYSICAL_FILE_DEF] DEFAULT (CONVERT([bit],(0))) FOR [HAS_PHYSICAL_FILE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
UPDATE [dbo].[PIMS_LEASE] 
SET    [HAS_DIGITAL_FILE]           = (CONVERT([bit],(0))) 
     , [CONCURRENCY_CONTROL_NUMBER] = [CONCURRENCY_CONTROL_NUMBER] + 1
WHERE  [HAS_DIGITAL_FILE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ALTER COLUMN [HAS_DIGITAL_FILE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ADD CONSTRAINT [LEASE_HAS_DIGITAL_FILE_DEF] DEFAULT (CONVERT([bit],(0))) FOR [HAS_DIGITAL_FILE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
UPDATE [dbo].[PIMS_LEASE] 
SET    [HAS_PHYSICIAL_LICENSE]      = (CONVERT([bit],(0))) 
     , [CONCURRENCY_CONTROL_NUMBER] = [CONCURRENCY_CONTROL_NUMBER] + 1
WHERE  [HAS_PHYSICIAL_LICENSE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ALTER COLUMN [HAS_PHYSICIAL_LICENSE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ADD CONSTRAINT [LEASE_HAS_PHYSICIAL_LICENSE_DEF] DEFAULT (CONVERT([bit],(0))) FOR [HAS_PHYSICIAL_LICENSE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
UPDATE [dbo].[PIMS_LEASE] 
SET    [HAS_DIGITAL_LICENSE]        = (CONVERT([bit],(0))) 
     , [CONCURRENCY_CONTROL_NUMBER] = [CONCURRENCY_CONTROL_NUMBER] + 1
WHERE  [HAS_DIGITAL_LICENSE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ALTER COLUMN [HAS_DIGITAL_LICENSE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE] ADD CONSTRAINT [LEASE_HAS_DIGITAL_LICENSE_DEF] DEFAULT (CONVERT([bit],(0))) FOR [HAS_DIGITAL_LICENSE]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE_TENANT
PRINT N'Alter table dbo.PIMS_LEASE_TENANT'
GO
EXEC sp_dropextendedproperty 
	@name = N'MS_Description' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'PIMS_LEASE_TENANT', 
	@level2type = N'Column', @level2name = N'NOTE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE_TENANT]
	DROP COLUMN [PRIMARY_CONTACT_ID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE_TENANT_HIST
PRINT N'Alter table dbo.PIMS_LEASE_TENANT_HIST'
GO
ALTER TABLE [dbo].[PIMS_LEASE_TENANT_HIST]
	DROP COLUMN [PRIMARY_CONTACT_ID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN'
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN]
	DROP COLUMN [INTEREST_PAID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN_HIST
PRINT N'Alter table dbo.PIMS_SECURITY_DEPOSIT_RETURN_HIST'
GO
ALTER TABLE [dbo].[PIMS_SECURITY_DEPOSIT_RETURN_HIST]
	DROP COLUMN [INTEREST_PAID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.BCA_OWNERSHIP_GROUP
PRINT N'Alter table dbo.BCA_OWNERSHIP_GROUP'
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Attention, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_ATTENTION'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Care Of, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_CARE_OF'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Floor, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_FLOOR'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Apartment or Suite or Unit Number, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_UNIT_NUMBER'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Further refinement of the street name to facilitate location of building (pre-directional), as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_STREET_DIRECTION_PREFIX'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Street number assigned by a local government (municipality), as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_STREET_NUMBER'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Road name assigned by a local government (municipality), as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_STREET_NAME'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Street type assigned by a local government (municipality), as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_STREET_TYPE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Further refinement of the street name to facilitate location of building (post-directional), as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_STREET_DIRECTION_SUFFIX'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'City, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_CITY'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Province or state, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_PROVINCE_STATE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Country, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_COUNTRY'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Postal or zip code, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_POSTAL_ZIP'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Additional mailing address information not fitting in any of the predefined fields, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_FREE_FORM'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Compartment, as required for mail to be sent to the owners mailing address.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_COMPARTMENT'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Delivery installation type, as required for mail to be sent to the owners mailing address.  E.g. Station, Post Office, Letter Carrier Depot, etc.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_DELIVERY_INSTALLATION_TYPE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Mode of Delivery, as required for mail to be sent to the owners mailing address.  e.g. Rural Route, Post Office Box, General Delivery, etc.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_MODE_OF_DELIVERY'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Mode of delivery value, as required for mail to be sent to the owners mailing address.  e.g. RR 876, PO Box 19, etc.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_MODE_OF_DELIVERY_VALUE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
EXEC sp_updateextendedproperty 
	@name = N'MS_Description', @value = N'Site value, as required for mail to be sent to the owners mailing address.  e.g. Site 10.' , 
	@level0type = N'Schema', @level0name = N'dbo', 
	@level1type = N'Table', @level1name = N'BCA_OWNERSHIP_GROUP', 
	@level2type = N'Column', @level2name = N'MAILING_ADDR_SITE'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_RESEARCH_FILE_PURPOSE
PRINT N'Alter table dbo.PIMS_RESEARCH_FILE_PURPOSE'
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE] DROP CONSTRAINT [RSFLPR_RESEARCH_FILE_PURPOSE_ID_DEF]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE] ALTER COLUMN [RESEARCH_FILE_PURPOSE_ID] varchar(40) NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE] ADD CONSTRAINT [RSFLPR_RESEARCH_FILE_PURPOSE_ID_DEF] DEFAULT (NEXT VALUE FOR [PIMS_RESEARCH_FILE_PURPOSE_ID_SEQ]) FOR [RESEARCH_FILE_PURPOSE_ID]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create primary key constraint dbo.RSFLPR_PK
PRINT N'Create primary key constraint dbo.RSFLPR_PK'
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE]
	ADD CONSTRAINT [RSFLPR_PK]
	PRIMARY KEY CLUSTERED ([RESEARCH_FILE_PURPOSE_ID])  
	WITH (
		DATA_COMPRESSION = NONE
	) ON [PRIMARY]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_RESEARCH_FILE_PURPOSE_HIST
PRINT N'Alter table dbo.PIMS_RESEARCH_FILE_PURPOSE_HIST'
GO
ALTER TABLE [dbo].[PIMS_RESEARCH_FILE_PURPOSE_HIST] ALTER COLUMN [RESEARCH_FILE_PURPOSE_ID] varchar(40) NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Alter table dbo.PIMS_LEASE_HIST
PRINT N'Alter table dbo.PIMS_LEASE_HIST'
GO
UPDATE [dbo].[PIMS_LEASE_HIST] SET [HAS_PHYSICAL_FILE] = (CONVERT([bit],(0))) WHERE [HAS_PHYSICAL_FILE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE_HIST] ALTER COLUMN [HAS_PHYSICAL_FILE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
--ALTER TABLE [dbo].[PIMS_LEASE_HIST] ADD CONSTRAINT [LEASE_HAS_PHYSICAL_FILE_DEF] DEFAULT (CONVERT([bit],(0))) FOR [HAS_PHYSICAL_FILE]
--GO
--IF @@ERROR <> 0 SET NOEXEC ON
--GO
UPDATE [dbo].[PIMS_LEASE_HIST] SET [HAS_DIGITAL_FILE] = (CONVERT([bit],(0))) WHERE [HAS_DIGITAL_FILE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE_HIST] ALTER COLUMN [HAS_DIGITAL_FILE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
--ALTER TABLE [dbo].[PIMS_LEASE_HIST] ADD CONSTRAINT LEASE_HAS_DIGITAL_FILE_DEF  DEFAULT (CONVERT([bit],(0))) FOR [HAS_DIGITAL_FILE]
--GO
--IF @@ERROR <> 0 SET NOEXEC ON
--GO
UPDATE [dbo].[PIMS_LEASE_HIST] SET [HAS_PHYSICIAL_LICENSE] = (CONVERT([bit],(0))) WHERE [HAS_PHYSICIAL_LICENSE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE_HIST] ALTER COLUMN [HAS_PHYSICIAL_LICENSE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
--ALTER TABLE [dbo].[PIMS_LEASE_HIST] ADD CONSTRAINT LEASE_HAS_PHYSICIAL_LICENSE_DEF  DEFAULT (CONVERT([bit],(0))) FOR [HAS_PHYSICIAL_LICENSE]
--GO
--IF @@ERROR <> 0 SET NOEXEC ON
--GO
UPDATE [dbo].[PIMS_LEASE_HIST] SET [HAS_DIGITAL_LICENSE] = (CONVERT([bit],(0))) WHERE [HAS_DIGITAL_LICENSE] IS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[PIMS_LEASE_HIST] ALTER COLUMN [HAS_DIGITAL_LICENSE] bit NOT NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
--ALTER TABLE [dbo].[PIMS_LEASE_HIST] ADD CONSTRAINT LEASE_HAS_DIGITAL_LICENSE_DEF  DEFAULT (CONVERT([bit],(0))) FOR [HAS_DIGITAL_LICENSE]
--GO
--IF @@ERROR <> 0 SET NOEXEC ON
--GO

-- Create trigger dbo.PIMS_TENANT_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_TENANT_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_TENANT_A_S_IUD_TR] ON PIMS_LEASE_TENANT FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_LEASE_TENANT_HIST set END_DATE_HIST = @curr_date where LEASE_TENANT_ID in (select LEASE_TENANT_ID from deleted) and END_DATE_HIST is null;
  
  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_LEASE_TENANT_HIST ([LEASE_TENANT_ID], [LEASE_ID], [PERSON_ID], [ORGANIZATION_ID], [LESSOR_TYPE_CODE], [NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _LEASE_TENANT_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [LEASE_TENANT_ID], [LEASE_ID], [PERSON_ID], [ORGANIZATION_ID], [LESSOR_TYPE_CODE], [NOTE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_LEASE_TENANT_H_ID_SEQ]) as [_LEASE_TENANT_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_TENANT_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_TENANT_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_TENANT_I_S_U_TR] ON PIMS_LEASE_TENANT INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.LEASE_TENANT_ID = deleted.LEASE_TENANT_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_LEASE_TENANT
    set "LEASE_TENANT_ID" = inserted."LEASE_TENANT_ID",
      "LEASE_ID" = inserted."LEASE_ID",
      "PERSON_ID" = inserted."PERSON_ID",
      "ORGANIZATION_ID" = inserted."ORGANIZATION_ID",
      "LESSOR_TYPE_CODE" = inserted."LESSOR_TYPE_CODE",
      "NOTE" = inserted."NOTE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_LEASE_TENANT
    inner join inserted
    on (PIMS_LEASE_TENANT.LEASE_TENANT_ID = inserted.LEASE_TENANT_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_TENANT_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_TENANT_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_TENANT_I_S_I_TR] ON PIMS_LEASE_TENANT INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted) 
    RETURN;

  
  insert into PIMS_LEASE_TENANT ("LEASE_TENANT_ID",
      "LEASE_ID",
      "PERSON_ID",
      "ORGANIZATION_ID",
      "LESSOR_TYPE_CODE",
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
    select "LEASE_TENANT_ID",
      "LEASE_ID",
      "PERSON_ID",
      "ORGANIZATION_ID",
      "LESSOR_TYPE_CODE",
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

-- Create trigger dbo.PIMS_SDRTRN_A_S_IUD_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_A_S_IUD_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_A_S_IUD_TR] ON PIMS_SECURITY_DEPOSIT_RETURN FOR INSERT, UPDATE, DELETE AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @curr_date datetime;
SET @curr_date = getutcdate();
  IF NOT EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- historical
  IF EXISTS(SELECT * FROM deleted)
    update PIMS_SECURITY_DEPOSIT_RETURN_HIST set END_DATE_HIST = @curr_date where SECURITY_DEPOSIT_RETURN_ID in (select SECURITY_DEPOSIT_RETURN_ID from deleted) and END_DATE_HIST is null;
  
  IF EXISTS(SELECT * FROM inserted)
    insert into PIMS_SECURITY_DEPOSIT_RETURN_HIST ([SECURITY_DEPOSIT_RETURN_ID], [SECURITY_DEPOSIT_ID], [TERMINATION_DATE], [CLAIMS_AGAINST], [RETURN_AMOUNT], [RETURN_DATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], _SECURITY_DEPOSIT_RETURN_HIST_ID, END_DATE_HIST, EFFECTIVE_DATE_HIST)
      select [SECURITY_DEPOSIT_RETURN_ID], [SECURITY_DEPOSIT_ID], [TERMINATION_DATE], [CLAIMS_AGAINST], [RETURN_AMOUNT], [RETURN_DATE], [CONCURRENCY_CONTROL_NUMBER], [APP_CREATE_TIMESTAMP], [APP_CREATE_USERID], [APP_CREATE_USER_GUID], [APP_CREATE_USER_DIRECTORY], [APP_LAST_UPDATE_TIMESTAMP], [APP_LAST_UPDATE_USERID], [APP_LAST_UPDATE_USER_GUID], [APP_LAST_UPDATE_USER_DIRECTORY], [DB_CREATE_TIMESTAMP], [DB_CREATE_USERID], [DB_LAST_UPDATE_TIMESTAMP], [DB_LAST_UPDATE_USERID], (next value for [dbo].[PIMS_SECURITY_DEPOSIT_RETURN_H_ID_SEQ]) as [_SECURITY_DEPOSIT_RETURN_HIST_ID], null as [END_DATE_HIST], @curr_date as [EFFECTIVE_DATE_HIST] from inserted;

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SDRTRN_I_S_U_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_I_S_U_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_I_S_U_TR] ON PIMS_SECURITY_DEPOSIT_RETURN INSTEAD OF UPDATE AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM deleted) 
    RETURN;

  -- validate concurrency control
  if exists (select 1 from inserted, deleted where inserted.CONCURRENCY_CONTROL_NUMBER != deleted.CONCURRENCY_CONTROL_NUMBER+1 AND inserted.SECURITY_DEPOSIT_RETURN_ID = deleted.SECURITY_DEPOSIT_RETURN_ID)
    raiserror('CONCURRENCY FAILURE.',16,1)


  -- update statement
  update PIMS_SECURITY_DEPOSIT_RETURN
    set "SECURITY_DEPOSIT_RETURN_ID" = inserted."SECURITY_DEPOSIT_RETURN_ID",
      "SECURITY_DEPOSIT_ID" = inserted."SECURITY_DEPOSIT_ID",
      "TERMINATION_DATE" = inserted."TERMINATION_DATE",
      "CLAIMS_AGAINST" = inserted."CLAIMS_AGAINST",
      "RETURN_AMOUNT" = inserted."RETURN_AMOUNT",
      "RETURN_DATE" = inserted."RETURN_DATE",
      "CONCURRENCY_CONTROL_NUMBER" = inserted."CONCURRENCY_CONTROL_NUMBER",
      "APP_LAST_UPDATE_TIMESTAMP" = inserted."APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID" = inserted."APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID" = inserted."APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY" = inserted."APP_LAST_UPDATE_USER_DIRECTORY"
    , DB_LAST_UPDATE_TIMESTAMP = getutcdate()
    , DB_LAST_UPDATE_USERID = user_name()
    from PIMS_SECURITY_DEPOSIT_RETURN
    inner join inserted
    on (PIMS_SECURITY_DEPOSIT_RETURN.SECURITY_DEPOSIT_RETURN_ID = inserted.SECURITY_DEPOSIT_RETURN_ID);

END TRY
BEGIN CATCH
   IF @@trancount > 0 ROLLBACK TRANSACTION
   EXEC pims_error_handling
END CATCH;

GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Create trigger dbo.PIMS_SDRTRN_I_S_I_TR
PRINT N'Create trigger dbo.PIMS_SDRTRN_I_S_I_TR'
GO
CREATE TRIGGER [dbo].[PIMS_SDRTRN_I_S_I_TR] ON PIMS_SECURITY_DEPOSIT_RETURN INSTEAD OF INSERT AS
SET NOCOUNT ON
BEGIN TRY
  IF NOT EXISTS(SELECT * FROM inserted) 
    RETURN;

  
  insert into PIMS_SECURITY_DEPOSIT_RETURN ("SECURITY_DEPOSIT_RETURN_ID",
      "SECURITY_DEPOSIT_ID",
      "TERMINATION_DATE",
      "CLAIMS_AGAINST",
      "RETURN_AMOUNT",
      "RETURN_DATE",
      "CONCURRENCY_CONTROL_NUMBER",
      "APP_CREATE_TIMESTAMP",
      "APP_CREATE_USERID",
      "APP_CREATE_USER_GUID",
      "APP_CREATE_USER_DIRECTORY",
      "APP_LAST_UPDATE_TIMESTAMP",
      "APP_LAST_UPDATE_USERID",
      "APP_LAST_UPDATE_USER_GUID",
      "APP_LAST_UPDATE_USER_DIRECTORY")
    select "SECURITY_DEPOSIT_RETURN_ID",
      "SECURITY_DEPOSIT_ID",
      "TERMINATION_DATE",
      "CLAIMS_AGAINST",
      "RETURN_AMOUNT",
      "RETURN_DATE",
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
