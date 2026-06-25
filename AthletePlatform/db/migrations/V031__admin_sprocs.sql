-- Swim meet delete (only if no results)
CREATE OR ALTER PROCEDURE swim.spSwimMeetDeleteById
    @SwimMeetId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MeetId INT;
    SELECT @MeetId = MeetId FROM swim.SwimMeet WHERE SwimMeetId = @SwimMeetId;
    DELETE FROM swim.SwimMeet WHERE SwimMeetId = @SwimMeetId;
    DELETE FROM dbo.Meet WHERE MeetId = @MeetId;
END
GO

-- Heat sheet event delete (with result check)
CREATE OR ALTER PROCEDURE swim.spHeatSheetEventDelete
    @HeatSheetEventId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @HasResults BIT = 0;
    IF EXISTS (
        SELECT 1 FROM dbo.Result r
        INNER JOIN swim.HeatSwimmer hs ON hs.HeatSwimmerId = r.HeatSwimmerId
        INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
        WHERE h.HeatSheetEventId = @HeatSheetEventId
    )
        SET @HasResults = 1;
    SELECT @HasResults AS HasResults;
    IF @HasResults = 0
    BEGIN
        -- Cascade delete: heats + swimmers first
        DELETE hs FROM swim.HeatSwimmer hs
        INNER JOIN swim.Heat h ON h.HeatId = hs.HeatId
        WHERE h.HeatSheetEventId = @HeatSheetEventId;
        DELETE FROM swim.Heat WHERE HeatSheetEventId = @HeatSheetEventId;
        DELETE FROM swim.HeatSheetEvent WHERE HeatSheetEventId = @HeatSheetEventId;
    END
END
GO

-- Resequence heat sheet events
CREATE OR ALTER PROCEDURE swim.spHeatSheetEventsResequence
    @HeatSheetEventIds NVARCHAR(MAX)  -- comma-separated ordered IDs
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @pos INT = 1;
    DECLARE @seq INT = 1;
    DECLARE @id NVARCHAR(10);
    DECLARE @len INT = LEN(@HeatSheetEventIds);
    WHILE @pos <= @len
    BEGIN
        DECLARE @comma INT = CHARINDEX(',', @HeatSheetEventIds, @pos);
        IF @comma = 0 SET @comma = @len + 1;
        SET @id = SUBSTRING(@HeatSheetEventIds, @pos, @comma - @pos);
        UPDATE swim.HeatSheetEvent SET Sequence = @seq WHERE HeatSheetEventId = CAST(@id AS INT);
        SET @seq = @seq + 1;
        SET @pos = @comma + 1;
    END
END
GO

-- Scoring scheme stored procs
CREATE OR ALTER PROCEDURE dbo.spScoringSchemeGetBySeason
    @SeasonId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ss.ScoringSchemeId, ss.Name, ss.Description, sss.SchemeType
    FROM dbo.SeasonScoringScheme sss
    INNER JOIN dbo.ScoringScheme ss ON ss.ScoringSchemeId = sss.ScoringSchemeId
    WHERE sss.SeasonId = @SeasonId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spScoringSchemeSave
    @ScoringSchemeId INT OUTPUT,
    @TenantId        INT,
    @Name            NVARCHAR(200),
    @Description     NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @ScoringSchemeId = 0
    BEGIN
        INSERT INTO dbo.ScoringScheme (TenantId, Name, Description) VALUES (@TenantId, @Name, @Description);
        SET @ScoringSchemeId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.ScoringScheme SET Name = @Name, Description = @Description WHERE ScoringSchemeId = @ScoringSchemeId;
    END
END
GO

CREATE OR ALTER PROCEDURE dbo.spSeasonScoringSchemeUpsert
    @SeasonId        INT,
    @ScoringSchemeId INT,
    @SchemeType      NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM dbo.SeasonScoringScheme WHERE SeasonId = @SeasonId AND SchemeType = @SchemeType)
        UPDATE dbo.SeasonScoringScheme SET ScoringSchemeId = @ScoringSchemeId
        WHERE SeasonId = @SeasonId AND SchemeType = @SchemeType;
    ELSE
        INSERT INTO dbo.SeasonScoringScheme (TenantId, SeasonId, ScoringSchemeId, SchemeType)
        SELECT TenantId, @SeasonId, @ScoringSchemeId, @SchemeType
        FROM dbo.Season WHERE SeasonId = @SeasonId;
END
GO

-- Approval workflow stored procs
CREATE OR ALTER PROCEDURE dbo.spTeamLeagueRequestApprove
    @TeamLeagueRequestId INT,
    @Approve             BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.TeamLeagueRequest
    SET Status = CASE WHEN @Approve = 1 THEN 'Approved' ELSE 'Rejected' END
    WHERE TeamLeagueRequestId = @TeamLeagueRequestId;
    
    -- If approved, create TeamSeason record
    IF @Approve = 1
    BEGIN
        DECLARE @TeamId INT, @LeagueId INT, @TenantId INT;
        SELECT @TeamId = TeamId, @LeagueId = LeagueId, @TenantId = TenantId
        FROM dbo.TeamLeagueRequest WHERE TeamLeagueRequestId = @TeamLeagueRequestId;
        -- Get current active season for the league
        INSERT INTO dbo.TeamSeason (TenantId, TeamId, SeasonId)
        SELECT @TenantId, @TeamId, s.SeasonId
        FROM dbo.Season s
        WHERE s.LeagueId = @LeagueId AND s.EndDate >= CAST(GETDATE() AS DATE)
            AND NOT EXISTS (SELECT 1 FROM dbo.TeamSeason ts WHERE ts.TeamId = @TeamId AND ts.SeasonId = s.SeasonId);
    END
END
GO

CREATE OR ALTER PROCEDURE dbo.spAthleteTeamRequestApprove
    @AthleteTeamRequestId INT,
    @Approve              BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.AthleteTeamRequest
    SET Status = CASE WHEN @Approve = 1 THEN 'Approved' ELSE 'Rejected' END
    WHERE AthleteTeamRequestId = @AthleteTeamRequestId;
    
    IF @Approve = 1
    BEGIN
        DECLARE @AthleteId INT, @TeamId INT, @TenantId INT;
        SELECT @AthleteId = AthleteId, @TeamId = TeamId, @TenantId = TenantId
        FROM dbo.AthleteTeamRequest WHERE AthleteTeamRequestId = @AthleteTeamRequestId;
        -- Enroll in the team's current active season
        INSERT INTO dbo.AthleteTeamSeason (TenantId, AthleteId, TeamSeasonId, StartDate, EndDate)
        SELECT @TenantId, @AthleteId, ts.TeamSeasonId, CAST(GETDATE() AS DATE), s.EndDate
        FROM dbo.TeamSeason ts
        INNER JOIN dbo.Season s ON s.SeasonId = ts.SeasonId
        WHERE ts.TeamId = @TeamId AND s.EndDate >= CAST(GETDATE() AS DATE)
            AND NOT EXISTS (
                SELECT 1 FROM dbo.AthleteTeamSeason ats
                WHERE ats.AthleteId = @AthleteId AND ats.TeamSeasonId = ts.TeamSeasonId
            );
    END
END
GO
