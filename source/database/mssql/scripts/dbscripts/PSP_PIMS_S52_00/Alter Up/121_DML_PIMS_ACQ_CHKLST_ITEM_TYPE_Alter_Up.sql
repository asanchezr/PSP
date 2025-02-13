/* -----------------------------------------------------------------------------
Alter the code values in the PIMS_ACQ_CHKLST_ITEM_TYPE table.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
Author        Date         Comment
------------  -----------  -----------------------------------------------------
Doug Filteau  2023-Jan-30  Initial version
----------------------------------------------------------------------------- */

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert the EXPROPACT code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'EXPROPACT'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 0
  BEGIN
  INSERT INTO PIMS_ACQ_CHKLST_ITEM_TYPE (ACQ_CHKLST_SECTION_TYPE_CODE, ACQ_CHKLST_ITEM_TYPE_CODE, DESCRIPTION, DISPLAY_ORDER, EFFECTIVE_DATE)
  VALUES
    (N'SCTN3AGR', N'EXPROPACT', N'Copy of Expropriation Act', 25, getutcdate());
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the ALCORDER code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'ALCORDER'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    ACQ_CHKLST_SECTION_TYPE_CODE = N'FILEMGMT'
       , DISPLAY_ORDER                = 19
       , CONCURRENCY_CONTROL_NUMBER   = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the NEWTTLACOMP code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'NEWTTLACOMP'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 20
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the BCTFANOTIF code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'BCTFANOTIF'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 21
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the AVNCDPMTNTY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'AVNCDPMTNTY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 22
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the CLAIMRELSS3 code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'CLAIMRELSS3'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 23
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the CONVEYLTR code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'CONVEYLTR'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 24
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the SGNDAGRMNT code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'SGNDAGRMNT'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 26
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the TTLCHRGS code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'TTLCHRGS'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 27
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the CURRYRASSMN code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'CURRYRASSMN'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 28
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the S3CHEQCOPY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'S3CHEQCOPY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 29
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the S3APPRCOPY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'S3APPRCOPY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 30
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the EXPROPAPPRV code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'EXPROPAPPRV'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 31
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the EXPROPFORM1 code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'EXPROPFORM1'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 32
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the EXPROPFORM5 code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'EXPROPFORM5'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 33
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the ADVPAYMENT8 code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'ADVPAYMENT8'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 34
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the VESTNOTICE code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'VESTNOTICE'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 35
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the SVCAFFADAV code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'SVCAFFADAV'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 36
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the S6CHEQCOPY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'S6CHEQCOPY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 37
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the S6APPRCOPY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'S6APPRCOPY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 38
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the CLAIMRELSS6 code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'CLAIMRELSS6'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 39
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the EASEMENTCPY code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'EASEMENTCPY'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 40
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Update the PIMSUPDTFIL code.
DECLARE @CurrCd NVARCHAR(20)
SET     @CurrCd = N'PIMSUPDTFIL'

SELECT ACQ_CHKLST_ITEM_TYPE_CODE
FROM   PIMS_ACQ_CHKLST_ITEM_TYPE
WHERE  ACQ_CHKLST_ITEM_TYPE_CODE = @CurrCd;

IF @@ROWCOUNT = 1
  BEGIN
  UPDATE PIMS_ACQ_CHKLST_ITEM_TYPE 
  SET    DISPLAY_ORDER              = 41
       , CONCURRENCY_CONTROL_NUMBER = CONCURRENCY_CONTROL_NUMBER + 1
  WHERE  ACQ_CHKLST_ITEM_TYPE_CODE  = @CurrCd;
  END
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
