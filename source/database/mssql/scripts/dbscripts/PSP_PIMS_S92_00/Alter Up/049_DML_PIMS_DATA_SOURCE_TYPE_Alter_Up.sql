/* -----------------------------------------------------------------------------
Alter the data in the PIMS_DATA_SOURCE_TYPE table.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
Author        Date         Comment
------------  -----------  -----------------------------------------------------
Doug Filteau  2024-Oct-04  Initial version.
----------------------------------------------------------------------------- */

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert/update the "PAT" type
PRINT N'Insert/update the "PAT" type'
GO
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'PAT'

SELECT DATA_SOURCE_TYPE_CODE
FROM   PIMS_DATA_SOURCE_TYPE
WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
    VALUES (N'PAT', N'PAT');
ELSE
  UPDATE PIMS_DATA_SOURCE_TYPE
  SET    IS_DISABLED                = 0
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert/update the "TAP" type
PRINT N'Insert/update the "TAP" type'
GO
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'TAP'

SELECT DATA_SOURCE_TYPE_CODE
FROM   PIMS_DATA_SOURCE_TYPE
WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
    VALUES (N'TAP', N'TAP');
ELSE
  UPDATE PIMS_DATA_SOURCE_TYPE
  SET    IS_DISABLED                = 0
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert/update the "SHAREPOINT" type
PRINT N'Insert/update the "SHAREPOINT" type'
GO
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'SHAREPOINT'

SELECT DATA_SOURCE_TYPE_CODE
FROM   PIMS_DATA_SOURCE_TYPE
WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
    VALUES (N'SHAREPOINT', N'SharePoint');
ELSE
  UPDATE PIMS_DATA_SOURCE_TYPE
  SET    IS_DISABLED                = 0
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert/update the "BIP" type
PRINT N'Insert/update the "BIP" type'
GO
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'BIP'

SELECT DATA_SOURCE_TYPE_CODE
FROM   PIMS_DATA_SOURCE_TYPE
WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
    VALUES (N'BIP', N'BIP');
ELSE
  UPDATE PIMS_DATA_SOURCE_TYPE
  SET    IS_DISABLED                = 0
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert/update the "GWP" type
PRINT N'Insert/update the "GWP" type'
GO
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'GWP'

SELECT DATA_SOURCE_TYPE_CODE
FROM   PIMS_DATA_SOURCE_TYPE
WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
    VALUES (N'GWP', N'GWP');
ELSE
  UPDATE PIMS_DATA_SOURCE_TYPE
  SET    IS_DISABLED                = 0
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  DATA_SOURCE_TYPE_CODE = @CurrCd;
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- --------------------------------------------------------------
-- Update the display order.
-- --------------------------------------------------------------
UPDATE tbl
SET    tbl.DISPLAY_ORDER              = seq.ROW_NUM
     , tbl.CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
FROM   PIMS_DATA_SOURCE_TYPE tbl JOIN
       (SELECT DATA_SOURCE_TYPE_CODE
             , ROW_NUMBER() OVER (ORDER BY DESCRIPTION) AS ROW_NUM
        FROM   PIMS_DATA_SOURCE_TYPE) seq  ON seq.DATA_SOURCE_TYPE_CODE = tbl.DATA_SOURCE_TYPE_CODE
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
