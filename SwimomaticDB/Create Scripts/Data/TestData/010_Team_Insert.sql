if not exists(select 1 from Team where TeamName = 'Baxter Barracudas')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Baxter Barracudas','BAX',1)
end

if not exists(select 1 from Team where TeamName = 'Tega Cay Breakers')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Tega Cay Breakers','TC',4)
end

if not exists(select 1 from Team where TeamName = 'Shiland Sharks')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Shiland Sharks','SHI',6)
end

if not exists(select 1 from Team where TeamName = 'Rock Hill CC')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Rock Hill CC','RHCC',7)
end

if not exists(select 1 from Team where TeamName = 'Landing Gators')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Landing Gators','LAN',13)
end

if not exists(select 1 from Team where TeamName = 'Palisades Piranhas')
begin
	insert into Team(TeamName,Abbrev, HomePoolConfigID) values('Palisades Piranhas','PAL',14)
end
