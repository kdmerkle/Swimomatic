
if exists (select * from sysobjects where type = 'P' and name = 'usp_TeamSeasonGetAllByHeatSheetEventID')
	begin
	    drop procedure dbo.usp_TeamSeasonGetAllByHeatSheetEventID
	end
go

create procedure dbo.usp_TeamSeasonGetAllByHeatSheetEventID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_TeamSeasonGetAllByHeatSheetEventID
 
 Description:		Selects a TeamSeason record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/21/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the TeamSeason Entity
 The Entity expects the following properties to be returned:
   SeasonID < System.Int32 >
   TeamID < System.Int32 >
   TeamSeasonID < System.Int32 >
 ********************************************************************************************************/
 @HeatSheetEventID int

as
	select
		 ts.AgeClassRuleID
		,ts.LeagueID
		,ts.SeasonID
		,ts.TeamID
		,ts.TeamSeasonID
from dbo.TeamSeason ts
inner join dbo.SwimMeetTeam smt on smt.TeamSeasonID = ts.TeamSeasonID
inner join dbo.HeatSheet hs on hs.SwimMeetID = smt.SwimMeetID
inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hs.HeatSheetID
where hse.HeatSheetEventID = @HeatSheetEventID		
go

