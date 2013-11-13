if not exists(select 1 from League where LeagueName = 'Metrolina League')
begin
	insert into League(LeagueName,[Description], RegionID) values('Metrolina League','York County, SC', 41)
end

