/*
select 'insert into dbo.Season(LeagueID,AgeClassRuleID,AgeClassRuleCustomDate,StartDate,EndDate,Description) values(' +
cast(LeagueID as varchar(3)) + ',' + cast(AgeClassRuleID as varchar(3)) + ',''' + Convert(varchar(20),isnull(AgeClassRuleCustomDate,GETDATE()),101) + ''',''' + Convert(varchar(20),StartDate,101) + ''',''' + Convert(varchar(20),EndDate,101) + ''',''' + Description + ''')' 
from dbo.Season*/

if not exists(select 1 from dbo.Season where [Description] = 'Summer 2010')
begin
	insert into dbo.Season(LeagueID,AgeClassRuleID,AgeClassRuleCustomDate,StartDate,EndDate,Description) values(2,1,'06/01/2011','06/01/2011','07/15/2011','Summer 2011')
	insert into dbo.Season(LeagueID,AgeClassRuleID,AgeClassRuleCustomDate,StartDate,EndDate,Description) values(3,2,'05/18/2011','05/15/2011','07/31/2011','Summer 2011')
end