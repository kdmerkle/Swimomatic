--Swim Meet
begin tran
declare	 @SwimMeetID int
		,@SwimMeetTypeID int
		,@Description varchar(250)
		,@StartDate datetime
		,@EndDate datetime
		,@LocationID int
		,@SeasonID int
		
		,@SystemUserID int
		,@PoolConfigID int
		,@TeamID int
		,@TeamSeasonID int
		,@IsHomeTeam bit
		,@Lanes varchar(50)
		,@HeatSheetID int
		
		,@HeatSheetEventID int
		,@SwimEventID int 
		,@AgeClassID int
		,@StrokeID int
		,@Sequence int = 0
		,@Distance int
		--,@ int
		

--Create SwimMeet, SwimMeetTeam and UserSwimMeet
set @SwimMeetTypeID = 1 --Dual Meet
set @Description = 'Baxter Practice Meet' --
set @StartDate =  '05/31/2011'--
set @EndDate =  '06/01/2011'  --
set @LocationID = 1 --Baxter CC
set @SeasonID = 1 --Metrolina Summer 2011

insert into dbo.SwimMeet values(@SwimMeetTypeID,@Description,@StartDate,@EndDate,@LocationID,@SeasonID)
set @SwimMeetID = Scope_identity()

set @TeamID = 1 --***Home Team (Baxter)
set @TeamSeasonID = 5 --***Home Team (Baxter)
set @IsHomeTeam = 1 --***
insert into dbo.SwimMeetTeam values (@SwimMeetID,@TeamSeasonID,@IsHomeTeam)

select @PoolConfigID = HomePoolConfigID from dbo.Team where TeamID = @TeamID --PoolConfig for Home team

/*
set @TeamID = 
set @@TeamSeasonID =  --Opponent
set @IsHomeTeam = 0
insert into dbo.SwimMeetTeam values (@SwimMeetID,@@TeamSeasonID,@IsHomeTeam)
*/

set @SystemUserID = 11 --KDM
insert into dbo.UserSwimMeet values (@SystemUserID,@SwimMeetID)

set @SystemUserID = 51 --***Elena
insert into dbo.UserSwimMeet values (@SystemUserID,@SwimMeetID)

/*
set @SystemUserID =  --Opponent Coach
insert into dbo.UserSwimMeet values (@SystemUserID,@SwimMeetID)
*/

insert into dbo.HeatSheet values(@SwimMeetID,@PoolConfigID)
set @HeatSheetID = Scope_identity()

set @TeamSeasonID = 5 --***Baxter
set @Lanes = '1|2|3|4|5|6' --***
insert into dbo.HeatSheetTeam values(@HeatSheetID,@TeamSeasonID,@Lanes)
/*
set @TeamSeasonID =  --***Opponent
set @Lanes = '1|2|3|4|5|6'
insert into dbo.HeatSheetTeam values(@HeatSheetID,@TeamSeasonID,@Lanes)
*/

--G10U 100 MR
set @AgeClassID = 6
set @StrokeID = 7
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

print '@SwimEventID = ' + cast(@SwimEventID as varchar(4))

--B10U 100 MR
set @AgeClassID = 5
set @StrokeID = 7
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G11-18 100 MR
set @AgeClassID = 20
set @StrokeID = 7
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G11-18 100 MR
set @AgeClassID = 19
set @StrokeID = 7
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G6U25F
set @AgeClassID = 2
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B6U25F
set @AgeClassID = 1
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G7825F
set @AgeClassID = 10
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B7825F
set @AgeClassID = 9
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G91025F
set @AgeClassID = 12
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B91025F
set @AgeClassID = 11
set @StrokeID = 1
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G111250F
set @AgeClassID = 14
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B111250F
set @AgeClassID = 13
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G131450F
set @AgeClassID = 16
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B131450F
set @AgeClassID = 15
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G151850F
set @AgeClassID = 22
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B151850F
set @AgeClassID = 21
set @StrokeID = 1
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G6U25B
set @AgeClassID = 2
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B6U25B
set @AgeClassID = 1
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G7825B
set @AgeClassID = 10
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B7825B
set @AgeClassID = 9
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G91025B
set @AgeClassID = 12
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B91025B
set @AgeClassID = 11
set @StrokeID = 3
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G111250B
set @AgeClassID = 14
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B111250B
set @AgeClassID = 13
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G131450B
set @AgeClassID = 16
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B131450B
set @AgeClassID = 15
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G151850B
set @AgeClassID = 22
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B151850B
set @AgeClassID = 21
set @StrokeID = 3
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G910100IM
set @AgeClassID = 12
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B91050B
set @AgeClassID = 11
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G1112100IM
set @AgeClassID = 14
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B1112100IM
set @AgeClassID = 13
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G1314100IM
set @AgeClassID = 16
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B1314100IM
set @AgeClassID = 15
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G1518100IM
set @AgeClassID = 22
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B1518100IM
set @AgeClassID = 21
set @StrokeID = 6
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G7825BR
set @AgeClassID = 10
set @StrokeID = 2
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B7825BR
set @AgeClassID = 9
set @StrokeID = 2
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G91025BR
set @AgeClassID = 12
set @StrokeID = 2
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B91025BR
set @AgeClassID = 11
set @StrokeID = 2
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G111250BR
set @AgeClassID = 14
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B111250BR
set @AgeClassID = 13
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G131450BR
set @AgeClassID = 16
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B131450BR
set @AgeClassID = 15
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G151850BR
set @AgeClassID = 22
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B151850BR
set @AgeClassID = 21
set @StrokeID = 2
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G7825FLY
set @AgeClassID = 10
set @StrokeID = 4
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B7825FLY
set @AgeClassID = 9
set @StrokeID = 4
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G91025FLY
set @AgeClassID = 12
set @StrokeID = 4
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B91025FLY
set @AgeClassID = 11
set @StrokeID = 4
set @Distance = 25
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G111250FLY
set @AgeClassID = 14
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B111250FLY
set @AgeClassID = 13
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G131450FLY
set @AgeClassID = 16
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B131450FLY
set @AgeClassID = 15
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G151850FLY
set @AgeClassID = 22
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B151850FLY
set @AgeClassID = 21
set @StrokeID = 4
set @Distance = 50
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G10UFR
set @AgeClassID = 6
set @StrokeID = 5
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B10UFR
set @AgeClassID = 5
set @StrokeID = 5
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--G1118FR
set @AgeClassID = 20
set @StrokeID = 5
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--B1118UFR
set @AgeClassID = 19
set @StrokeID = 5
set @Distance = 100
set @Sequence = @Sequence + 1
if exists (select SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID)
	begin
		select @SwimEventID = SwimEventID from dbo.SwimEvent se where se.AgeClassID = @AgeClassID and se.StrokeID = @StrokeID
	end
else
	begin
		exec dbo.usp_SwimEventSave @AgeClassID,null,@StrokeID,@SwimEventID output
	end
insert into dbo.HeatSheetEvent values(@HeatSheetID,@SwimEventID,@Sequence,@Distance) set @SwimEventID = 0

--commit tran
--rollback tran