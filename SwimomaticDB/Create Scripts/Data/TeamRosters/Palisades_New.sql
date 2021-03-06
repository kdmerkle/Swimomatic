declare	 @ParentFirstName varchar(50)
		,@ParentLastName varchar(50)
		,@Email varchar(250)
		,@Password varchar(250)
		,@SwimmerFirstName varchar(50)
		,@SwimmerLastName varchar(50)
		,@BirthDate datetime
		,@IsMale bit
		,@SystemUserID int
		,@SwimmerID int

		,@TeamID int

set @TeamID = 17 --Palisades

set @ParentFirstName = 'Debbie' set @ParentLastName = 'Bayag' set @Email = 'kbayag@gmail.com' set @Password = 'X12*' + 'kbayag' set @SwimmerFirstName = 'Stephanie' set @SwimmerLastName = 'Bayag' set @BirthDate = '3/4/1993' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Sherri' set @ParentLastName = 'Bowman' set @Email = 'SLB61264@aol.com' set @Password = 'X12*' + 'SLB61264' set @SwimmerFirstName = 'Allie' set @SwimmerLastName = 'Bowman' set @BirthDate = '8/23/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Sheila' set @ParentLastName = 'Fife' set @Email = 'sheilafife@comporium.net' set @Password = 'X12*' + 'sheilafife' set @SwimmerFirstName = 'Asher' set @SwimmerLastName = 'Fife' set @BirthDate = '7/18/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Sheila' set @ParentLastName = 'Fife' set @Email = 'sheilafife@comporium.net' set @Password = 'X12*' + 'sheilafife' set @SwimmerFirstName = 'Olivia' set @SwimmerLastName = 'Fife' set @BirthDate = '12/12/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Evelin' set @ParentLastName = 'Graham' set @Email = 'evegraham@bellsouth.net' set @Password = 'X12*' + 'evegraham' set @SwimmerFirstName = 'Charles' set @SwimmerLastName = 'Graham' set @BirthDate = '7/17/1995' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Jenny' set @ParentLastName = 'Grayson' set @Email = 'chrjennyk@aol.com' set @Password = 'X12*' + 'chrjennyk' set @SwimmerFirstName = 'Grayson' set @SwimmerLastName = 'Gerber' set @BirthDate = '7/7/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Karen' set @ParentLastName = 'Horky' set @Email = 'jhorky@carolina.rr.com' set @Password = 'X12*' + 'jhorky' set @SwimmerFirstName = 'Kaitlyn' set @SwimmerLastName = 'Horky' set @BirthDate = '3/30/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Sarah' set @ParentLastName = 'Kneas' set @Email = 'skneas@yahoo.com' set @Password = 'X12*' + 'skneas' set @SwimmerFirstName = 'Elsie' set @SwimmerLastName = 'Kneas' set @BirthDate = '8/3/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Beth' set @ParentLastName = 'Nagy' set @Email = 'sunnyskies00@gmail.com' set @Password = 'X12*' + 'sunnyskies00' set @SwimmerFirstName = 'Elia' set @SwimmerLastName = 'Nagy' set @BirthDate = '12/1/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Beth' set @ParentLastName = 'Nagy' set @Email = 'sunnyskies00@gmail.com' set @Password = 'X12*' + 'sunnyskies00' set @SwimmerFirstName = 'Delaini' set @SwimmerLastName = 'Nagy' set @BirthDate = '8/24/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Marilia Melchor' set @ParentLastName = 'Nieves' set @Email = 'mmelchor12@hotmail.com' set @Password = 'X12*' + 'mmelchor12' set @SwimmerFirstName = 'Alondra' set @SwimmerLastName = 'Nieves' set @BirthDate = '3/24/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Sherri' set @ParentLastName = 'Pickett' set @Email = 'deanpickett@yahoo.com' set @Password = 'X12*' + 'deanpickett' set @SwimmerFirstName = 'Maya' set @SwimmerLastName = 'Pickett' set @BirthDate = '8/11/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'April' set @ParentLastName = 'Sinicrope' set @Email = 'sinicrope03@hotmail.com' set @Password = 'X12*' + 'sinicrope03' set @SwimmerFirstName = 'Zack' set @SwimmerLastName = 'Hornbrook' set @BirthDate = '10/19/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Kelly' set @ParentLastName = 'Taylor' set @Email = 'ktaylor525@hotmail.com' set @Password = 'X12*' + 'ktaylor525' set @SwimmerFirstName = 'Bode' set @SwimmerLastName = 'Taylor' set @BirthDate = '12/6/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Kelly' set @ParentLastName = 'Taylor' set @Email = 'ktaylor525@hotmail.com' set @Password = 'X12*' + 'ktaylor525' set @SwimmerFirstName = 'Parker' set @SwimmerLastName = 'Taylor' set @BirthDate = '5/5/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

set @ParentFirstName = 'Renda' set @ParentLastName = 'Van Doren' set @Email = 'thevans5@ren.com' set @Password = 'X12*' + 'thevans5' set @SwimmerFirstName = 'Derek' set @SwimmerLastName = 'Van Doren' set @BirthDate = '10/2/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
if not exists(select 1 from Swimmer where LastName = @SwimmerLastName and FirstName = @SwimmerFirstName and BirthDate = @BirthDate)
begin
	insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
	set @SwimmerID = SCOPE_IDENTITY()
	insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)
end

--Create Swimmer TeamSeason records for Palisades
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = @TeamID
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID,StartDate,EndDate)
select SwimmerID,@TeamSeasonID,'05/15/2011','06/30/2011'
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)



