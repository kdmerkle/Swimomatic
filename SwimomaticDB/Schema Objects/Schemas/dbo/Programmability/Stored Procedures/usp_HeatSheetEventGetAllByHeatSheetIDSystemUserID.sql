
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSheetEventGetAllByHeatSheetIDSystemUserID')
	begin
	    drop procedure dbo.usp_HeatSheetEventGetAllByHeatSheetIDSystemUserID
	end
go

create procedure dbo.usp_HeatSheetEventGetAllByHeatSheetIDSystemUserID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSheetEventGetAllByHeatSheetIDSystemUserID
 
 Description:		Selects a HeatSheetEvent record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/16/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the HeatSheetEvent Entity
 The Entity expects the following properties to be returned:
   Sequence < System.Int32 >
   SwimEventID < System.Int32 >
   HeatSheetEventID < System.Int32 >
   Distance < System.Int32 >
   HeatSheetID < System.Int32 >
 ********************************************************************************************************/
 @HeatSheetID int
,@SystemUserID int

as

;
with SwimmerHeatSheetEvents(HeatSheetEventID) as(
		select hse.HeatSheetEventID
		from dbo.HeatSheetEvent hse
		inner join dbo.Heat h on h.HeatSheetEventID = hse.HeatSheetEventID
		inner join dbo.HeatSwimmer hs on hs.HeatID = h.HeatID
		inner join dbo.SwimmerTeamSeason sts on sts.SwimmerTeamSeasonID = hs.SwimmerTeamSeasonID
		inner join dbo.UserSwimmer us on us.SwimmerID = sts.SwimmerID
		where us.SystemUserID = @SystemUserID
		and hse.HeatSheetID = @HeatSheetID
		group by hse.HeatSheetEventID
)
	select
		 hse.[Sequence]
		,hse.SwimEventID
		,hse.HeatSheetEventID
		,hse.Distance
		,hse.HeatSheetID
		,ac.[Description] + ' ' + cast(hse.Distance as varchar) + ' ' + substring(u.[Description],0,LEN(u.[Description])) + ' ' + s.[Description] as [Description]
	from dbo.HeatSheetEvent hse
	inner join SwimmerHeatSheetEvents shse on shse.HeatSheetEventID = hse.HeatSheetEventID
	inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
	inner join dbo.AgeClass ac on ac.AgeClassID = se.AgeClassID
	inner join dbo.Stroke s on s.StrokeID = se.StrokeID
	inner join dbo.HeatSheet hs on hs.HeatSheetID = hse.HeatSheetID
	inner join dbo.PoolConfig pc on pc.PoolConfigID = hs.PoolConfigID
	inner join dbo.UOM u on u.UOMID = pc.UOMID
	where hse.HeatSheetID = @HeatSheetID
	order by [Sequence]
		
go
