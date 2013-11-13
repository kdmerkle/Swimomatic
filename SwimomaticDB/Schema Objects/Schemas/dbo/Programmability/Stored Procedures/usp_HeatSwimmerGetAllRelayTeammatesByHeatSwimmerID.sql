
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID')
	begin
	    drop procedure dbo.usp_HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID
	end
go

create procedure dbo.usp_HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID
 
 Description:		Selects a HeatSwimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/22/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the HeatSwimmer Entity
 The Entity expects the following properties to be returned:
   LaneNumber < System.Int32 >
   HeatID < System.Int32 >
   HeatSwimmerID < System.Int32 >
   SwimmerID < System.Int32 >
   Leg < System.Int32 >
   SeedResultID < System.Int32 >
 ********************************************************************************************************/
 @HeatSwimmerID int

as

	--Get the given Heat Swimmer
	declare	 @HeatID int
			,@LaneNumber int
			,@Leg int
	select	@HeatID = HeatID,
			@LaneNumber = LaneNumber,
			@Leg = Leg
	from dbo.HeatSwimmer
	where HeatSwimmerID = @HeatSwimmerID

	--Get the other Heat Swimmers in the same heat, and lane
	select
		 LaneNumber
		,HeatID
		,HeatSwimmerID
		,SwimmerTeamSeasonID
		,Leg
		,SeedResultID
	from dbo.HeatSwimmer
	where HeatID = @HeatID
	and LaneNumber = @LaneNumber
	and Leg <> @Leg
		
go

