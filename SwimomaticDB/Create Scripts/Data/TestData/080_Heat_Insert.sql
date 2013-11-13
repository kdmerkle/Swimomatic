if not exists(select 1 from dbo.Heat )
	begin
		declare @HeatSheetEventID int	
		/*		
		select @HeatSheetEventID = HeatSheetEventID from dbo.HeatSheetEvent where SwimMeetID = (select SwimMeetID from dbo.SwimMeet where [Description] = 'Baxter Barracudas vs. Tega Cay Dolphins') and SwimEventID = (select SwimEventID from dbo.SwimEvent where [Description] = '6 and under Boys Freestyle') 
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,1)
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,2)
				
		select @HeatSheetEventID = HeatSheetEventID from dbo.HeatSheetEvent where SwimMeetID = (select SwimMeetID from dbo.SwimMeet where [Description] = 'Baxter Barracudas vs. Tega Cay Dolphins') and SwimEventID = (select SwimEventID from dbo.SwimEvent where [Description] = '7-8 Boys Freestyle') 
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,1)
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,2)
				
		select @HeatSheetEventID = HeatSheetEventID from dbo.HeatSheetEvent where SwimMeetID = (select SwimMeetID from dbo.SwimMeet where [Description] = 'Baxter Barracudas vs. Tega Cay Dolphins') and SwimEventID = (select SwimEventID from dbo.SwimEvent where [Description] = '11-12 Girls Freestyle') 
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,1)
		INSERT INTO dbo.Heat(HeatSheetEventID,HeatNumber)
		VALUES(@HeatSheetEventID,2)
		*/
	end