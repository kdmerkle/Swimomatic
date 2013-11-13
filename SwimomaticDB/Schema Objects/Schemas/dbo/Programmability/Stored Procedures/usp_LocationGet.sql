
if exists (select * from sysobjects where type = 'P' and name = 'usp_LocationGet')
	begin
	    drop procedure dbo.usp_LocationGet
	end
go

create procedure dbo.usp_LocationGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_LocationGet
 
 Description:		Selects a Location record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the Location Entity
 The Entity expects the following properties to be returned:
   Address < System.String >
   City < System.String >
   LocationID < System.Int32 >
   Name < System.String >
   PostalCode < System.String >
   Region < System.String >
 ********************************************************************************************************/
 @LocationID int

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
	from dbo.Location l
	inner join dbo.[Pool] p on p.LocationID = l.LocationID
	where l.LocationID = @LocationID
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
go

