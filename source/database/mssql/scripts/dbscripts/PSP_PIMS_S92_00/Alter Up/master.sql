-- File generated on 10/21/2024  2:50:21 PM.
-- Autogenerated file. Do not manually modify.

:On Error Exit
SET XACT_ABORT ON
GO

PRINT '     == DB SCRIPT START ========'
GO

BEGIN TRANSACTION
PRINT '     == DB TRANSACTION START ========'
   GO

   --Script section

   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/002_PSP_PIMS_Alter_Up.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/002_PSP_PIMS_Alter_Up.sql"
   :r $(filepath)
   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/010_DML_PIMS_STATIC_VARIABLE_VERSION.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/010_DML_PIMS_STATIC_VARIABLE_VERSION.sql"
   :r $(filepath)
   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/049_DML_PIMS_DATA_SOURCE_TYPE_Alter_Up.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/049_DML_PIMS_DATA_SOURCE_TYPE_Alter_Up.sql"
   :r $(filepath)
   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/054_DML_PIMS_LEASE_LICENSE_TYPE_Alter_Up.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/054_DML_PIMS_LEASE_LICENSE_TYPE_Alter_Up.sql"
   :r $(filepath)
   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/157_DML_PIMS_SUBFILE_INTEREST_TYPE.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/157_DML_PIMS_SUBFILE_INTEREST_TYPE.sql"
   :r $(filepath)
   PRINT '- Executing PSP_PIMS_S92_00/Alter Up/158_DML_PIMS_DOCUMENT_QUEUE_STATUS_TYPE.sql '
   :setvar filepath "PSP_PIMS_S92_00/Alter Up/158_DML_PIMS_DOCUMENT_QUEUE_STATUS_TYPE.sql"
   :r $(filepath)

   --End script section

PRINT '     == DB TRANSACTION FINISH ========'
GO

If XACT_STATE()=1
  BEGIN
  PRINT '- Success: Committing Transaction...'
  COMMIT TRANSACTION;
  END
ELSE IF XACT_STATE()=-1
  BEGIN
  PRINT '- Error: Rolling Back Transaction...'
  ROLLBACK TRANSACTION;
  END;
ELSE IF XACT_STATE()=0
  BEGIN
  PRINT '- Error: No pending transactions...'
  ROLLBACK TRANSACTION;
  END;
GO
