CREATE OR ALTER PROCEDURE swim.spSwimMeetGetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT sm.SwimMeetId, sm.TenantId, sm.MeetId, m.Description, m.StartDate, m.EndDate,
           m.LocationId, m.SeasonId, sm.SwimMeetTypeId, sm.PoolConfigId
    FROM swim.SwimMeet sm
    INNER JOIN dbo.Meet m ON m.MeetId = sm.MeetId
    ORDER BY m.StartDate DESC;
END
GO

CREATE OR ALTER PROCEDURE swim.spSwimMeetGetById
    @SwimMeetId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT sm.SwimMeetId, sm.TenantId, sm.MeetId, m.Description, m.StartDate, m.EndDate,
           m.LocationId, m.SeasonId, sm.SwimMeetTypeId, sm.PoolConfigId
    FROM swim.SwimMeet sm
    INNER JOIN dbo.Meet m ON m.MeetId = sm.MeetId
    WHERE sm.SwimMeetId = @SwimMeetId;
END
GO

CREATE OR ALTER PROCEDURE swim.spSwimMeetSave
    @SwimMeetId     INT OUTPUT,
    @TenantId       INT,
    @SeasonId       INT,
    @LocationId     INT,
    @Description    NVARCHAR(200),
    @StartDate      DATE,
    @EndDate        DATE,
    @SwimMeetTypeId INT,
    @PoolConfigId   INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MeetId INT;
    IF @SwimMeetId = 0
    BEGIN
        INSERT INTO dbo.Meet (TenantId, SportId, SeasonId, LocationId, Description, StartDate, EndDate)
        SELECT @TenantId, SportId, @SeasonId, @LocationId, @Description, @StartDate, @EndDate
        FROM dbo.Sport WHERE SportCode = 'swim';
        SET @MeetId = SCOPE_IDENTITY();
        INSERT INTO swim.SwimMeet (TenantId, MeetId, SwimMeetTypeId, PoolConfigId)
        VALUES (@TenantId, @MeetId, @SwimMeetTypeId, @PoolConfigId);
        SET @SwimMeetId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SELECT @MeetId = MeetId FROM swim.SwimMeet WHERE SwimMeetId = @SwimMeetId;
        UPDATE dbo.Meet
        SET Description = @Description, StartDate = @StartDate, EndDate = @EndDate,
            LocationId = @LocationId
        WHERE MeetId = @MeetId;
        UPDATE swim.SwimMeet
        SET SwimMeetTypeId = @SwimMeetTypeId, PoolConfigId = @PoolConfigId
        WHERE SwimMeetId = @SwimMeetId;
    END
END
GO

CREATE OR ALTER PROCEDURE swim.spSwimMeetDelete
    @SwimMeetId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @HasResults BIT = 0;
    IF EXISTS (
        SELECT 1 FROM dbo.Result r
        INNER JOIN swim.HeatSwimmer hs ON hs.HeatSwimmerId = r.HeatSwimmerId
        INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
        INNER JOIN swim.HeatSheetEvent hse ON hse.HeatSheetEventId = h.HeatSheetEventId
        INNER JOIN swim.HeatSheet hss ON hss.HeatSheetId = hse.HeatSheetId
        WHERE hss.SwimMeetId = @SwimMeetId
    )
        SET @HasResults = 1;
    SELECT @HasResults AS HasResults;
END
GO
