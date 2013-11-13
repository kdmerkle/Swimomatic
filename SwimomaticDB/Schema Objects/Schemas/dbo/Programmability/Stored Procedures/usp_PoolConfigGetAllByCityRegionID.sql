
if exists (select * from sysobjects where type = 'P' and name = 'usp_PoolConfigGetAllByCityRegionID')
	begin
	    drop procedure dbo.usp_PoolConfigGetAllByCityRegionID
	end
go

create procedure dbo.usp_PoolConfigGetAllByCityRegionID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_PoolConfigGetAllByCityRegionID
 
 Description:		Selects a PoolConfig record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 2/21/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the PoolConfig Entity
 The Entity expects the following properties to be returned:
   LaneCount < System.Int32 >
   LaneLength < System.Double >
   PoolConfigID < System.Int32 >
   UOMID < System.Int32 >
   Description < System.String >
   PoolID < System.Int32 >
   CreatedByUserID < System.Int32 >
   CreatedDate < System.DateTime >
   ModifiedByUserID < System.Int32 >
   ModifiedDate < System.DateTime >
 ********************************************************************************************************/
 @City varchar(50)
,@RegionID int

as
	select
		 pc.LaneCount
		,pc.LaneLength
		,pc.PoolConfigID
		,pc.UOMID
		,pc.[Description]
		,pc.PoolID
		,pc.CreatedByUserID
		,pc.CreatedDate
		,pc.ModifiedByUserID
		,pc.ModifiedDate
		,l.[Address]
		,l.City
		,l.Latitude
		,l.LocationID
		,l.Longitude
		,l.Name as LocationName
		,l.PostalCode
		,l.RegionID
		,r.RegionAbbrev
	from dbo.PoolConfig pc
	inner join dbo.[Pool] p on p.PoolID = pc.PoolID
	inner join dbo.Location l on l.LocationID = p.LocationID
	inner join dbo.Region r on r.RegionID = l.RegionID
	where l.RegionID = @RegionID
	and l.City = @City
		
go
