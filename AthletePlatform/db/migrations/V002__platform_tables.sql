-- =============================================================================
-- V002 - Platform Tables
-- =============================================================================

-- 1. dbo.Tenant
CREATE TABLE dbo.Tenant (
    TenantId    INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Tenant PRIMARY KEY,
    TenantKey   NVARCHAR(50)  NOT NULL CONSTRAINT UQ_Tenant_TenantKey UNIQUE,
    Name        NVARCHAR(200) NOT NULL,
    IsActive    BIT           NOT NULL CONSTRAINT DF_Tenant_IsActive DEFAULT (1),
    CreatedDate DATETIME2     NOT NULL CONSTRAINT DF_Tenant_CreatedDate DEFAULT (SYSUTCDATETIME())
);
GO

-- 2. dbo.Sport
CREATE TABLE dbo.Sport (
    SportId   INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Sport PRIMARY KEY,
    SportCode NVARCHAR(10)  NOT NULL CONSTRAINT UQ_Sport_SportCode UNIQUE,
    Name      NVARCHAR(100) NOT NULL,
    IsActive  BIT           NOT NULL CONSTRAINT DF_Sport_IsActive DEFAULT (1)
);
GO

INSERT INTO dbo.Sport (SportCode, Name) VALUES ('swim', 'Swimming');
INSERT INTO dbo.Sport (SportCode, Name) VALUES ('tf',   'Track & Field');
GO

-- 3. dbo.TenantSport
CREATE TABLE dbo.TenantSport (
    TenantSportId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TenantSport PRIMARY KEY,
    TenantId      INT       NOT NULL CONSTRAINT FK_TenantSport_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    SportId       INT       NOT NULL CONSTRAINT FK_TenantSport_Sport  FOREIGN KEY REFERENCES dbo.Sport(SportId),
    EnabledDate   DATETIME2 NOT NULL CONSTRAINT DF_TenantSport_EnabledDate DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT UQ_TenantSport_TenantSport UNIQUE (TenantId, SportId)
);
GO

-- 4. dbo.Region
CREATE TABLE dbo.Region (
    RegionId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Region PRIMARY KEY,
    TenantId INT           NOT NULL CONSTRAINT FK_Region_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Name     NVARCHAR(200) NOT NULL
);
GO

-- 5. dbo.Location
CREATE TABLE dbo.Location (
    LocationId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Location PRIMARY KEY,
    TenantId   INT           NOT NULL CONSTRAINT FK_Location_Tenant   FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Name       NVARCHAR(200) NOT NULL,
    Address    NVARCHAR(500) NULL,
    RegionId   INT           NULL      CONSTRAINT FK_Location_Region   FOREIGN KEY REFERENCES dbo.Region(RegionId)
);
GO

-- 6. dbo.UOM
CREATE TABLE dbo.UOM (
    UOMId        INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_UOM PRIMARY KEY,
    Name         NVARCHAR(50)  NOT NULL,
    Abbreviation NVARCHAR(10)  NOT NULL
);
GO

-- 7. dbo.SystemUser
CREATE TABLE dbo.SystemUser (
    SystemUserId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SystemUser PRIMARY KEY,
    TenantId     INT           NOT NULL CONSTRAINT FK_SystemUser_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Auth0UserId  NVARCHAR(200) NOT NULL CONSTRAINT UQ_SystemUser_Auth0UserId UNIQUE,
    Email        NVARCHAR(200) NOT NULL,
    FirstName    NVARCHAR(100) NOT NULL,
    LastName     NVARCHAR(100) NOT NULL,
    CreatedDate  DATETIME2     NOT NULL CONSTRAINT DF_SystemUser_CreatedDate DEFAULT (SYSUTCDATETIME())
);
GO

-- 8. dbo.Athlete
CREATE TABLE dbo.Athlete (
    AthleteId    INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Athlete PRIMARY KEY,
    TenantId     INT           NOT NULL CONSTRAINT FK_Athlete_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    FirstName    NVARCHAR(100) NOT NULL,
    LastName     NVARCHAR(100) NOT NULL,
    BirthDate    DATE          NOT NULL,
    Gender       NCHAR(1)      NOT NULL CONSTRAINT CK_Athlete_Gender CHECK (Gender IN (N'M', N'F', N'X')),
    CreatedDate  DATETIME2     NOT NULL CONSTRAINT DF_Athlete_CreatedDate  DEFAULT (SYSUTCDATETIME()),
    ModifiedDate DATETIME2     NOT NULL CONSTRAINT DF_Athlete_ModifiedDate DEFAULT (SYSUTCDATETIME())
);
GO

