if not exists(select 1 from dbo.TeamSeason )
begin
	declare @SeasonID int,
			@TeamID int,
			@LeagueID int
			
	select @SeasonID = SeasonID from dbo.Season where [Description] = 'Summer 2011'
	select @LeagueID = LeagueID from dbo.League where [LeagueName] = 'Metrolina League'

	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Baxter Barracudas'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Tega Cay Breakers'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)

	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Shiland Sharks'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Rock Hill CC'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Landing Gators'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Palisades Piranhas'
	INSERT INTO [dbo].[TeamSeason] (TeamID,SeasonID,LeagueID,AgeClassRuleID) VALUES (@TeamID,@SeasonID,@LeagueID,1)
end