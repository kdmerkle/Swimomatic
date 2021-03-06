
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSwimmerGetAllByHeatIDLaneNumber')
	begin
	    drop procedure dbo.usp_HeatSwimmerGetAllByHeatIDLaneNumber
	end
go

create procedure dbo.usp_HeatSwimmerGetAllByHeatIDLaneNumber
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSwimmerGetAllByHeatIDLaneNumber
 
 Description:		Selects a HeatSwimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/5/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @HeatID int
,@LaneNumber int

as
	select
		 hs.HeatID
		,hs.HeatSwimmerID
		,hs.LaneNumber
		,hs.Leg
		,hs.SeedResultID
		,hs.SwimmerTeamSeasonID
		,s.SwimmerID
		,s.FirstName
		,s.LastName
		,s.BirthDate
		,t.Abbrev
	    ,h.HeatSheetEventID
	from dbo.HeatSwimmer hs
	inner join dbo.Heat h on h.HeatID = hs.HeatID
	inner join dbo.SwimmerTeamSeason sts on sts.SwimmerTeamSeasonID = hs.SwimmerTeamSeasonID
	inner join dbo.Swimmer s on s.SwimmerID = sts.SwimmerID
	inner join dbo.TeamSeason ts on ts.TeamSeasonID = sts.TeamSeasonID
	inner join dbo.Team t on t.TeamID = ts.TeamID
	where h.HeatID = @HeatID
	and	hs.LaneNumber = @LaneNumber
	order by hs.LaneNumber
			,hs.Leg
		
go

