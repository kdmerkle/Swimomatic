-- =============================================
-- Script Template
-- =============================================
/*
  SELECT 'insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(''' +
		UserName + ''',''' +
		[Password] + ''',''' +
		FirstName + ''',''' +
        LastName + ''',1, 0, ''' +
        Email + ''',''Fort Mill'', 41, ''' +
        cast(newid() as varchar(36)) + ''', getdate())'
  FROM dbo.SystemUser
*/

declare @SystemUserID int,
		@SwimmerID int,
		@TeamID int

set @TeamID = 1 --Baxter

insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values('amber@mcdadeadamscpa.com','X12*amber','Amber','Adams',1, 0,'amber@mcdadeadamscpa.com','Fort Mill', 41,newid(), getdate())

--Create Swimmer TeamSeason records for Baxter
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = @TeamID
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID)
select SwimmerID,@TeamSeasonID 
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)
