/*
SELECT 'insert into dbo.UOM(UOMID,[Description],Abbrev) values(' +
		cast(UOMID as varchar(2)) + ',''' +
        [Description] + ''',''' +
        Abbrev + ''')'
  FROM [Swimomatic].[dbo].[UOM]
*/

if not exists(select 1 from dbo.UOM)
begin
	insert into dbo.UOM(UOMID,[Description],Abbrev) values(1,'Meters','M')
	insert into dbo.UOM(UOMID,[Description],Abbrev) values(2,'Yards','Yd')
end