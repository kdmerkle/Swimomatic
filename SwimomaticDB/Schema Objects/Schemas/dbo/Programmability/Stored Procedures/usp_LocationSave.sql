if exists (select * from sysobjects where type = 'P' and name = 'usp_LocationSave')
	begin
	    drop procedure dbo.usp_LocationSave
	end
go

create procedure dbo.usp_LocationSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_LocationSave

 Description:		Saves an Location record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/1/2010	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
	 @Address varchar(50)
	,@City varchar(50)
	,@CreatedByUserID int
	,@CreatedDate datetime
	,@Latitude decimal(10,6)
	,@LocationID int
	,@Longitude decimal(10,6)
	,@ModifiedByUserID int
	,@ModifiedDate datetime
	,@Name varchar(50)
	,@PostalCode varchar(50)
	,@RegionID int

as
	if @ModifiedByUserID = 0 set @ModifiedByUserID = null
	
	declare @InsertedPrimaryKeyTable table (LocationID int)
		
	if exists (select 1 from dbo.Location where LocationID = @LocationID)
		begin
			
			update dbo.Location
			set
				 [Address] = @Address
				,City = @City
				,CreatedByUserID = @CreatedByUserID
				,CreatedDate = @CreatedDate
				,Latitude = @Latitude
				,Longitude = @Longitude
				,ModifiedByUserID = @ModifiedByUserID
				,ModifiedDate = @ModifiedDate
				,Name = @Name
				,PostalCode = @PostalCode
				,RegionID = @RegionID
			output inserted.LocationID into @InsertedPrimaryKeyTable
			where LocationID = @LocationID
		end
	else
		begin
			insert into dbo.Location(
				 [Address]
				,City
				,CreatedByUserID
				,CreatedDate
				,Latitude
				,Longitude
				,ModifiedByUserID
				,ModifiedDate
				,Name
				,PostalCode
				,RegionID
			)
			output inserted.LocationID into @InsertedPrimaryKeyTable
			values (
				 @Address
				,@City
				,@CreatedByUserID
				,@CreatedDate
				,@Latitude
				,@Longitude
				,@ModifiedByUserID
				,@ModifiedDate
				,@Name
				,@PostalCode
				,@RegionID
			)
			
		end

	select LocationID from @InsertedPrimaryKeyTable
		
go

