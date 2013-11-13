if not exists(select 1 from dbo.HeatSheetEvent )
	begin
		declare @HeatSheetID int
		declare @SwimEventID int 
		select @HeatSheetID = HeatSheetID from dbo.SwimMeet where [Description] = 'Baxter Barracudas vs. Tega Cay Breakers'
		
		select @SwimEventID = SwimEventID from dbo.SwimEvent where [Description] = '6 and under Boys Freestyle'
		INSERT INTO dbo.HeatSheetEvent(HeatSheetID,SwimEventID,[Sequence],Distance)
		VALUES(@HeatSheetID,@SwimEventID,1,25)
		
		select @SwimEventID = SwimEventID from dbo.SwimEvent where [Description] = '7-8 Boys Freestyle'
		INSERT INTO dbo.HeatSheetEvent(HeatSheetID,SwimEventID,[Sequence],Distance)
		VALUES(@HeatSheetID,@SwimEventID,2,25)
		
		select @SwimEventID = SwimEventID from dbo.SwimEvent where [Description] = '11-12 Girls Freestyle'
		INSERT INTO dbo.HeatSheetEvent(HeatSheetID,SwimEventID,[Sequence],Distance)
		VALUES(@HeatSheetID,@SwimEventID,3,25)
	end