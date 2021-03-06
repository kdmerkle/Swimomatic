
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimMeetGetByHeatSheetEventID')
	begin
	    drop procedure dbo.usp_SwimMeetGetByHeatSheetEventID
	end
go

create procedure dbo.usp_SwimMeetGetByHeatSheetEventID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimMeetGetByHeatSheetEventID
 
 Description:		Selects a SwimMeet record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/22/2010  Original Release - Generated by LAAF
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
   SeasonID < System.Int32 >
 ********************************************************************************************************/
 @HeatSheetEventID int

as
		select
		 sm.[Description]
		,sm.EndDate
		,sm.LocationID
		,sm.StartDate
		,sm.SwimMeetID
		,sm.SwimMeetTypeID
		,sm.SeasonID
	from dbo.SwimMeet sm
	inner join dbo.HeatSheet hs on hs.SwimMeetID = sm.SwimMeetID
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hs.HeatSheetID
	where hse.HeatSheetEventID = @HeatSheetEventID
		
go

