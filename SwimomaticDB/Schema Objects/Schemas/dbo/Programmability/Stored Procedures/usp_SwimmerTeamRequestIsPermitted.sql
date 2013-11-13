
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerTeamRequestIsPermitted')
	begin
	    drop procedure dbo.usp_SwimmerTeamRequestIsPermitted
	end
go

create procedure dbo.usp_SwimmerTeamRequestIsPermitted
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerTeamRequestIsPermitted
 
 Description:		Returns 0 or 1 if a Swimmer is permitted to request a team
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 12/30/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @TeamSeasonID int
,@UserSwimmerID int

as
	declare	 @SwimmerID int
			,@SeasonID int

	--Get the Swimmer associated with the UserSwimmer
	select @SwimmerID = SwimmerID
	from dbo.UserSwimmer
	where UserSwimmerID = @UserSwimmerID

	--Get the Season associated with the Requested TeamSeasonID
	select @SeasonID = isnull(SeasonID,0)
	from dbo.TeamSeason
	where TeamSeasonID = @TeamSeasonID;

	--Get all the TeamSeasons that include @SeasonID
	with OffLimitTeamSeasons(TeamSeasonID) as (
		select TeamSeasonID
		from dbo.TeamSeason
		where SeasonID = @SeasonID
	)

	--return true if the swimmer has no SwimmerTeamSeason record already, 
	--i.e, the swimmer is permitted to join the team
	select case when COUNT(sts.TeamSeasonID) = 0 then 1 else 0 end as RequestPermitted 
	from dbo.SwimmerTeamSeason sts
	inner join OffLimitTeamSeasons olts on olts.TeamSeasonID = sts.TeamSeasonID
	where sts.SwimmerID = @SwimmerID
		
go

