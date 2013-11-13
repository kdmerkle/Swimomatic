if not exists(select 1 from dbo.SwimmerTeamSeason )
	begin
	
		declare	 @TeamSeasonID int
				,@StartDate datetime
				,@EndDate datetime
				
		set @StartDate = '2010-06-15 00:00:00.000'
		set @EndDate = '2010-07-01 00:00:00.000'
		
		--Barracudas
		select @TeamSeasonID = TeamSeasonID 
		from dbo.TeamSeason 
		where TeamID = (select TeamID from dbo.Team where TeamName = 'Baxter Barracudas') 
		and SeasonID = (select SeasonID from dbo.Season where [Description] = 'Summer 2010')
		
		insert into dbo.SwimmerTeamSeason(SwimmerID,TeamSeasonID,StartDate,EndDate)
		select	 SwimmerID
				,@TeamSeasonID
				,@StartDate
				,@EndDate
		from dbo.Swimmer 
		where SwimmerID % 2 = 0
		
		--Tega Cay Breakers
		select @TeamSeasonID = TeamSeasonID 
		from dbo.TeamSeason 
		where TeamID = (select TeamID from dbo.Team where TeamName = 'Tega Cay Breakers') 
		and SeasonID = (select SeasonID from dbo.Season where [Description] = 'Summer 2010')
		
		insert into dbo.SwimmerTeamSeason(SwimmerID,TeamSeasonID,StartDate,EndDate)
		select	 SwimmerID
				,@TeamSeasonID
				,@StartDate
				,@EndDate
		from dbo.Swimmer 
		where SwimmerID % 2 = 1

		
	end