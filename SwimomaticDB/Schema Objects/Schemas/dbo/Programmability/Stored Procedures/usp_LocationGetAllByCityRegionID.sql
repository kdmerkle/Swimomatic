
if exists (select * from sysobjects where type = 'P' and name = 'usp_LocationGetAllByCityRegionID')
	begin
	    drop procedure dbo.usp_LocationGetAllByCityRegionID
	end
go

create procedure dbo.usp_LocationGetAllByCityRegionID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_LocationGetAllByCityRegionID
 
 Description:		Selects a Location record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/2/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @City varchar(250)
,@RegionID int

as
	select
		 l.[Address]
		,l.City
		,l.CreatedByUserID
		,l.CreatedDate
		,l.Latitude
		,l.LocationID
		,l.Longitude
		,l.ModifiedByUserID
		,l.ModifiedDate
		,l.Name
		,l.PostalCode
		,l.RegionID
		,COUNT(p.PoolID) as PoolCount
		,r.RegionAbbrev
	from dbo.Location l
	inner join dbo.Region r on r.RegionID = l.RegionID
	left outer join dbo.[Pool] p on p.LocationID = l.LocationID
	where City = @City
	and	r.RegionID = @RegionID
	group by l.[Address]
		,l.City
		,l.CreatedByUserID
		,l.CreatedDate
		,l.Latitude
		,l.LocationID
		,l.Longitude
		,l.ModifiedByUserID
		,l.ModifiedDate
		,l.Name
		,l.PostalCode
		,l.RegionID
		,r.RegionAbbrev

go

