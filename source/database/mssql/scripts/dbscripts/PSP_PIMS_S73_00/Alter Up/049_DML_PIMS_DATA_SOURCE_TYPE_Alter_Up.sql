/* -----------------------------------------------------------------------------
Alter the data in the PIMS_DATA_SOURCE_TYPE table.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
Author        Date         Comment
------------  -----------  -----------------------------------------------------
Doug Filteau  2024-Jan-31  Initial version
----------------------------------------------------------------------------- */

SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO

-- Insert the new data source types
INSERT INTO PIMS_DATA_SOURCE_TYPE (DATA_SOURCE_TYPE_CODE, DESCRIPTION)
VALUES
  (N'LIS_OPSS',       N'LIS / OPSS'),
  (N'LIS_PAIMS',      N'LIS / PAIMS'),
  (N'LIS_PMBC',       N'LIS / PMBC'),
  (N'OPSS_PAIMS',     N'OPSS / PAIMS'),
  (N'PAIMS_PMBC',     N'PAIMS / PMBC'),
  (N'LIS_PAIMS_PMBC', N'LIS / PAIMS / PMBC'),
  (N'LIS_OPSS_PAIMS', N'LIS / OPSS / PAIMS');
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
