CREATE OR ALTER PROCEDURE dbo.spTenantGetConfig
    @TenantId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        t.TenantKey,
        t.Name,
        STRING_AGG(s.SportCode, ',') AS EnabledSportCodes
    FROM dbo.Tenant t
    LEFT JOIN dbo.TenantSport ts ON ts.TenantId = t.TenantId
    LEFT JOIN dbo.Sport s ON s.SportId = ts.SportId AND s.IsActive = 1
    WHERE t.TenantId = @TenantId AND t.IsActive = 1
    GROUP BY t.TenantKey, t.Name;
END
GO
