
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerGetAllByTeamSeasonID')
	begin
	    drop procedure dbo.usp_SwimmerGetAllByTeamSeasonID
	end
go

create procedure dbo.usp_SwimmerGetAllByTeamSeasonID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerGetAllByTeamSeasonID
 
 Description:		Selects a Swimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 12/18/2010  Original Release - Generated by LAAF
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
 @TeamSeasonID int

as
	select
		 s.BirthDate
		,s.FirstName
		,s.LastName
		,s.SwimmerID
		,s.IsMale
		,sts.SwimmerTeamSeasonID
		,sts.TeamSeasonID
	from dbo.Swimmer s
	inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = s.SwimmerID
	where sts.TeamSeasonID = @TeamSeasonID
	order by s.LastName
			,s.FirstName
go

