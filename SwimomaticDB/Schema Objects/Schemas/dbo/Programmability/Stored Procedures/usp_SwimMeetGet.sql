
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimMeetGet')
	begin
	    drop procedure dbo.usp_SwimMeetGet
	end
go

create procedure dbo.usp_SwimMeetGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimMeetGet
 
 Description:		Selects a SwimMeet record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 8/3/2009  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the SwimMeet Entity
 The Entity expects the following properties to be returned:
   Description < System.String >
   LocationID < System.Int32 >
   StartDate < System.DateTime >
   SwimMeetID < System.Int32 >
 ********************************************************************************************************/
 @SwimMeetID int

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
	from dbo.SwimMeet sm
	inner join dbo.UserSwimMeet usm on usm.SwimMeetID = sm.SwimMeetID
	inner join dbo.Location l on l.LocationID = sm.LocationID
	inner join dbo.Season s on s.SeasonID = sm.SeasonID
	inner join dbo.League lg on lg.LeagueID = s.LeagueID
	where sm.SwimMeetID = @SwimMeetID
		
go

