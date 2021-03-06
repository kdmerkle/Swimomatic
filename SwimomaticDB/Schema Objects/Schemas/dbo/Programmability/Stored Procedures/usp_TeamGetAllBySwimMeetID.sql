
if exists (select * from sysobjects where type = 'P' and name = 'usp_TeamGetAllBySwimMeetID')
	begin
	    drop procedure dbo.usp_TeamGetAllBySwimMeetID
	end
go

create procedure dbo.usp_TeamGetAllBySwimMeetID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_TeamGetAllBySwimMeetID
 
 Description:		Selects a Team record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/9/2009  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the Team Entity
 The Entity expects the following properties to be returned:
   TeamID < System.Int32 >
   TeamName < System.String >
 ********************************************************************************************************/
 @SwimMeetID int

as
	select
		 t.Abbrev
		,t.TeamID
		,t.TeamName
		,ts.TeamSeasonID
	from dbo.Team t
	inner join dbo.TeamSeason ts on ts.TeamID = t.TeamID
	inner join dbo.SwimMeetTeam smt on smt.TeamSeasonID = ts.TeamSeasonID
	where smt.SwimMeetID = @SwimMeetID
		
go

