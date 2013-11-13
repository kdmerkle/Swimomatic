/*
SELECT 'insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(' +
		cast(AgeClassRuleID as varchar(2)) + ',''' +
        [Description] + ''',''' +
        ShortDescription + ''')'
  FROM [Swimomatic].[dbo].[AgeClassRule]
*/

if not exists(select 1 from AgeClassRule)
begin
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(1,'Swimmer''s age on {0}','AgeAtCustomDate')
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(2,'Swimmer''s age on January 1','AgeAtJan1')
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(3,'Swimmer''s age on Season Start Date','AgeAtSeasonStart')
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(4,'Swimmer''s age on Swim Meet Date','AgeAtSwimMeet')
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(5,'Swimmer''s age on Season End Date','AgeAtSeasonEnd')
	insert into dbo.AgeClassRule(AgeClassRuleID,[Description],ShortDescription) values(6,'Swimmer''s age on December 31','AgeAtDec31')
end