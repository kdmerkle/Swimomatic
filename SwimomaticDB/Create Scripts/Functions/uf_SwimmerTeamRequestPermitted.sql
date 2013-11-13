IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uf_SwimmerTeamRequestPermitted]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP FUNCTION [dbo].[uf_SwimmerTeamRequestPermitted]
	END

GO

create function dbo.uf_SwimmerTeamRequestPermitted
(
		 @TeamSeasonID int
		,@UserSwimmerID int
)
returns int
as
begin

--this function is used as a check constraint on the SwimmerTeamRequest table
--returns 0 if the Swimmer is currently a member of a team that is a member of the same season

declare	 @SwimmerID int
		,@SeasonID int
		,@RequestPermitted int

--Get the Swimmer associated with the UserSwimmer
select @SwimmerID = SwimmerID
from dbo.UserSwimmer
where UserSwimmerID = @UserSwimmerID

--Get the Season associated with the Requested TeamSeasonID
select @SeasonID = isnull(SeasonID,0)
from dbo.TeamSeason
where TeamSeasonID = @TeamSeasonID;

--Get all the TeamSeasons that include @SeasonID
with OffLimitTeamSeasons(TeamSeasonID) as (
	select TeamSeasonID
	from dbo.TeamSeason
	where SeasonID = @SeasonID
)

--return true if the requested TeamSeasonID is NOT included in the OffLimitTeamSeasons, 
--this means that
select @RequestPermitted = case when COUNT(TeamSeasonID) = 0 then 1 else 0 end
from OffLimitTeamSeasons
where TeamSeasonID = @TeamSeasonID

return @RequestPermitted

end

go

