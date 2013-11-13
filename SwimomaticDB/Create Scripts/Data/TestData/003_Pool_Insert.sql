/*
select 'insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(' +
CAST(LocationID as varchar(3)) + ',''' + Description + ''',11,''' + Convert(varchar(20),getdate(),101) + ''',null,null)'
from dbo.Pool
*/

if not exists(select 1 from dbo.Pool )
begin
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(1,'Baxter Community Center Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(4,'Tega Cay Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(3,'Huntersville Natatorium',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(5,'Shiland Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(6,'Rock Hill CC Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(7,'Billings AC Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(8,'Cement Pond',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(9,'Karns Community Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(10,'Oak Ridge Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(11,'Fox Den CC Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(12,'Colstrip High Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(13,'The Landing Pool',11,'03/29/2011',null,null)
	insert into dbo.Pool(LocationID,Description,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(14,'The Palisades CC Pool',11,'03/29/2011',null,null)
end