-- 9. dbo.UserAthlete
CREATE TABLE dbo.UserAthlete (
    UserAthleteId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_UserAthlete PRIMARY KEY,
    TenantId      INT NOT NULL CONSTRAINT FK_UserAthlete_Tenant      FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    SystemUserId  INT NOT NULL CONSTRAINT FK_UserAthlete_SystemUser  FOREIGN KEY REFERENCES dbo.SystemUser(SystemUserId),
    AthleteId     INT NOT NULL CONSTRAINT FK_UserAthlete_Athlete     FOREIGN KEY REFERENCES dbo.Athlete(AthleteId),
    IsPrimary     BIT NOT NULL CONSTRAINT DF_UserAthlete_IsPrimary DEFAULT (1)
);
GO

-- 10. dbo.AgeClass
CREATE TABLE dbo.AgeClass (
    AgeClassId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AgeClass PRIMARY KEY,
    TenantId   INT           NOT NULL CONSTRAINT FK_AgeClass_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Name       NVARCHAR(100) NOT NULL,
    MinAge     INT           NOT NULL,
    MaxAge     INT           NOT NULL
);
GO

-- 11. dbo.AgeClassRule
CREATE TABLE dbo.AgeClassRule (
    AgeClassRuleId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AgeClassRule PRIMARY KEY,
    TenantId       INT           NOT NULL CONSTRAINT FK_AgeClassRule_Tenant   FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    AgeClassId     INT           NOT NULL CONSTRAINT FK_AgeClassRule_AgeClass FOREIGN KEY REFERENCES dbo.AgeClass(AgeClassId),
    Description    NVARCHAR(200) NOT NULL
);
GO

-- 12. dbo.ScoringScheme
CREATE TABLE dbo.ScoringScheme (
    ScoringSchemeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ScoringScheme PRIMARY KEY,
    TenantId        INT           NOT NULL CONSTRAINT FK_ScoringScheme_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Name            NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(500) NULL
);
GO

-- 13. dbo.League
CREATE TABLE dbo.League (
    LeagueId    INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_League PRIMARY KEY,
    TenantId    INT           NOT NULL CONSTRAINT FK_League_Tenant  FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    SportId     INT           NOT NULL CONSTRAINT FK_League_Sport   FOREIGN KEY REFERENCES dbo.Sport(SportId),
    Name        NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    RegionId    INT           NULL      CONSTRAINT FK_League_Region  FOREIGN KEY REFERENCES dbo.Region(RegionId),
    CreatedDate DATETIME2     NOT NULL  CONSTRAINT DF_League_CreatedDate DEFAULT (SYSUTCDATETIME())
);
GO

-- 14. dbo.Season
CREATE TABLE dbo.Season (
    SeasonId  INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Season PRIMARY KEY,
    TenantId  INT           NOT NULL CONSTRAINT FK_Season_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    LeagueId  INT           NOT NULL CONSTRAINT FK_Season_League FOREIGN KEY REFERENCES dbo.League(LeagueId),
    Name      NVARCHAR(200) NOT NULL,
    StartDate DATE          NOT NULL,
    EndDate   DATE          NOT NULL
);
GO

-- 15. dbo.SeasonScoringScheme
CREATE TABLE dbo.SeasonScoringScheme (
    SeasonScoringSchemeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SeasonScoringScheme PRIMARY KEY,
    TenantId              INT          NOT NULL CONSTRAINT FK_SeasonScoringScheme_Tenant         FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    SeasonId              INT          NOT NULL CONSTRAINT FK_SeasonScoringScheme_Season         FOREIGN KEY REFERENCES dbo.Season(SeasonId),
    ScoringSchemeId       INT          NOT NULL CONSTRAINT FK_SeasonScoringScheme_ScoringScheme  FOREIGN KEY REFERENCES dbo.ScoringScheme(ScoringSchemeId),
    SchemeType            NVARCHAR(20) NOT NULL CONSTRAINT CK_SeasonScoringScheme_SchemeType CHECK (SchemeType IN ('Dual', 'Championship'))
);
GO

-- 16. dbo.Team
CREATE TABLE dbo.Team (
    TeamId         INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Team PRIMARY KEY,
    TenantId       INT           NOT NULL CONSTRAINT FK_Team_Tenant       FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    Name           NVARCHAR(200) NOT NULL,
    HomeLocationId INT           NULL      CONSTRAINT FK_Team_HomeLocation FOREIGN KEY REFERENCES dbo.Location(LocationId)
);
GO

