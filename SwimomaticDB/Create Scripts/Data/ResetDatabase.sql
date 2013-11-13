-- =============================================
-- Deletes all Swim Meets and related records 
-- =============================================

delete HeatSheetTeam
update HeatSwimmer set SeedResultID = null
delete HeatSwimmer
delete Heat
delete HeatSheetEvent
delete HeatSheet

delete UserSwimMeet
delete SwimMeetTeam
delete SwimMeet
delete Result

delete dbo.SwimmerTeamSeason
delete dbo.SwimmerTeamRequest
delete dbo.UserSwimmer
delete dbo.Swimmer
