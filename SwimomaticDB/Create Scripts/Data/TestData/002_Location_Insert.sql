/*
select 'insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values(''' +
Name + ''',''' + [Address] + ''',''' + City + ''',' + cast(RegionID as varchar(3)) + ',''' + PostalCode + ''',' + cast(Latitude as varchar(12)) + ',' + cast(Longitude as varchar(12)) + ',11,getdate(),null,null)' 
from dbo.Location
*/

if not exists(select 1 from dbo.Location )
begin
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Baxter Community Center','3187 Colonel Springs Way','Fort Mill',41,'29708',35.025103,-80.976770,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Mecklenburg Co. Acquatic Center','805 E Martin Luther King Jr Blvd','Charlotte',34,'28202',35.217961,-80.839763,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Huntersville Natatorium','11725 Verhoeff Dr','Huntersville',34,'28078',35.391744,-80.844848,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Tega Cay Swim Club','4420 Beach Club Ln','Tega Cay',41,'29708',35.042690,-81.006006,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Shiland Swim Club','2540 Aspen Terrace','Rock Hill',41,'29732',34.972777,-81.023175,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Rock Hill CC','600 Country Club Drive','Rock Hill',41,'29730',34.884153,-81.045542,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Billings AC','1234 West Main Street','Billings',27,'26478',45.797148,-108.523486,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Alabama Place','123 Brown Street','Birmingham',1,'65498',33.476015,-86.799403,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Karns Community Club Pool','6618 Beaver Ridge Rd','Knoxville',43,'37931',35.980107,-84.093840,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Oak Ridge Pool','123 Emory Valley Rd','Oak Ridge',43,'37830',36.015878,-84.265276,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Fox Den Country Club','321 Fox Den Drive','Knoxville',43,'37920',35.874098,-84.191022,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('Colstrip High School','642 Colstrip Road','Colstrip',27,'75421',45.914635,-106.634234,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('The Landing Swim Club','2643 Landing Pointe Dr','Clover',41, '29710',35.123349,-81.080732,11,getdate(),null,null)
	insert into dbo.Location(Name,[Address],City,RegionID,PostalCode,Latitude,Longitude,CreatedByUserID,CreatedDate,ModifiedByUserID,ModifiedDate) values('The Palisades Swim Club','13417 Grand Palisades Parkway','Charlotte',34,'28278',35.072937,-81.041132,11,getdate(),null,null)
end