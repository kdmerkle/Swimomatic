/*
SELECT 'insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(' +
	  cast(AgeClassID as varchar(3)) + ',''' +
      [Description] + ''',' +
      cast(IsMale as char(1))+ ',' +
      cast(MinAge as varchar(2)) + ',' +
      cast(MaxAge as varchar(2)) + ')'
  FROM dbo.AgeClass
*/
if not exists(select 1 from dbo.AgeClass )
begin
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(1,'Boys 6 & Under',1,0,6)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(2,'Girls 6 & Under',0,0,6)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(3,'Boys 8 & Under',1,0,8)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(4,'Girls 8 & Under',0,0,8)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(5,'Boys 10 & Under',1,0,10)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(6,'Girls 10 & Under',0,0,10)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(7,'Boys 18 & Under',1,0,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(8,'Girls 18 & Under',0,0,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(9,'Boys 7-8',1,7,8)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(10,'Girls 7-8',0,7,8)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(11,'Boys 9-10',1,9,10)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(12,'Girls 9-10',0,9,10)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(13,'Boys 11-12',1,11,12)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(14,'Girls 11-12',0,11,12)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(15,'Boys 13-14',1,13,14)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(16,'Girls 13-14',0,13,14)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(17,'Boys 15-16',1,15,16)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(18,'Girls 15-16',0,15,16)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(19,'Boys 11-18',1,11,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(20,'Girls 11-18',0,11,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(21,'Boys 15-18',1,15,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(22,'Girls 15-18',0,15,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(23,'Boys 17-18',1,17,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(24,'Girls 17-18',0,17,18)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(25,'Men''s',1,0,110)
	insert into dbo.AgeClass(AgeClassID,Description,IsMale,MinAge,MaxAge) values(26,'Women''s',0,0,110)
end

go