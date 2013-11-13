/*
select 'insert into dbo.SwimMeetType values(' + cast(SwimMeetTypeID as varchar(2)) + ',''' + [Description] + ''')'
from dbo.[SwimMeetType]
*/

if not exists(select 1 from dbo.SwimMeetType)
begin
INSERT INTO dbo.SwimMeetType(SwimMeetTypeID,[Description])VALUES(1,'Dual Meet')
INSERT INTO dbo.SwimMeetType(SwimMeetTypeID,[Description])VALUES(2,'Triangular Meet')
INSERT INTO dbo.SwimMeetType(SwimMeetTypeID,[Description])VALUES(3,'Other')

end