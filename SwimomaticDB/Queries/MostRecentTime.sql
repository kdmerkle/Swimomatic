use swimomatic
--most recent time for the swimmer in the same event this season
--need:
	--SwimmerID
	--HeatSheetEventID
	--TeamSeasonID
--divide time by pool length from past event to get speed
--multiply times current pool length
declare @HeatSwimmerID int
set @HeatSwimmerID = 44

declare @SwimmerID int
declare @SeasonID int
declare @StrokeID int
declare @TeamSeasonID int
declare @ElapsedTime float
declare @SeedTime float
declare @StartDate datetime
declare @Distance int
declare @LaneLength int
declare @UOMID int

select	 @SwimmerID = hs.SwimmerID
		,@TeamSeasonID = ts.TeamSeasonID
		,@StrokeID = se.StrokeID
		,@Distance = hse.Distance
		,@StartDate = sm.StartDate
from dbo.HeatSwimmer hs 
inner join dbo.Heat h on h.HeatID = hs.HeatID
inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = hs.SwimmerID
inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
inner join dbo.HeatSheet hst on hst.HeatSheetID = hse.HeatSheetID
inner join dbo.TeamSeason ts on ts.TeamSeasonID = sts.TeamSeasonID
inner join dbo.SwimMeet sm on sm.SwimMeetID = hst.SwimMeetID
inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
inner join dbo.Stroke s on s.StrokeID = se.StrokeID
where hs.HeatSwimmerID = @HeatSwimmerID

--select @ElapsedTime = isnull(hs.ElapsedTime, 0)
select	 @ElapsedTime = hs.ElapsedTime
		,@LaneLength = pc.LaneLength
		,@UOMID = pc.UOMID
from dbo.HeatSwimmer hs
inner join dbo.Heat h on h.HeatID = hs.HeatID
inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
inner join dbo.HeatSheet hst on hst.HeatSheetID = hse.HeatSheetID
inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = hs.SwimmerID
inner join dbo.SwimMeet sm on sm.SwimMeetID = hst.SwimMeetID
inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
inner join dbo.PoolConfig pc on pc.PoolConfigID = hst.PoolConfigID
where hs.SwimmerID = @SwimmerID
and sts.TeamSeasonID = @TeamSeasonID
and se.StrokeID = @StrokeID
and hse.Distance = @Distance
group by hs.ElapsedTime
		,pc.ActualLaneLength
		,pc.UOMID
having max(sm.StartDate) < @StartDate

select	 @SwimmerID as SwimmerID
		,@TeamSeasonID as TeamSeasonID
		,@Distance as Distance
		,@StartDate as StartDate
		,@StrokeID as StrokeID

select isnull(@ElapsedTime, 0) as ElapsedTime

