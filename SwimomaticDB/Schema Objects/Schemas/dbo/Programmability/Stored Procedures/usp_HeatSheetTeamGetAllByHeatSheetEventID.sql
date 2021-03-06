
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSheetTeamGetAllByHeatSheetEventID')
	begin
	    drop procedure dbo.usp_HeatSheetTeamGetAllByHeatSheetEventID
	end
go

create procedure dbo.usp_HeatSheetTeamGetAllByHeatSheetEventID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSheetTeamGetAllByHeatSheetEventID
 
 Description:		Selects a HeatSheetTeam record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 11/28/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the HeatSheetTeam Entity
 The Entity expects the following properties to be returned:
   HeatSheetID < System.Int32 >
   HeatSheetTeamID < System.Int32 >
   Lanes < System.String >
   TeamID < System.Int32 >
 ********************************************************************************************************/
 @HeatSheetEventID int

as
	select
		 hst.HeatSheetID
		,hst.HeatSheetTeamID
		,hst.Lanes
		,hst.TeamSeasonID
	from dbo.HeatSheetTeam hst
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetID = hst.HeatSheetID
	where hse.HeatSheetEventID = @HeatSheetEventID
		
go

