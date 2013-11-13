
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSheetGetAllBySwimMeetID')
	begin
	    drop procedure dbo.usp_HeatSheetGetAllBySwimMeetID
	end
go

create procedure dbo.usp_HeatSheetGetAllBySwimMeetID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSheetGetAllBySwimMeetID
 
 Description:		Selects a HeatSheet record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/26/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the HeatSheet Entity
 The Entity expects the following properties to be returned:
   HeatSheetID < System.Int32 >
   SwimMeetID < System.Int32 >
 ********************************************************************************************************/
 @SwimMeetID int

as
	select
		 HeatSheetID
		,PoolConfigID
		,SwimMeetID
	from dbo.HeatSheet
	where
		SwimMeetID = @SwimMeetID
		
go
