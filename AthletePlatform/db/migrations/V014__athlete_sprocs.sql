CREATE OR ALTER PROCEDURE dbo.spUserAthleteSave
    @UserAthleteId INT OUTPUT,
    @TenantId      INT,
    @SystemUserId  INT,
    @AthleteId     INT,
    @IsPrimary     BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.UserAthlete (TenantId, SystemUserId, AthleteId, IsPrimary)
    VALUES (@TenantId, @SystemUserId, @AthleteId, @IsPrimary);
    SET @UserAthleteId = SCOPE_IDENTITY();
END
GO
