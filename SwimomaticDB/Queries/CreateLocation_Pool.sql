	
declare	 @Name varchar(50) = 'Hamlet Swim & Tennis Club'
		,@Address varchar(50) = '8209 Dunsinane Ct'
		,@City varchar(50) = 'McLean'
		,@RegionID int  = 47
		,@PostalCode varchar(50) = '22102'
		,@Latitude decimal(10,6) = 38.936932
		,@Longitude decimal(10,6) = -77.229339
		,@CreatedByUserID int = 11
		
		,@LocationID int
		,@PoolID int
		
		,@PoolConfigDesc varchar(50) = 'Olympic/Recreational'
		,@PoolLength decimal(9,4) = 25.0
		,@UOMID int = 1 --M=1, Yd=2
		,@LaneCount int = 8
		
insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) 
values(@Name,@Address,@City,@RegionID,@PostalCode,@Latitude,@Longitude,@CreatedByUserID,getdate(),null,null)

set @LocationID = SCOPE_IDENTITY()

insert into [dbo].[Pool]([LocationID],[Description],[CreatedByUserID],[CreatedDate],[ModifiedByUserID],[ModifiedDate])
values (@LocationID,@Name,@CreatedByUserID,getdate(),null,null)
           
set @PoolID = SCOPE_IDENTITY()

insert into [dbo].[PoolConfig]([PoolID],[Description],[LaneLength],[UOMID],[LaneCount],[CreatedByUserID],[CreatedDate],[ModifiedByUserID],[ModifiedDate])
values(@PoolID,@PoolConfigDesc,@PoolLength,@UOMID,@LaneCount,@CreatedByUserID,getdate(),null,null)

GO



