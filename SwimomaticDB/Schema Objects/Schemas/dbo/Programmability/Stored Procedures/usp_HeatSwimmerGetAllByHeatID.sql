
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSwimmerGetAllByHeatID')
	begin
	    drop procedure dbo.usp_HeatSwimmerGetAllByHeatID
	end
go

create procedure dbo.usp_HeatSwimmerGetAllByHeatID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSwimmerGetAllByHeatID
 
 Description:		Selects a HeatSwimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
@HeatID int

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
		,coalesce(r.ElapsedTime, 0) as ElapsedTime
		,coalesce(r.Split, 0) as Split
		,coalesce(r.Disqualified, 0) as Disqualified
		,coalesce(r.Points, 0) as Points
		,coalesce(r.Place, 0) as Place
		,h.HeatSheetEventID
		,coalesce(seed.ElapsedTime, 0) as SeedTime
	from dbo.HeatSwimmer hs
	left outer join dbo.Result r on r.HeatSwimmerID = hs.HeatSwimmerID
	left outer join dbo.Result seed on seed.ResultID = hs.SeedResultID
	inner join dbo.Heat h on h.HeatID = hs.HeatID
	inner join dbo.SwimmerTeamSeason sts on sts.SwimmerTeamSeasonID = hs.SwimmerTeamSeasonID
	inner join dbo.Swimmer s on s.SwimmerID = sts.SwimmerID
	inner join dbo.TeamSeason ts on ts.TeamSeasonID = sts.TeamSeasonID
	inner join dbo.Team t on t.TeamID = ts.TeamID
	where h.HeatID = @HeatID
	order by hs.LaneNumber
			,hs.Leg
	
		
go

