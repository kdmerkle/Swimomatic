-- =============================================================================
-- V040 - Organization Stored Procedures
-- =============================================================================

-- AthleteTeamRequest table (join request from athlete to team)
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AthleteTeamRequest' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.AthleteTeamRequest (
        AthleteTeamRequestId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AthleteTeamRequest PRIMARY KEY,
        TenantId             INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Tenant  FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
        AthleteId            INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Athlete FOREIGN KEY REFERENCES dbo.Athlete(AthleteId),
        TeamId               INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Team    FOREIGN KEY REFERENCES dbo.Team(TeamId),
        Status               NVARCHAR(20) NOT NULL CONSTRAINT DF_AthleteTeamRequest_Status DEFAULT ('Pending'),
        CreatedDate          DATETIME2    NOT NULL CONSTRAINT DF_AthleteTeamRequest_Created DEFAULT (SYSUTCDATETIME())
    );
END
GO

-- TeamLeagueRequest table (join request from team to league)
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'TeamLeagueRequest' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.TeamLeagueRequest (
        TeamLeagueRequestId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TeamLeagueRequest PRIMARY KEY,
        TenantId            INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
        TeamId              INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_Team   FOREIGN KEY REFERENCES dbo.Team(TeamId),
        LeagueId            INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_League FOREIGN KEY REFERENCES dbo.League(LeagueId),
        Status              NVARCHAR(20) NOT NULL CONSTRAINT DF_TeamLeagueRequest_Status DEFAULT ('Pending'),
        CreatedDate         DATETIME2    NOT NULL CONSTRAINT DF_TeamLeagueRequest_Created DEFAULT (SYSUTCDATETIME())
    );
END
GO

-- Season stored procedures
CREATE OR ALTER PROCEDURE dbo.spSeasonGetByLeague
    @LeagueId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SeasonId, TenantId, LeagueId, Name, StartDate, EndDate
    FROM dbo.Season WHERE LeagueId = @LeagueId ORDER BY StartDate DESC;
END
GO

CREATE OR ALTER PROCEDURE dbo.spSeasonGetById
    @SeasonId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SeasonId, TenantId, LeagueId, Name, StartDate, EndDate
    FROM dbo.Season WHERE SeasonId = @SeasonId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spSeasonSave
    @SeasonId  INT OUTPUT,
    @TenantId  INT,
    @LeagueId  INT,
    @Name      NVARCHAR(200),
    @StartDate DATE,
    @EndDate   DATE
AS
BEGIN
    SET NOCOUNT ON;
    IF @SeasonId = 0
    BEGIN
        INSERT INTO dbo.Season (TenantId, LeagueId, Name, StartDate, EndDate)
        VALUES (@TenantId, @LeagueId, @Name, @StartDate, @EndDate);
        SET @SeasonId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.Season SET Name = @Name, StartDate = @StartDate, EndDate = @EndDate
        WHERE SeasonId = @SeasonId;
    END
END
GO

-- Location stored procedures
CREATE OR ALTER PROCEDURE dbo.spLocationGetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT LocationId, TenantId, Name, Address, RegionId FROM dbo.Location ORDER BY Name;
END
GO

CREATE OR ALTER PROCEDURE dbo.spLocationGetById
    @LocationId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT LocationId, TenantId, Name, Address, RegionId FROM dbo.Location WHERE LocationId = @LocationId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spLocationSave
    @LocationId INT OUTPUT,
    @TenantId   INT,
    @Name       NVARCHAR(200),
    @Address    NVARCHAR(500) = NULL,
    @RegionId   INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @LocationId = 0
    BEGIN
        INSERT INTO dbo.Location (TenantId, Name, Address, RegionId)
        VALUES (@TenantId, @Name, @Address, @RegionId);
        SET @LocationId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.Location SET Name = @Name, Address = @Address, RegionId = @RegionId
        WHERE LocationId = @LocationId;
    END
END
GO

-- Update spLeagueGetAll to include SportCode for frontend
CREATE OR ALTER PROCEDURE dbo.spLeagueGetAll
    @SportCode NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT l.LeagueId, l.TenantId, l.SportId, s.SportCode, l.Name, l.Description, l.RegionId, l.CreatedDate
    FROM dbo.League l
    INNER JOIN dbo.Sport s ON s.SportId = l.SportId
    WHERE (@SportCode IS NULL OR s.SportCode = @SportCode);
END
GO

-- Athlete join request
CREATE OR ALTER PROCEDURE dbo.spAthleteTeamRequestSave
    @AthleteTeamRequestId INT OUTPUT,
    @TenantId             INT,
    @AthleteId            INT,
    @TeamId               INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 FROM dbo.AthleteTeamRequest
        WHERE AthleteId = @AthleteId AND TeamId = @TeamId AND Status = 'Pending'
    )
    BEGIN
        INSERT INTO dbo.AthleteTeamRequest (TenantId, AthleteId, TeamId)
        VALUES (@TenantId, @AthleteId, @TeamId);
        SET @AthleteTeamRequestId = SCOPE_IDENTITY();
    END
    ELSE
        SELECT @AthleteTeamRequestId = AthleteTeamRequestId
        FROM dbo.AthleteTeamRequest
        WHERE AthleteId = @AthleteId AND TeamId = @TeamId AND Status = 'Pending';
END
GO

-- Team league request
CREATE OR ALTER PROCEDURE dbo.spTeamLeagueRequestSave
    @TeamLeagueRequestId INT OUTPUT,
    @TenantId            INT,
    @TeamId              INT,
    @LeagueId            INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 FROM dbo.TeamLeagueRequest
        WHERE TeamId = @TeamId AND LeagueId = @LeagueId AND Status = 'Pending'
    )
    BEGIN
        INSERT INTO dbo.TeamLeagueRequest (TenantId, TeamId, LeagueId)
        VALUES (@TenantId, @TeamId, @LeagueId);
        SET @TeamLeagueRequestId = SCOPE_IDENTITY();
    END
    ELSE
        SELECT @TeamLeagueRequestId = TeamLeagueRequestId
        FROM dbo.TeamLeagueRequest
        WHERE TeamId = @TeamId AND LeagueId = @LeagueId AND Status = 'Pending';
END
GO
