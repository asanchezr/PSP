/* -----------------------------------------------------------------------------
Alter the data in the PIMS_DISPOSITION_FILE table.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
Author        Date         Comment
------------  -----------  -----------------------------------------------------
Doug Filteau  2024-May-31  Initial version.  Convert the DRAFT records to ACTIVE 
                           status.  Mark the converted records with 'PSP-8356'.
----------------------------------------------------------------------------- */

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Convert the DRAFT records to ACTIVE records
PRINT N'Convert the DRAFT records to ACTIVE records'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
UPDATE PIMS_DISPOSITION_FILE
SET    DISPOSITION_FILE_STATUS_TYPE_CODE = N'ACTIVE'
     , APP_LAST_UPDATE_USER_DIRECTORY    = N'PSP-8356'
     , CONCURRENCY_CONTROL_NUMBER        = CONCURRENCY_CONTROL_NUMBER + 1
WHERE  DISPOSITION_FILE_STATUS_TYPE_CODE = N'DRAFT'
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