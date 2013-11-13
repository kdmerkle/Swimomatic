if not exists(select 1 from dbo.SwimMeet )
	begin
		declare @LocationID int
				,@SeasonID int
		select @LocationID = LocationID from dbo.Location where [Name] = 'Baxter Community Center'
		select @SeasonID = SeasonID from dbo.Season where [Description] = 'Summer 2010'
		
		INSERT INTO dbo.SwimMeet([Description],StartDate,LocationID,SeasonID)
		VALUES('Baxter Barracudas vs. Tega Cay Breakers','06/01/2010 06:00:00 PM',@LocationID,@SeasonID)
	end