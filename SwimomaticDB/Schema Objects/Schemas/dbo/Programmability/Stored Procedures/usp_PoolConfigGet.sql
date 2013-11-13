
if exists (select * from sysobjects where type = 'P' and name = 'usp_PoolConfigGet')
	begin
	    drop procedure dbo.usp_PoolConfigGet
	end
go

create procedure dbo.usp_PoolConfigGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_PoolConfigGet
 
 Description:		Selects a PoolConfig record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 7/18/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the PoolConfig Entity
 The Entity expects the following properties to be returned:
   LaneCount < System.Int32 >
   ActualLaneLength < System.Int32 >
   PoolConfigID < System.Int32 >
   UOMID < System.Int32 >
   NominalLaneLength < System.Int32 >
   NominalUOMID < System.Int32 >
 ********************************************************************************************************/
 @PoolConfigID int

as
select	 pc.CreatedByUserID
		,pc.CreatedDate
		,pc.[Description]
		,pc.LaneCount
		,pc.LaneLength
		,pc.ModifiedByUserID
		,pc.ModifiedDate
		,pc.PoolConfigID
		,pc.PoolID
		,pc.UOMID
		,l.[Address]
		,l.City
		,l.Latitude
		,l.LocationID
		,l.Longitude
		,l.Name as LocationName
		,l.PostalCode
		,l.RegionID
		,r.RegionAbbrev
		,u.Abbrev as UOMAbbrev
		,p.[Description] as PoolDescription
	from dbo.PoolConfig pc
	inner join dbo.[Pool] p on p.PoolID = pc.PoolID
	inner join dbo.Location l on l.LocationID = p.LocationID
	inner join dbo.Region r on r.RegionID = l.RegionID
	inner join dbo.UOM u on u.UOMID = pc.UOMID
	where pc.PoolConfigID = @PoolConfigID
		
go
