-- =============================================
-- Deletes all Swim Meets and related records 
-- =============================================

update HeatSwimmer set SeedResultID = null
go
delete HeatSwimmer
go
delete Heat
go
delete HeatSheetEvent
go
delete HeatSheet
go

delete UserSwimMeet
go
delete SwimMeetTeam
go
delete SwimMeet
go
delete Result
go