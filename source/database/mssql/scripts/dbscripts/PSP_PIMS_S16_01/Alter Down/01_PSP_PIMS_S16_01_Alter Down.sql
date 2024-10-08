-- Script generated by Aqua Data Studio Schema Synchronization for MS SQL Server 2016 on Fri Dec 03 15:43:24 PST 2021
-- Execute this script on:
-- 		PIMS_S16_01/dbo - This database/schema will be modified
-- to synchronize it with MS SQL Server 2016:
-- 		PIMS_S16_00/dbo

-- We recommend backing up the database prior to executing the script.

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_TENNTX_I_S_U_TR
PRINT N'Drop trigger dbo.PIMS_TENNTX_I_S_U_TR'
GO
DROP TRIGGER [dbo].[PIMS_TENNTX_I_S_U_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop trigger dbo.PIMS_TENNTX_I_S_I_TR
PRINT N'Drop trigger dbo.PIMS_TENNTX_I_S_I_TR'
GO
DROP TRIGGER [dbo].[PIMS_TENNTX_I_S_I_TR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop primary key constraint dbo.TENNTX_PK
--PRINT N'Drop primary key constraint dbo.TENNTX_PK'
--GO
--ALTER TABLE [dbo].[PIMS_TENANT]
--	DROP CONSTRAINT [TENNTX_PK]
--GO
--IF @@ERROR <> 0 SET NOEXEC ON
--GO

-- Drop table dbo.PIMS_TENANT
PRINT N'Drop table dbo.PIMS_TENANT'
GO
DROP TABLE [dbo].[PIMS_TENANT]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Drop sequence dbo.PIMS_TENANT_ID_SEQ
PRINT N'Drop sequence dbo.PIMS_TENANT_ID_SEQ'
GO
DROP SEQUENCE [dbo].[PIMS_TENANT_ID_SEQ]
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
