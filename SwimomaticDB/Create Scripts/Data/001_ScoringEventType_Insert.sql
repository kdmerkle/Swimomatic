/*
select 'insert into dbo.ScoringEventType values(' + cast(ScoringEventTypeID as varchar(2)) + ',''' + [Description] + ''')'
from dbo.[ScoringEventType]
*/

if not exists(select 1 from dbo.ScoringEventType)
begin
	INSERT INTO dbo.ScoringEventType(ScoringEventTypeID,[Description])VALUES(1,'Heat')
	INSERT INTO dbo.ScoringEventType(ScoringEventTypeID,[Description])VALUES(2,'Final')
	INSERT INTO dbo.ScoringEventType(ScoringEventTypeID,[Description])VALUES(3,'Consolation')
end

go