-- 17. dbo.TeamSeason
CREATE TABLE dbo.TeamSeason (
    TeamSeasonId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TeamSeason PRIMARY KEY,
    TenantId     INT NOT NULL CONSTRAINT FK_TeamSeason_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    TeamId       INT NOT NULL CONSTRAINT FK_TeamSeason_Team   FOREIGN KEY REFERENCES dbo.Team(TeamId),
    SeasonId     INT NOT NULL CONSTRAINT FK_TeamSeason_Season FOREIGN KEY REFERENCES dbo.Season(SeasonId)
);
GO

-- 18. dbo.AthleteTeamSeason
CREATE TABLE dbo.AthleteTeamSeason (
    AthleteTeamSeasonId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AthleteTeamSeason PRIMARY KEY,
    TenantId            INT  NOT NULL CONSTRAINT FK_AthleteTeamSeason_Tenant     FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    AthleteId           INT  NOT NULL CONSTRAINT FK_AthleteTeamSeason_Athlete    FOREIGN KEY REFERENCES dbo.Athlete(AthleteId),
    TeamSeasonId        INT  NOT NULL CONSTRAINT FK_AthleteTeamSeason_TeamSeason FOREIGN KEY REFERENCES dbo.TeamSeason(TeamSeasonId),
    StartDate           DATE NOT NULL,
    EndDate             DATE NOT NULL
);
GO

-- 19. dbo.Meet
CREATE TABLE dbo.Meet (
    MeetId      INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Meet PRIMARY KEY,
    TenantId    INT           NOT NULL CONSTRAINT FK_Meet_Tenant   FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    SportId     INT           NOT NULL CONSTRAINT FK_Meet_Sport    FOREIGN KEY REFERENCES dbo.Sport(SportId),
    SeasonId    INT           NOT NULL CONSTRAINT FK_Meet_Season   FOREIGN KEY REFERENCES dbo.Season(SeasonId),
    LocationId  INT           NOT NULL CONSTRAINT FK_Meet_Location FOREIGN KEY REFERENCES dbo.Location(LocationId),
    Description NVARCHAR(200) NOT NULL,
    StartDate   DATE          NOT NULL,
    EndDate     DATE          NOT NULL
);
GO

-- 20. dbo.TeamLeagueRequest
CREATE TABLE dbo.TeamLeagueRequest (
    TeamLeagueRequestId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TeamLeagueRequest PRIMARY KEY,
    TenantId            INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_Tenant FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    TeamId              INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_Team   FOREIGN KEY REFERENCES dbo.Team(TeamId),
    LeagueId            INT          NOT NULL CONSTRAINT FK_TeamLeagueRequest_League FOREIGN KEY REFERENCES dbo.League(LeagueId),
    RequestDate         DATETIME2    NOT NULL CONSTRAINT DF_TeamLeagueRequest_RequestDate DEFAULT (SYSUTCDATETIME()),
    Status              NVARCHAR(20) NOT NULL CONSTRAINT DF_TeamLeagueRequest_Status DEFAULT ('Pending')
                                              CONSTRAINT CK_TeamLeagueRequest_Status CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
);
GO

-- 21. dbo.AthleteTeamRequest
CREATE TABLE dbo.AthleteTeamRequest (
    AthleteTeamRequestId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AthleteTeamRequest PRIMARY KEY,
    TenantId             INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Tenant  FOREIGN KEY REFERENCES dbo.Tenant(TenantId),
    AthleteId            INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Athlete FOREIGN KEY REFERENCES dbo.Athlete(AthleteId),
    TeamId               INT          NOT NULL CONSTRAINT FK_AthleteTeamRequest_Team    FOREIGN KEY REFERENCES dbo.Team(TeamId),
    RequestDate          DATETIME2    NOT NULL CONSTRAINT DF_AthleteTeamRequest_RequestDate DEFAULT (SYSUTCDATETIME()),
    Status               NVARCHAR(20) NOT NULL CONSTRAINT DF_AthleteTeamRequest_Status DEFAULT ('Pending')
                                               CONSTRAINT CK_AthleteTeamRequest_Status CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
);
GO

-- =============================================================================
-- Seed Data
-- =============================================================================

INSERT INTO dbo.Tenant (TenantKey, Name) VALUES ('dev-tenant', 'Development Tenant');

INSERT INTO dbo.TenantSport (TenantId, SportId)
    SELECT t.TenantId, s.SportId
    FROM dbo.Tenant t CROSS JOIN dbo.Sport s
    WHERE t.TenantKey = 'dev-tenant' AND s.SportCode = 'swim';
GO
