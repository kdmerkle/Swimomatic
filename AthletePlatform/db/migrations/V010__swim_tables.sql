-- Stroke reference data
CREATE TABLE swim.Stroke (
    StrokeId     INT IDENTITY(1,1) PRIMARY KEY,
    Name         NVARCHAR(50) NOT NULL,
    Abbreviation NVARCHAR(10) NOT NULL
);
INSERT INTO swim.Stroke (Name, Abbreviation) VALUES
    ('Freestyle','FR'),('Backstroke','BK'),('Breaststroke','BR'),
    ('Butterfly','FL'),('Individual Medley','IM'),('Medley Relay','MR'),
    ('Freestyle Relay','FR-R');
GO

-- Pool configuration
CREATE TABLE swim.PoolConfig (
    PoolConfigId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId     INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    Name         NVARCHAR(100) NOT NULL,
    LaneCount    INT NOT NULL DEFAULT 6,
    LengthYards  INT NULL,
    LengthMeters INT NULL
);

-- Swim event definitions (50-free, 100-back, etc.)
CREATE TABLE swim.SwimEvent (
    SwimEventId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId    INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    StrokeId    INT NOT NULL REFERENCES swim.Stroke(StrokeId),
    Distance    INT NOT NULL,
    IsRelay     BIT NOT NULL DEFAULT 0,
    UOMId       INT NOT NULL REFERENCES dbo.UOM(UOMId)
);

-- Swim profile (swimmer's seed times and profile data)
CREATE TABLE swim.SwimProfile (
    SwimProfileId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId      INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    AthleteId     INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    SwimEventId   INT NOT NULL REFERENCES swim.SwimEvent(SwimEventId),
    SeedTime      DECIMAL(10,2) NULL,   -- in seconds
    CONSTRAINT UQ_SwimProfile UNIQUE (AthleteId, SwimEventId)
);

-- Swim meet (sport-specific meet detail extending dbo.Meet)
CREATE TABLE swim.SwimMeet (
    SwimMeetId     INT IDENTITY(1,1) PRIMARY KEY,
    TenantId       INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    MeetId         INT NOT NULL REFERENCES dbo.Meet(MeetId),
    SwimMeetTypeId INT NOT NULL DEFAULT 1,  -- 1=Dual/Triangle, 3=Invitational
    PoolConfigId   INT NULL REFERENCES swim.PoolConfig(PoolConfigId)
);

-- Heat sheet container
CREATE TABLE swim.HeatSheet (
    HeatSheetId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId    INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    SwimMeetId  INT NOT NULL REFERENCES swim.SwimMeet(SwimMeetId)
);

-- Heat sheet events (ordered list of events in the meet)
CREATE TABLE swim.HeatSheetEvent (
    HeatSheetEventId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatSheetId      INT NOT NULL REFERENCES swim.HeatSheet(HeatSheetId),
    SwimEventId      INT NOT NULL REFERENCES swim.SwimEvent(SwimEventId),
    AgeClassId       INT NOT NULL REFERENCES dbo.AgeClass(AgeClassId),
    Gender           NCHAR(1) NOT NULL CHECK (Gender IN ('M','F','X')),
    Sequence         INT NOT NULL,
    IsScratch        BIT NOT NULL DEFAULT 0
);

-- Heat sheet teams
CREATE TABLE swim.HeatSheetTeam (
    HeatSheetTeamId INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatSheetId     INT NOT NULL REFERENCES swim.HeatSheet(HeatSheetId),
    TeamId          INT NOT NULL REFERENCES dbo.Team(TeamId)
);

-- Individual heats within an event
CREATE TABLE swim.Heat (
    HeatId           INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatSheetEventId INT NOT NULL REFERENCES swim.HeatSheetEvent(HeatSheetEventId),
    HeatNumber       INT NOT NULL,
    LaneCount        INT NOT NULL DEFAULT 6
);

-- Swimmers seeded into heats
CREATE TABLE swim.HeatSwimmer (
    HeatSwimmerId    INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatId           INT NOT NULL REFERENCES swim.Heat(HeatId),
    AthleteId        INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    LaneNumber       INT NOT NULL,
    SeedTime         DECIMAL(10,2) NULL
);

-- Results
CREATE TABLE dbo.Result (
    ResultId         INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    HeatSwimmerId    INT NOT NULL REFERENCES swim.HeatSwimmer(HeatSwimmerId),
    ElapsedTime      DECIMAL(10,2) NULL,   -- seconds; NULL for DQ/scratch
    IsDQ             BIT NOT NULL DEFAULT 0,
    Score            DECIMAL(10,2) NULL,
    MeasurementType  NVARCHAR(20) NOT NULL DEFAULT 'Time',  -- 'Time' for swim; future: 'Distance','Height'
    MeasurementValue DECIMAL(10,4) NULL,   -- raw measurement (same as ElapsedTime for swim)
    CreatedDate      DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

-- Splits
CREATE TABLE swim.Split (
    SplitId       INT IDENTITY(1,1) PRIMARY KEY,
    TenantId      INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    ResultId      INT NOT NULL REFERENCES dbo.Result(ResultId),
    SplitNumber   INT NOT NULL,
    ElapsedTime   DECIMAL(10,2) NOT NULL
);
