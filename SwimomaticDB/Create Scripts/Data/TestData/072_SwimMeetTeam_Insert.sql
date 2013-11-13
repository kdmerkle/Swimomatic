if not exists(select 1 from dbo.SwimMeetTeam)
begin
	declare @TeamID int,
			@SwimMeetID int

	select @SwimMeetID = SwimMeetID from dbo.SwimMeet where [Description] = 'Baxter Barracudas vs. Tega Cay Breakers'
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Baxter Barracudas'
	INSERT INTO [dbo].[SwimMeetTeam](SwimMeetID,TeamID,IsHomeTeam)VALUES(@SwimMeetID,@TeamID,1)
	
	select @TeamID = TeamID from dbo.Team where [TeamName] = 'Tega Cay Breakers'
	INSERT INTO [dbo].[SwimMeetTeam](SwimMeetID,TeamID,IsHomeTeam)VALUES(@SwimMeetID,@TeamID,0)

end