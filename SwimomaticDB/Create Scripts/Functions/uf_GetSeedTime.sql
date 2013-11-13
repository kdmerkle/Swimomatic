IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uf_GetSeedTime]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP FUNCTION [dbo].[uf_GetSeedTime]
	END

GO

create function dbo.uf_GetSeedTime
(
	 @HeatSwimmerID int
)
returns decimal(9,4)
as
begin

--returns the most recent time for the swimmer in the same event this season
--divide time by pool length from past event to get speed
--multiply times current pool length

declare @SwimmerID int
declare @SeasonID int
declare @StrokeID int
declare @TeamSeasonID int
declare @ElapsedTime decimal(9,4)
declare @SeedTime decimal(9,4)
declare @StartDate datetime
declare @Distance int
declare @LaneLength1 int
declare @LaneLength2 int
declare @UOMID1 int
declare @UOMID2 int
declare @AdjustedElapsedTime decimal(9,4)

select	 @SwimmerID = hs.SwimmerID
		,@TeamSeasonID = ts.TeamSeasonID
		,@StrokeID = se.StrokeID
		,@Distance = hse.Distance
		,@StartDate = sm.StartDate
		,@LaneLength2 = pc.LaneLength
		,@UOMID2 = pc.UOMID
from dbo.HeatSwimmer hs 
inner join dbo.Heat h on h.HeatID = hs.HeatID
inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = hs.SwimmerID
inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
inner join dbo.TeamSeason ts on ts.TeamSeasonID = sts.TeamSeasonID
inner join dbo.HeatSheet hst on hst.HeatSheetID = hse.HeatSheetID
inner join dbo.PoolConfig pc on pc.PoolConfigID = hst.PoolConfigID
inner join dbo.SwimMeet sm on sm.SwimMeetID = hst.SwimMeetID
inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
inner join dbo.Stroke s on s.StrokeID = se.StrokeID
where hs.HeatSwimmerID = @HeatSwimmerID

select	 @ElapsedTime = r.ElapsedTime
		,@LaneLength1 = r.LaneLength
		,@UOMID1 = r.UOMID
from dbo.Result r
where r.SwimmerID = @SwimmerID
and r.StrokeID = @StrokeID
and r.TeamSeasonID = @TeamSeasonID
and r.Distance = @Distance
group by r.ElapsedTime
		,r.LaneLength
		,r.UOMID
having max(r.EventDate) < @StartDate

select @AdjustedElapsedTime = dbo.uf_GetConvertedTime(@LaneLength1,@UOMID1,@ElapsedTime,@LaneLength2,@UOMID2)

return isnull(@AdjustedElapsedTime, 0)

end

go

