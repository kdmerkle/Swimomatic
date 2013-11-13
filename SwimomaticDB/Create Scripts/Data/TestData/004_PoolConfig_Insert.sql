/*
	select 'insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(' +
	CAST(PoolID as varchar(3)) + ',''' + [Description] + ''',' + cast(LaneLength as varchar(20)) + ',' + cast(UOMID as varchar(3)) + ',' + cast(LaneCount as varchar(3)) + ',11,''' + Convert(varchar(20),getdate(),101) + ''',null,null)'
	from dbo.PoolConfig
*/

if not exists(select 1 from dbo.PoolConfig )
begin
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(1,'Recreational Setup',25.6389,2,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(1,'Long Course',50.0000,1,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(3,'Recreational',25.0000,1,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(5,'Olympic',25.0000,1,8,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(6,'Recreational Setup',25.0000,2,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(7,'Olympic Setup',25.0000,1,6,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(8,'Olympic Setup',25.0000,2,8,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(9,'Long Course',50.0000,2,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(10,'Olympic Setup',25.0000,1,8,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(11,'Olympic Setup',25.0000,1,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(12,'Olympic Setup',25.0000,1,7,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(13,'Short Course',25.0000,2,6,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(14,'Short Course',25.0000,2,6,11,'03/29/2011',null,null)
	insert into dbo.PoolConfig(PoolID,[Description],LaneLength,UOMID,LaneCount,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(15,'Short Course',25.0000,2,6,11,'03/29/2011',null,null)
end