
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSwimmerGet')
	begin
	    drop procedure dbo.usp_HeatSwimmerGet
	end
go

create procedure dbo.usp_HeatSwimmerGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSwimmerGet
 
 Description:		Selects a HeatSwimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @HeatSwimmerID int

as
	select
		 HeatID
		,HeatSwimmerID
		,LaneNumber
		,Leg
		,SeedResultID
		,SwimmerTeamSeasonID
	from dbo.HeatSwimmer
	where
		HeatSwimmerID = @HeatSwimmerID
		
go

