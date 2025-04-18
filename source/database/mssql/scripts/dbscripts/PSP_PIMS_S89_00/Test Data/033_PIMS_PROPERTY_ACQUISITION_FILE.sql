INSERT INTO PIMS_PROPERTY_ACQUISITION_FILE(ACQUISITION_FILE_ID, PROPERTY_ID, PROPERTY_NAME, LOCATION, CONCURRENCY_CONTROL_NUMBER, APP_CREATE_TIMESTAMP, APP_CREATE_USERID, APP_CREATE_USER_GUID, APP_CREATE_USER_DIRECTORY, APP_LAST_UPDATE_TIMESTAMP, APP_LAST_UPDATE_USERID, APP_LAST_UPDATE_USER_GUID, APP_LAST_UPDATE_USER_DIRECTORY)
  VALUES
    ( 9, 292, N'Property Test Name 1',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 292), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (41, 345, N'Property Test Name 2',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 345), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (49,  83, N'Property Test Name 3',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  83), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (13, 340, N'Property Test Name 4',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 340), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (18,  43, N'Property Test Name 5',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  43), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 4, 242, N'Property Test Name 6',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 242), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (35,   7, N'Property Test Name 7',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =   7), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (40, 321, N'Property Test Name 8',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 321), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 1, 149, N'Property Test Name 9',  (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 149), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (14,  60, N'Property Test Name 10', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  60), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (36, 273, N'Property Test Name 11', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 273), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (42, 256, N'Property Test Name 12', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 256), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (41, 150, N'Property Test Name 13', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 150), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (41, 401, N'Property Test Name 14', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 401), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (40, 394, N'Property Test Name 15', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 394), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (18, 260, N'Property Test Name 16', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 260), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (16, 265, N'Property Test Name 17', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 265), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 2,  44, N'Property Test Name 18', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  44), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 4, 267, N'Property Test Name 19', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 267), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (49, 218, N'Property Test Name 20', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 218), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 3, 307, N'Property Test Name 21', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 307), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (10, 276, N'Property Test Name 22', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 276), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (48, 190, N'Property Test Name 23', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 190), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (21, 125, N'Property Test Name 24', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 125), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (26,  37, N'Property Test Name 25', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  37), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 9, 361, N'Property Test Name 26', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 361), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (42, 376, N'Property Test Name 27', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 376), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (42, 439, N'Property Test Name 28', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 439), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (15,  55, N'Property Test Name 29', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  55), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 6, 335, N'Property Test Name 30', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 335), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 2, 109, N'Property Test Name 31', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 109), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 2, 220, N'Property Test Name 32', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 220), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 5,  90, N'Property Test Name 33', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  90), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (23, 154, N'Property Test Name 34', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 154), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (46,  70, N'Property Test Name 35', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  70), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (15,  11, N'Property Test Name 36', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  11), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (47, 379, N'Property Test Name 37', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 379), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (50, 417, N'Property Test Name 38', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 417), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (34, 265, N'Property Test Name 39', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 265), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (39,  36, N'Property Test Name 40', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  36), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 4, 290, N'Property Test Name 41', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 290), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 2, 342, N'Property Test Name 42', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 342), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (24, 350, N'Property Test Name 43', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 350), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (17,  40, N'Property Test Name 44', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID =  40), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (10, 331, N'Property Test Name 45', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 331), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (41, 162, N'Property Test Name 46', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 162), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (42, 312, N'Property Test Name 47', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 312), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (39, 155, N'Property Test Name 48', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 155), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    (30, 129, N'Property Test Name 49', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 129), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo'),
    ( 5, 243, N'Property Test Name 50', (SELECT LOCATION FROM PIMS_PROPERTY WHERE PROPERTY_ID = 243), 1, getutcdate(), N'TestFoo', NULL, N'TestFoo', getutcdate(), N'TestFoo', NULL, N'TestFoo');
GO
