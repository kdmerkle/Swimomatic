-- Admin role tables for per-resource admin grants
CREATE TABLE dbo.UserSwimMeet (
    UserSwimMeetId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId       INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SystemUserId   INT NOT NULL REFERENCES dbo.SystemUser(SystemUserId),
    SwimMeetId     INT NOT NULL REFERENCES swim.SwimMeet(SwimMeetId),
    IsAdmin        BIT NOT NULL DEFAULT 0,
    CONSTRAINT UQ_UserSwimMeet UNIQUE (SystemUserId, SwimMeetId)
);

CREATE TABLE dbo.UserTeam (
    UserTeamId   INT IDENTITY(1,1) PRIMARY KEY,
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SystemUserId INT NOT NULL REFERENCES dbo.SystemUser(SystemUserId),
    TeamId       INT NOT NULL REFERENCES dbo.Team(TeamId),
    IsAdmin      BIT NOT NULL DEFAULT 0,
    CONSTRAINT UQ_UserTeam UNIQUE (SystemUserId, TeamId)
);

CREATE TABLE dbo.UserLeague (
    UserLeagueId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SystemUserId INT NOT NULL REFERENCES dbo.SystemUser(SystemUserId),
    LeagueId     INT NOT NULL REFERENCES dbo.League(LeagueId),
    IsAdmin      BIT NOT NULL DEFAULT 0,
    CONSTRAINT UQ_UserLeague UNIQUE (SystemUserId, LeagueId)
);
GO

-- Admin check stored procedures
CREATE OR ALTER PROCEDURE dbo.spUserSwimMeetIsAdmin
    @Auth0UserId NVARCHAR(200),
    @SwimMeetId  INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT CAST(ISNULL(usm.IsAdmin, 0) AS BIT)
    FROM dbo.SystemUser su
    LEFT JOIN dbo.UserSwimMeet usm ON usm.SystemUserId = su.SystemUserId
        AND usm.SwimMeetId = @SwimMeetId
    WHERE su.Auth0UserId = @Auth0UserId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spUserTeamIsAdmin
    @Auth0UserId NVARCHAR(200),
    @TeamId      INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT CAST(ISNULL(ut.IsAdmin, 0) AS BIT)
    FROM dbo.SystemUser su
    LEFT JOIN dbo.UserTeam ut ON ut.SystemUserId = su.SystemUserId AND ut.TeamId = @TeamId
    WHERE su.Auth0UserId = @Auth0UserId;
END
GO

CREATE OR ALTER PROCEDURE dbo.spUserLeagueIsAdmin
    @Auth0UserId NVARCHAR(200),
    @LeagueId    INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT CAST(ISNULL(ul.IsAdmin, 0) AS BIT)
    FROM dbo.SystemUser su
    LEFT JOIN dbo.UserLeague ul ON ul.SystemUserId = su.SystemUserId AND ul.LeagueId = @LeagueId
    WHERE su.Auth0UserId = @Auth0UserId;
END
GO
