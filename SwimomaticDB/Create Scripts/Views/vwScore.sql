if exists (select * from sysobjects where type = 'V' and name = 'vwScore')
	begin
	    drop view [dbo].[vwScore]
	end
go

create view [dbo].[vwScore]
	as 
		select	 hs.SwimMeetID
				,hsw.Leg
				,hse.HeatSheetID
				,hse.HeatSheetEventID
				,r.HeatSwimmerID
				,hse.Sequence
				,r.SwimmerID
				,t.TeamID
				,s.LastName + ', ' + s.FirstName as Swimmer
				,t.Abbrev
				,r.EventDate
				,r.ElapsedTime
				,r.Split
				,r.Disqualified
				,ac.[Description] + ' ' + cast(r.Distance as varchar) + ' ' + substring(u.[Description],0,LEN(u.[Description])) + ' ' + st.[Description] as [Description]
				,r.LaneLength
				,coalesce(r.Points,0) as Points
				,coalesce(r.Place,0) as Place
				,r.IsCertified
				,r.IsProtested
				,st.IsRelay
		from dbo.Result r
		inner join dbo.HeatSwimmer hsw on hsw.HeatSwimmerID = r.HeatSwimmerID
		inner join dbo.Heat h on h.HeatID = hsw.HeatID
		inner join dbo.HeatSheetEvent hse on hse.HeatSheetEventID = h.HeatSheetEventID
		inner join dbo.HeatSheet hs on hs.HeatSheetID = hse.HeatSheetID
		inner join dbo.Swimmer s on s.SwimmerID = r.SwimmerID
		inner join dbo.TeamSeason ts on ts.TeamSeasonID = r.TeamSeasonID
		inner join dbo.Team t on t.TeamID = ts.TeamID
		inner join dbo.UOM u on u.UOMID = r.UOMID
		inner join dbo.Stroke st on st.StrokeID = r.StrokeID
		inner join dbo.AgeClass ac on ac.AgeClassID = r.AgeClassID