
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID')
	begin
	    drop procedure dbo.usp_SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID
	end
go

create procedure dbo.usp_SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID
 
 Description:		Selects a Swimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/14/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the Swimmer Entity
 The Entity expects the following properties to be returned:
   BirthDate < System.DateTime >
   FirstName < System.String >
   LastName < System.String >
   SwimmerID < System.Int32 >
   IsMale < System.Boolean >
 ********************************************************************************************************/
 @SystemUserID int
,@TeamSeasonID int

as
	select
		 s.BirthDate
		,s.FirstName
		,s.LastName
		,s.SwimmerID
		,s.IsMale
		,strq.TeamSeasonID
		,strq.SwimmerTeamRequestID
	from dbo.Swimmer s
	inner join dbo.UserSwimmer us on us.SwimmerID = s.SwimmerID
	inner join dbo.SwimmerTeamRequest strq on strq.UserSwimmerID = us.UserSwimmerID
	inner join dbo.TeamSeason ts on ts.TeamSeasonID = strq.TeamSeasonID
	inner join dbo.UserTeam ut on ut.TeamID = ts.TeamID
	where strq.TeamSeasonID = @TeamSeasonID
	and ut.SystemUserID = @SystemUserID
	and strq.IsApproved  = 0
	order by s.LastName
			,s.FirstName
		
go
