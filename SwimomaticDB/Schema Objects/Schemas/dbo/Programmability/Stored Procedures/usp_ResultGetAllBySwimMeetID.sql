
if exists (select * from sysobjects where type = 'P' and name = 'usp_ResultGetAllBySwimMeetID')
	begin
	    drop procedure dbo.usp_ResultGetAllBySwimMeetID
	end
go

create procedure dbo.usp_ResultGetAllBySwimMeetID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ResultGetAllBySwimMeetID
 
 Description:		Selects a Result record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/22/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @SwimMeetID int

as
	select
		 r.AgeClassID
		,r.CreatedByUserID
		,r.CreatedDate
		,r.Disqualified
		,r.Distance
		,r.ElapsedTime
		,r.EventDate
		,r.HeatSwimmerID
		,r.IsCertified
		,r.IsProtested
		,r.LaneLength
		,r.ModifiedByUserID
		,r.ModifiedDate
		,r.Place
		,r.Points
		,r.ResultID
		,r.ScoringSchemeID
		,r.Split
		,r.StrokeID
		,r.SwimmerID
		,r.SwimmerTeamSeasonID
		,r.TeamSeasonID
		,r.UOMID
	from dbo.Result r
	inner join dbo.HeatSwimmer hs on hs.HeatSwimmerID = r.HeatSwimmerID
	inner join dbo.Heat h on h.HeatID = hs.HeatID
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
	inner join dbo.HeatSheet hst on hst.HeatSheetID = hse.HeatSheetID
	where hst.SwimMeetID = @SwimMeetID
		
go

