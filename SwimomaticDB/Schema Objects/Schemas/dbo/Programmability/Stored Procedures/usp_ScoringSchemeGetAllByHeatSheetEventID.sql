
if exists (select * from sysobjects where type = 'P' and name = 'usp_ScoringSchemeGetAllByHeatSheetEventID')
	begin
	    drop procedure dbo.usp_ScoringSchemeGetAllByHeatSheetEventID
	end
go

create procedure dbo.usp_ScoringSchemeGetAllByHeatSheetEventID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ScoringSchemeGetAllByHeatSheetEventID
 
 Description:		Selects a ScoringScheme record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/23/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the ScoringScheme Entity
 The Entity expects the following properties to be returned:
   Description < System.String >
   IndividualPoints < System.String >
   IsUSASwimming < System.Boolean >
   LaneCount < System.Int32 >
   RelayPoints < System.String >
   ScoringEventTypeID < System.Int32 >
   ScoringSchemeID < System.Int32 >
   SwimMeetTypeID < System.Int32 >
 ********************************************************************************************************/
 @HeatSheetEventID int

as
	select
		 ss.[Description]
		,ss.IndividualPoints
		,ss.IsUSASwimming
		,ss.LaneCount
		,ss.RelayPoints
		,ss.ScoringEventTypeID
		,ss.ScoringSchemeID
		,sss.SwimMeetTypeID
	from dbo.ScoringScheme ss
	inner join dbo.SeasonScoringScheme sss on sss.ScoringSchemeID = ss.ScoringSchemeID
	inner join dbo.SwimMeet sm on sm.SeasonID = sss.SeasonID
							  and sm.SwimMeetTypeID = sss.SwimMeetTypeID
	inner join dbo.HeatSheet hs on hs.SwimMeetID = sm.SwimMeetID
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hs.HeatSheetID
	where hse.HeatSheetEventID = @HeatSheetEventID
		
go

