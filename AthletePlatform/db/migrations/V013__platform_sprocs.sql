-- Athlete stored procedures
CREATE OR ALTER PROCEDURE dbo.spAthleteGetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AthleteId, TenantId, FirstName, LastName, BirthDate, Gender, CreatedDate, ModifiedDate
    FROM dbo.Athlete
    ORDER BY LastName, FirstName;
END
GO

CREATE OR ALTER PROCEDURE dbo.spAthleteGetById
    @AthleteId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AthleteId, TenantId, FirstName, LastName, BirthDate, Gender, CreatedDate, ModifiedDate
    FROM dbo.Athlete
    WHERE AthleteId = @AthleteId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spAthleteSave
    @AthleteId  INT OUTPUT,
    @TenantId   INT,
    @FirstName  NVARCHAR(100),
    @LastName   NVARCHAR(100),
    @BirthDate  DATE,
    @Gender     NCHAR(1)
AS
BEGIN
    SET NOCOUNT ON;
    IF @AthleteId = 0
    BEGIN
        INSERT INTO dbo.Athlete (TenantId, FirstName, LastName, BirthDate, Gender)
        VALUES (@TenantId, @FirstName, @LastName, @BirthDate, @Gender);
        SET @AthleteId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.Athlete
        SET FirstName = @FirstName, LastName = @LastName, BirthDate = @BirthDate,
            Gender = @Gender, ModifiedDate = SYSUTCDATETIME()
        WHERE AthleteId = @AthleteId;
    END
END
GO

-- League stored procedures
CREATE OR ALTER PROCEDURE dbo.spLeagueGetAll
    @SportCode NVARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT l.LeagueId, l.TenantId, l.SportId, l.Name, l.Description, l.RegionId, l.CreatedDate
    FROM dbo.League l
    INNER JOIN dbo.Sport s ON s.SportId = l.SportId
    WHERE (@SportCode IS NULL OR s.SportCode = @SportCode);
END
GO

CREATE OR ALTER PROCEDURE dbo.spLeagueGetById
    @LeagueId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT LeagueId, TenantId, SportId, Name, Description, RegionId, CreatedDate
    FROM dbo.League WHERE LeagueId = @LeagueId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spLeagueSave
    @LeagueId    INT OUTPUT,
    @TenantId    INT,
    @SportId     INT,
    @Name        NVARCHAR(200),
    @Description NVARCHAR(500) = NULL,
    @RegionId    INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @LeagueId = 0
    BEGIN
        INSERT INTO dbo.League (TenantId, SportId, Name, Description, RegionId)
        VALUES (@TenantId, @SportId, @Name, @Description, @RegionId);
        SET @LeagueId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.League
        SET Name = @Name, Description = @Description, RegionId = @RegionId
        WHERE LeagueId = @LeagueId;
    END
END
GO

-- Team stored procedures
CREATE OR ALTER PROCEDURE dbo.spTeamGetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TeamId, TenantId, Name, HomeLocationId FROM dbo.Team ORDER BY Name;
END
GO

CREATE OR ALTER PROCEDURE dbo.spTeamGetById
    @TeamId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TeamId, TenantId, Name, HomeLocationId FROM dbo.Team WHERE TeamId = @TeamId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spTeamSave
    @TeamId         INT OUTPUT,
    @TenantId       INT,
    @Name           NVARCHAR(200),
    @HomeLocationId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @TeamId = 0
    BEGIN
        INSERT INTO dbo.Team (TenantId, Name, HomeLocationId) VALUES (@TenantId, @Name, @HomeLocationId);
        SET @TeamId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        UPDATE dbo.Team SET Name = @Name, HomeLocationId = @HomeLocationId WHERE TeamId = @TeamId;
    END
END
GO
