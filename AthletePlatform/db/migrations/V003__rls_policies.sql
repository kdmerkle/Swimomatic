-- =============================================================================
-- V003 - Row Level Security Policies
-- All tenant-scoped tables are protected by a shared filter function.
-- Connections set SESSION_CONTEXT(N'TenantId') before executing queries.
-- bypassRls connections leave SESSION_CONTEXT NULL to skip filtering.
-- =============================================================================

-- Shared filter function
CREATE FUNCTION dbo.fn_TenantFilter(@TenantId INT)
RETURNS TABLE
WITH SCHEMABINDING
AS RETURN
    SELECT 1 AS fn_result
    WHERE CAST(SESSION_CONTEXT(N'TenantId') AS INT) = @TenantId
       OR SESSION_CONTEXT(N'TenantId') IS NULL; -- NULL = system/bypass context
GO

-- dbo.Tenant
CREATE SECURITY POLICY dbo.TenantPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Tenant,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Tenant
    WITH (STATE = ON);
GO

-- dbo.TenantSport
CREATE SECURITY POLICY dbo.TenantSportPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TenantSport,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TenantSport
    WITH (STATE = ON);
GO

-- dbo.Region
CREATE SECURITY POLICY dbo.RegionPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Region,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Region
    WITH (STATE = ON);
GO

-- dbo.Location
CREATE SECURITY POLICY dbo.LocationPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Location,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Location
    WITH (STATE = ON);
GO

-- dbo.SystemUser
CREATE SECURITY POLICY dbo.SystemUserPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.SystemUser,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.SystemUser
    WITH (STATE = ON);
GO

-- dbo.Athlete
CREATE SECURITY POLICY dbo.AthletePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Athlete,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Athlete
    WITH (STATE = ON);
GO

-- dbo.UserAthlete
CREATE SECURITY POLICY dbo.UserAthletePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.UserAthlete,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.UserAthlete
    WITH (STATE = ON);
GO

-- dbo.AgeClass
CREATE SECURITY POLICY dbo.AgeClassPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AgeClass,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AgeClass
    WITH (STATE = ON);
GO

-- dbo.AgeClassRule
CREATE SECURITY POLICY dbo.AgeClassRulePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AgeClassRule,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AgeClassRule
    WITH (STATE = ON);
GO

-- dbo.ScoringScheme
CREATE SECURITY POLICY dbo.ScoringSchemePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.ScoringScheme,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.ScoringScheme
    WITH (STATE = ON);
GO

-- dbo.League
CREATE SECURITY POLICY dbo.LeaguePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.League,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.League
    WITH (STATE = ON);
GO

-- dbo.Season
CREATE SECURITY POLICY dbo.SeasonPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Season,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Season
    WITH (STATE = ON);
GO

-- dbo.SeasonScoringScheme
CREATE SECURITY POLICY dbo.SeasonScoringSchemePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.SeasonScoringScheme,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.SeasonScoringScheme
    WITH (STATE = ON);
GO

-- dbo.Team
CREATE SECURITY POLICY dbo.TeamPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Team,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Team
    WITH (STATE = ON);
GO

-- dbo.TeamSeason
CREATE SECURITY POLICY dbo.TeamSeasonPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TeamSeason,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TeamSeason
    WITH (STATE = ON);
GO

-- dbo.AthleteTeamSeason
CREATE SECURITY POLICY dbo.AthleteTeamSeasonPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AthleteTeamSeason,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AthleteTeamSeason
    WITH (STATE = ON);
GO

-- dbo.Meet
CREATE SECURITY POLICY dbo.MeetPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Meet,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Meet
    WITH (STATE = ON);
GO

-- dbo.TeamLeagueRequest
CREATE SECURITY POLICY dbo.TeamLeagueRequestPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TeamLeagueRequest,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.TeamLeagueRequest
    WITH (STATE = ON);
GO

-- dbo.AthleteTeamRequest
CREATE SECURITY POLICY dbo.AthleteTeamRequestPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AthleteTeamRequest,
    ADD BLOCK  PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.AthleteTeamRequest
    WITH (STATE = ON);
GO
