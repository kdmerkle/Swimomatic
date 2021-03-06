
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerGetAllAvailableByHeatID')
	begin
	    drop procedure dbo.usp_SwimmerGetAllAvailableByHeatID
	end
go

create procedure dbo.usp_SwimmerGetAllAvailableByHeatID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerGetAllAvailableByHeatID
 
 Description:		Selects all Swimmers that are available for the HeatSheetEvent but are not yet in a Heat
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 8/5/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @HeatID int

as

	declare @IsMale bit
			,@AgeClassID int
			,@AgeClassRuleID int
			,@MeetStartDate datetime
			,@SeasonStartDate datetime
			,@SeasonEndDate datetime
			,@AgeClassRuleCustomDate datetime
			,@HeatSheetEventID int
				
	--get a record containing values used as parameters for AgeClass
	select top 1
			 @IsMale = ac.IsMale
			,@AgeClassID = se.AgeClassID
			,@AgeClassRuleID = ts.AgeClassRuleID
			,@MeetStartDate = sm.StartDate
			,@SeasonStartDate = s.StartDate
			,@SeasonEndDate = s.EndDate
			,@AgeClassRuleCustomDate = s.AgeClassRuleCustomDate
			,@HeatSheetEventID  = hse.HeatSheetEventID
	from dbo.Heat h
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
	inner join dbo.HeatSheet hs on hs.HeatSheetID = hse.HeatSheetID
	inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
	inner join dbo.AgeClass ac on ac.AgeClassID = se.AgeClassID
	inner join dbo.SwimMeetTeam smt on smt.SwimMeetID = hs.SwimMeetID	
	inner join dbo.SwimMeet sm on sm.SwimMeetID = hs.SwimMeetID	
	inner join dbo.TeamSeason ts on ts.TeamSeasonID = smt.TeamSeasonID	
	inner join dbo.Season s on s.SeasonID = ts.SeasonID		
	where h.HeatID = @HeatID
		
;	with cteSwimMeetTeams as (
		select smt.TeamSeasonID
		from dbo.SwimMeetTeam smt
		inner join dbo.HeatSheet hs on hs.SwimMeetID = smt.SwimMeetID
		inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hs.HeatSheetID
		inner join dbo.Heat h on h.HeatSheetEventID = hse.HeatSheetEventID
		where h.HeatID = @HeatID
)

	select
		 s.BirthDate
		,datediff(dd,s.BirthDate,@MeetStartDate)*100/36524 as Age
		,s.FirstName
		,s.LastName
		,sts.SwimmerTeamSeasonID
		,s.SwimmerID
		,s.IsMale
		,t.Abbrev
	from dbo.Swimmer s
	inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = s.SwimmerID	
	inner join dbo.TeamSeason ts on ts.TeamSeasonID = sts.TeamSeasonID
	inner join dbo.Team t on t.TeamID = ts.TeamID
	inner join dbo.Season sn on sn.SeasonID = ts.SeasonID
	inner join cteSwimMeetTeams smt on smt.TeamSeasonID = sts.TeamSeasonID
	where s.IsMale = @IsMale
	and dbo.uf_IsInAgeClass(@AgeClassID,@AgeClassRuleCustomDate,@AgeClassRuleID,s.BirthDate,@MeetStartDate,@SeasonStartDate,@SeasonEndDate) = 1
	and sts.SwimmerTeamSeasonID not in (select hs.SwimmerTeamSeasonID
										from dbo.HeatSwimmer hs 
										inner join dbo.Heat h on h.HeatID = hs.HeatID							
										where h.HeatSheetEventID = @HeatSheetEventID)
	order by t.Abbrev
			,datediff(dd,s.BirthDate,@MeetStartDate)*100/36524 desc
			,s.LastName
			,s.FirstName		
go

