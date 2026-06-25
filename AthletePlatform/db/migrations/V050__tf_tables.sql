-- Track & Field schema stub migrations (Phase H - stubs for WI-02 full implementation)

CREATE TABLE tf.TFMeet (
    TFMeetId   INT IDENTITY(1,1) PRIMARY KEY,
    TenantId   INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    MeetId     INT NOT NULL REFERENCES dbo.Meet(MeetId),
    CONSTRAINT UQ_TFMeet_MeetId UNIQUE (MeetId)
);
Go

CREATE TABLE tf.TFMeetConfig (
    TFMeetConfigId   INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    TFMeetId         INT NOT NULL REFERENCES tf.TFMeet(TFMeetId),
    FieldAttemptCount INT NOT NULL DEFAULT 3,
    ScoringType      NVARCHAR(20) NOT NULL DEFAULT 'Points' -- 'Points', 'Time', 'Combined'
);
go
CREATE TABLE tf.TFEvent (
    TFEventId       INT IDENTITY(1,1) PRIMARY KEY,
    TenantId        INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    Name            NVARCHAR(100) NOT NULL,
    MeasurementType NVARCHAR(20) NOT NULL DEFAULT 'Time', -- 'Time', 'Distance', 'Height'
    IsField         BIT NOT NULL DEFAULT 0
);
go
CREATE TABLE tf.TFResult (
    TFResultId       INT IDENTITY(1,1) PRIMARY KEY,
    TenantId         INT NOT NULL REFERENCES dbo.Tenant(TenantId),
    AthleteId        INT NOT NULL REFERENCES dbo.Athlete(AthleteId),
    TFEventId        INT NOT NULL REFERENCES tf.TFEvent(TFEventId),
    TFMeetId         INT NOT NULL REFERENCES tf.TFMeet(TFMeetId),
    MeasurementType  NVARCHAR(20) NOT NULL DEFAULT 'Time',
    MeasurementValue DECIMAL(12,4) NULL, -- seconds (Time), meters/cm (Distance/Height)
    IsDQ             BIT NOT NULL DEFAULT 0,
    CreatedDate      DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- RLS for T&F tables
CREATE SECURITY POLICY tf.TFMeetPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFMeet,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFMeet
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY tf.TFMeetConfigPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFMeetConfig,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFMeetConfig
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY tf.TFEventPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFEvent,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFEvent
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY tf.TFResultPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFResult,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON tf.TFResult
    WITH (STATE = ON);
GO
