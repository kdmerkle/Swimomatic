
if exists (select * from sysobjects where type = 'P' and name = 'usp_ScoreGetAllBySystemUserIDAsSwimmer')
	begin
	    drop procedure dbo.usp_ScoreGetAllBySystemUserIDAsSwimmer
	end
go

create procedure dbo.usp_ScoreGetAllBySystemUserIDAsSwimmer
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ScoreGetAllBySystemUserIDAsSwimmer
 
 Description:		Selects a Score record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 3/16/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @SystemUserID int

as
	select
		 vs.SwimMeetID
		,vs.HeatSheetID
		,vs.HeatSheetEventID
		,vs.HeatSwimmerID
		,vs.Sequence				
		,vs.Disqualified
		,vs.TeamID
		,vs.ElapsedTime
		,vs.Leg
		,vs.Swimmer
		,vs.LaneLength
		,vs.Abbrev
		,vs.[Description]
		,vs.SwimmerID
		,vs.IsRelay
		,vs.EventDate
		,vs.Split
		,vs.IsCertified
		,vs.IsProtested
		,vs.Place
		,vs.Points
	from dbo.vwScore vs
	inner join dbo.UserSwimmer usw on usw.SwimmerID = vs.SwimmerID
	where usw.SystemUserID = @SystemUserID
	order by HeatSheetID
			,Sequence
			,ElapsedTime
		
		
go
