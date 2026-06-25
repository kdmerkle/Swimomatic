CREATE OR ALTER PROCEDURE swim.spHeatSheetGetByMeet
    @SwimMeetId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT HeatSheetId, TenantId, SwimMeetId
    FROM swim.HeatSheet
    WHERE SwimMeetId = @SwimMeetId;
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSheetSave
    @HeatSheetId INT OUTPUT,
    @TenantId    INT,
    @SwimMeetId  INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @HeatSheetId = 0
    BEGIN
        INSERT INTO swim.HeatSheet (TenantId, SwimMeetId)
        VALUES (@TenantId, @SwimMeetId);
        SET @HeatSheetId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE swim.HeatSheet
        SET SwimMeetId = @SwimMeetId
        WHERE HeatSheetId = @HeatSheetId;
    END
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSheetEventGetByHeatSheet
    @HeatSheetId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT HeatSheetEventId, TenantId, HeatSheetId, SwimEventId, AgeClassId, Gender, Sequence, IsScratch
    FROM swim.HeatSheetEvent
    WHERE HeatSheetId = @HeatSheetId
    ORDER BY Sequence;
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSheetEventSave
    @HeatSheetEventId INT OUTPUT,
    @TenantId         INT,
    @HeatSheetId      INT,
    @SwimEventId      INT,
    @AgeClassId       INT,
    @Gender           NCHAR(1),
    @Sequence         INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @HeatSheetEventId = 0
    BEGIN
        INSERT INTO swim.HeatSheetEvent (TenantId, HeatSheetId, SwimEventId, AgeClassId, Gender, Sequence)
        VALUES (@TenantId, @HeatSheetId, @SwimEventId, @AgeClassId, @Gender, @Sequence);
        SET @HeatSheetEventId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE swim.HeatSheetEvent
        SET SwimEventId = @SwimEventId, AgeClassId = @AgeClassId, Gender = @Gender, Sequence = @Sequence
        WHERE HeatSheetEventId = @HeatSheetEventId;
    END
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatGetByEvent
    @HeatSheetEventId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.HeatId, h.TenantId, h.HeatSheetEventId, h.HeatNumber, h.LaneCount,
           hs.HeatSwimmerId, hs.AthleteId, hs.LaneNumber, hs.SeedTime
    FROM swim.Heat h
    LEFT JOIN swim.HeatSwimmer hs ON hs.HeatId = h.HeatId
    WHERE h.HeatSheetEventId = @HeatSheetEventId
    ORDER BY h.HeatNumber, hs.LaneNumber;
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSwimmerGetBySeedTime
    @HeatSheetEventId INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Returns profile seed times for swimmers in this event, fastest first
    SELECT hs.HeatSwimmerId, hs.TenantId, hs.HeatId, hs.AthleteId, hs.LaneNumber, hs.SeedTime
    FROM swim.HeatSwimmer hs
    INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
    WHERE h.HeatSheetEventId = @HeatSheetEventId
    ORDER BY hs.SeedTime DESC;
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSave
    @HeatId           INT OUTPUT,
    @TenantId         INT,
    @HeatSheetEventId INT,
    @HeatNumber       INT,
    @LaneCount        INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @HeatId = 0
    BEGIN
        INSERT INTO swim.Heat (TenantId, HeatSheetEventId, HeatNumber, LaneCount)
        VALUES (@TenantId, @HeatSheetEventId, @HeatNumber, @LaneCount);
        SET @HeatId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE swim.Heat
        SET HeatNumber = @HeatNumber, LaneCount = @LaneCount
        WHERE HeatId = @HeatId;
    END
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSwimmerSave
    @HeatSwimmerId INT OUTPUT,
    @TenantId      INT,
    @HeatId        INT,
    @AthleteId     INT,
    @LaneNumber    INT,
    @SeedTime      DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @HeatSwimmerId = 0
    BEGIN
        INSERT INTO swim.HeatSwimmer (TenantId, HeatId, AthleteId, LaneNumber, SeedTime)
        VALUES (@TenantId, @HeatId, @AthleteId, @LaneNumber, @SeedTime);
        SET @HeatSwimmerId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE swim.HeatSwimmer
        SET HeatId = @HeatId, LaneNumber = @LaneNumber, SeedTime = @SeedTime
        WHERE HeatSwimmerId = @HeatSwimmerId;
    END
END
GO

CREATE OR ALTER PROCEDURE swim.spHeatSheetEventClearSwimmers
    @HeatSheetEventId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE hs FROM swim.HeatSwimmer hs
    INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
    WHERE h.HeatSheetEventId = @HeatSheetEventId;
    DELETE FROM swim.Heat WHERE HeatSheetEventId = @HeatSheetEventId;
END
GO
