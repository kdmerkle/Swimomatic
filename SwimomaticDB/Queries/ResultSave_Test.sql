-- =============================================
-- Script Template
-- =============================================
declare @HeatSwimmerID int = 207

	select	se.AgeClassID
			,hse.Distance
			,sm.StartDate
			,pc.LaneLength
			,se.StrokeID
			,hs.SwimmerID
			,ts.TeamSeasonID
			,pc.UOMID
	from dbo.HeatSwimmer hs
	inner join dbo.Heat h on h.HeatID = hs.HeatID
	inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
	inner join dbo.SwimEvent se on se.SwimEventID = hse.SwimEventID
	inner join dbo.HeatSheet hst on hst.HeatSheetID = hse.HeatSheetID
	inner join dbo.PoolConfig pc on pc.PoolConfigID = hst.PoolConfigID
	inner join dbo.SwimMeet sm on sm.SwimMeetID = hst.SwimMeetID
	inner join dbo.SwimmerTeamSeason sts on sts.SwimmerID = hs.SwimmerID
	inner join dbo.TeamSeason ts on ts.SeasonID = sm.SeasonID			--this join requires that a swimmer may only be a member of one team in a given season
								and ts.TeamSeasonID = sts.TeamSeasonID
	where hs.HeatSwimmerID = @HeatSwimmerID