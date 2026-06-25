-- RLS policies for swim-schema tables using dbo.fn_TenantFilter

CREATE SECURITY POLICY swim.PoolConfigPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.PoolConfig,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.PoolConfig
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.SwimEventPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimEvent,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimEvent
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.SwimProfilePolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimProfile,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimProfile
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.SwimMeetPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimMeet,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.SwimMeet
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.HeatSheetPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheet,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheet
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.HeatSheetEventPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheetEvent,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheetEvent
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.HeatSheetTeamPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheetTeam,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSheetTeam
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.HeatPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.Heat,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.Heat
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.HeatSwimmerPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSwimmer,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.HeatSwimmer
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY swim.SplitPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.Split,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON swim.Split
    WITH (STATE = ON);
GO

CREATE SECURITY POLICY dbo.ResultPolicy
    ADD FILTER PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Result,
    ADD BLOCK PREDICATE dbo.fn_TenantFilter(TenantId) ON dbo.Result
    WITH (STATE = ON);
GO
