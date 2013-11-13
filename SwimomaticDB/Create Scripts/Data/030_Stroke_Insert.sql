/*
select 'insert into dbo.Stroke(StrokeID,Description,IsRelay) values(' +
		cast(StrokeID as varchar(2)) + ',''' +
		[description] + ''',' +
		cast(IsRelay as char(1)) + ')'
from dbo.Stroke
*/

if not exists(select 1 from dbo.Stroke)
begin
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(1,'Butterfly',0)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(2,'Backstroke',0)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(3,'Breaststroke',0)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(4,'Freestyle',0)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(5,'Individual Medly',0)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(6,'Freestyle Relay',1)
	insert into dbo.Stroke(StrokeID,Description,IsRelay) values(7,'Medly Relay',1)
end
go

