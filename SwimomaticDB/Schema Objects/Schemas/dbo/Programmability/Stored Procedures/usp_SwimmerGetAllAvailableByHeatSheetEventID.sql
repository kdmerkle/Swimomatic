
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerGetAllAvailableByHeatSheetEventID')
	begin
	    drop procedure dbo.usp_SwimmerGetAllAvailableByHeatSheetEventID
	end
go

create procedure dbo.usp_SwimmerGetAllAvailableByHeatSheetEventID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerGetAllAvailableByHeatSheetEventID
 
 Description:		Selects a SwimMeetTeam record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/25/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the SwimMeetTeam Entity
 The Entity expects the following properties to be returned:
   SwimMeetID < System.Int32 >
   SwimMeetTeamID < System.Int32 >
   TeamID < System.Int32 >
   IsHomeTeam < System.Boolean >
 ********************************************************************************************************/
 @HeatSheetEventID int

as
	declare @eligibleSwimmers table (
		 BirthDate datetime
		,Age int
		,FirstName varchar(50)
		,LastName varchar(50)
		,SwimmerID int
		,IsMale bit
		,Abbrev varchar(5)
		,SwimmerTeamSeasonID int)

insert into @eligibleSwimmers exec usp_SwimmerGetAllEligibleByHeatSheetEventID @HeatSheetEventID

select   es.BirthDate
		,es.Age
		,es.FirstName
		,es.LastName
		,es.SwimmerID
		,es.IsMale
		,es.Abbrev
		,es.SwimmerTeamSeasonID
from @eligibleSwimmers es
inner join dbo.SwimmerTeamSeason sts on sts.SwimmerTeamSeasonID = es.SwimmerTeamSeasonID
inner join dbo.HeatSheetTeam hst on hst.TeamSeasonID = sts.TeamSeasonID
inner join dbo.HeatSheet hs on hs.HeatSheetID = hst.HeatSheetID
inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hs.HeatSheetID
where hse.HeatSheetEventID = @HeatSheetEventID
and sts.SwimmerTeamSeasonID not in (select hs.SwimmerTeamSeasonID
									from dbo.HeatSwimmer hs
									inner join dbo.Heat h on h.HeatID = hs.HeatID							
									where h.HeatSheetEventID = @HeatSheetEventID)
group by es.Abbrev
		,es.Age
		,es.BirthDate
		,es.FirstName
		,es.IsMale
		,es.LastName
		,es.SwimmerID
		,es.SwimmerTeamSeasonID
order by es.Abbrev
		,es.Age desc
		,es.LastName
		
go

