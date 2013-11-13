
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimMeetGetAllBySystemUserIDAsSwimmer')
	begin
	    drop procedure dbo.usp_SwimMeetGetAllBySystemUserIDAsSwimmer
	end
go

create procedure dbo.usp_SwimMeetGetAllBySystemUserIDAsSwimmer
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimMeetGetAllBySystemUserIDAsSwimmer
 
 Description:		Selects a SwimMeet record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 3/15/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @SystemUserID int

as
	select
		 sm.[Description]
		,sm.LocationID
		,sm.StartDate
		,sm.SwimMeetID
		,sm.SwimMeetTypeID
		,sm.SeasonID
		,sm.EndDate
		,l.Name as LocationName
		,s.Description as SeasonDescription
		,lg.Description as LeagueDescription
		,lg.LeagueName as LeagueName
		,SIGN(count(r.ResultID)) as CanDelete
	from dbo.SwimMeet sm
	inner join dbo.SwimMeetTeam smt on smt.SwimMeetID = sm.SwimMeetID
	inner join dbo.SwimmerTeamSeason sts on sts.TeamSeasonID = smt.TeamSeasonID
	inner join dbo.UserSwimmer usw on usw.SwimmerID = sts.SwimmerID
	inner join dbo.Location l on l.LocationID = sm.LocationID
	inner join dbo.Season s on s.SeasonID = sm.SeasonID
	inner join dbo.League lg on lg.LeagueID = s.LeagueID

	left outer join dbo.HeatSheet hst on hst.SwimMeetID = sm.SwimMeetID
	left outer join dbo.HeatSheetEvent hse on hse.HeatSheetID = hst.HeatSheetID
	left outer join dbo.Heat h on h.HeatSheetEventID = hse.HeatSheetEventID
	left outer join dbo.HeatSwimmer hsw on hsw.HeatID = h.HeatID
	left outer join dbo.Result r on r.HeatSwimmerID = hsw.HeatSwimmerID

	where usw.SystemUserID = @SystemUserID

	group by 
		 sm.[Description]
		,sm.LocationID
		,sm.StartDate
		,sm.SwimMeetID
		,sm.SwimMeetTypeID
		,sm.SeasonID
		,sm.EndDate
		,l.Name
		,s.Description
		,lg.Description
		,lg.LeagueName
	order by sm.StartDate desc
		
go

