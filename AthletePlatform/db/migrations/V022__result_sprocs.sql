CREATE OR ALTER PROCEDURE swim.spResultGetByEvent
    @HeatSheetEventId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT r.ResultId, r.TenantId, r.HeatSwimmerId, r.ElapsedTime, r.IsDQ, r.Score,
           r.MeasurementType, r.MeasurementValue, r.CreatedDate,
           hs.LaneNumber, hs.AthleteId, h.HeatNumber
    FROM dbo.Result r
    INNER JOIN swim.HeatSwimmer hs ON hs.HeatSwimmerId = r.HeatSwimmerId
    INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
    WHERE h.HeatSheetEventId = @HeatSheetEventId
    ORDER BY r.Score DESC, r.ElapsedTime ASC;
END
GO

CREATE OR ALTER PROCEDURE swim.spResultSave
    @ResultId        INT OUTPUT,
    @TenantId        INT,
    @HeatSwimmerId   INT,
    @ElapsedTime     DECIMAL(10,2) = NULL,
    @IsDQ            BIT = 0,
    @MeasurementType NVARCHAR(20) = 'Time'
AS
BEGIN
    SET NOCOUNT ON;
    IF @ResultId = 0
    BEGIN
        INSERT INTO dbo.Result (TenantId, HeatSwimmerId, ElapsedTime, IsDQ, MeasurementType, MeasurementValue)
        VALUES (@TenantId, @HeatSwimmerId, @ElapsedTime, @IsDQ, @MeasurementType, @ElapsedTime);
        SET @ResultId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.Result
        SET ElapsedTime = @ElapsedTime, IsDQ = @IsDQ, MeasurementType = @MeasurementType,
            MeasurementValue = @ElapsedTime
        WHERE ResultId = @ResultId;
    END
END
GO
