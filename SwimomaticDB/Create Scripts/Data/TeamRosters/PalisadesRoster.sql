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

set @ParentFirstName = 'Kristen' set @ParentLastName = 'Allen' set @Email = 'kmallen1974@gmail.com' set @Password = 'X12*' + 'kmallen1974' set @SwimmerFirstName = 'Kate' set @SwimmerLastName = 'Allen' set @BirthDate = '04/11/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Carmen' set @ParentLastName = 'Antezana' set @Email = 'perulivia.68@msn.com' set @Password = 'X12*' + 'perulivia.68' set @SwimmerFirstName = 'Andrea' set @SwimmerLastName = 'Antezana' set @BirthDate = '07/12/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Carmen' set @ParentLastName = 'Antezana' set @Email = 'perulivia.68@msn.com' set @Password = 'X12*' + 'perulivia.68' set @SwimmerFirstName = 'Aaron' set @SwimmerLastName = 'Antezana' set @BirthDate = '02/22/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kristen' set @ParentLastName = 'Backeberg' set @Email = 'Kbackeberg@gmail.com' set @Password = 'X12*' + 'Kbackeberg' set @SwimmerFirstName = 'Madison' set @SwimmerLastName = 'Backeberg' set @BirthDate = '10/27/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Cheryl' set @ParentLastName = 'Beer' set @Email = 'ocbeer@carolina.rr.com' set @Password = 'X12*' + 'ocbeer' set @SwimmerFirstName = 'Makkenzie' set @SwimmerLastName = 'Beer' set @BirthDate = '07/06/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Dina' set @ParentLastName = 'Boozer' set @Email = 'lakeboozer@bellsouth.net' set @Password = 'X12*' + 'lakeboozer' set @SwimmerFirstName = 'Tyler' set @SwimmerLastName = 'Boozer' set @BirthDate = '01/03/1997' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tannis' set @ParentLastName = 'Brown' set @Email = 'tannisellis@hotmail.com' set @Password = 'X12*' + 'tannisellis' set @SwimmerFirstName = 'Drew' set @SwimmerLastName = 'Brown' set @BirthDate = '06/06/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tannis' set @ParentLastName = 'Brown' set @Email = 'tannisellis@hotmail.com' set @Password = 'X12*' + 'tannisellis' set @SwimmerFirstName = 'Megan' set @SwimmerLastName = 'Brown' set @BirthDate = '12/06/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura' set @ParentLastName = 'Cecil' set @Email = 'bcm1@yahoo.com' set @Password = 'X12*' + 'bcm1' set @SwimmerFirstName = 'Tucker' set @SwimmerLastName = 'Cecil' set @BirthDate = '07/23/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Betsy' set @ParentLastName = 'Coleman' set @Email = 'wcoleman8@carolina.rr.com' set @Password = 'X12*' + 'wcoleman8' set @SwimmerFirstName = 'Anna' set @SwimmerLastName = 'Coleman' set @BirthDate = '08/15/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Cheryl' set @ParentLastName = 'Cook' set @Email = 'RBC7272@aol.com' set @Password = 'X12*' + 'RBC7272' set @SwimmerFirstName = 'Shelby' set @SwimmerLastName = 'Cook' set @BirthDate = '03/08/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kim' set @ParentLastName = 'Covington' set @Email = 'kcovington4@bellsouth.net' set @Password = 'X12*' + 'kcovington4' set @SwimmerFirstName = 'Logan' set @SwimmerLastName = 'Covington' set @BirthDate = '02/20/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Julie' set @ParentLastName = 'Ellis' set @Email = 'jellis1929@gmail.com' set @Password = 'X12*' + 'jellis1929' set @SwimmerFirstName = 'Bailey' set @SwimmerLastName = 'Ellis' set @BirthDate = '11/12/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Julie' set @ParentLastName = 'Ellis' set @Email = 'jellis1929@gmail.com' set @Password = 'X12*' + 'jellis1929' set @SwimmerFirstName = 'Mackenzie' set @SwimmerLastName = 'Ellis' set @BirthDate = '11/08/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Teresa' set @ParentLastName = 'Fano' set @Email = 'Teefano@gmail.com' set @Password = 'X12*' + 'Teefano' set @SwimmerFirstName = 'Nico' set @SwimmerLastName = 'Fano' set @BirthDate = '05/16/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Teresa' set @ParentLastName = 'Fano' set @Email = 'Teefano@gmail.com' set @Password = 'X12*' + 'Teefano' set @SwimmerFirstName = 'Mateo' set @SwimmerLastName = 'Fano' set @BirthDate = '06/23/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Teresa' set @ParentLastName = 'Fano' set @Email = 'Teefano@gmail.com' set @Password = 'X12*' + 'Teefano' set @SwimmerFirstName = 'Enzo' set @SwimmerLastName = 'Fano' set @BirthDate = '05/30/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Sheila' set @ParentLastName = 'Fife' set @Email = 'sfife@gmail.com' set @Password = 'X12*' + 'sfife' set @SwimmerFirstName = 'Olivia' set @SwimmerLastName = 'Fife' set @BirthDate = '12/12/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Sheila' set @ParentLastName = 'Fife' set @Email = 'sfife@gmail.com' set @Password = 'X12*' + 'sfife' set @SwimmerFirstName = 'Asher' set @SwimmerLastName = 'Fife' set @BirthDate = '07/18/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tina' set @ParentLastName = 'Fix' set @Email = 'teelmann@aol.com' set @Password = 'X12*' + 'teelmann' set @SwimmerFirstName = 'Tanner' set @SwimmerLastName = 'Mann' set @BirthDate = '10/18/1996' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tina' set @ParentLastName = 'Fix' set @Email = 'teelmann@aol.com' set @Password = 'X12*' + 'teelmann' set @SwimmerFirstName = 'Conner' set @SwimmerLastName = 'Fix' set @BirthDate = '11/28/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Angie' set @ParentLastName = 'Forbis' set @Email = 'abcdeforbis@carolina.rr.com' set @Password = 'X12*' + 'abcdeforbis' set @SwimmerFirstName = 'Courtney' set @SwimmerLastName = 'Forbis' set @BirthDate = '11/15/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lu' set @ParentLastName = 'Gibbs' set @Email = 'lu@gibbsus.com' set @Password = 'X12*' + 'lu' set @SwimmerFirstName = 'Dylan' set @SwimmerLastName = 'Gibbs' set @BirthDate = '02/26/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Joy' set @ParentLastName = 'Granetz' set @Email = 'jgranetz@gmail.com' set @Password = 'X12*' + 'jgranetz' set @SwimmerFirstName = 'Juliet' set @SwimmerLastName = 'Granetz' set @BirthDate = '06/07/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Joy' set @ParentLastName = 'Granetz' set @Email = 'jgranetz@gmail.com' set @Password = 'X12*' + 'jgranetz' set @SwimmerFirstName = 'Nathan' set @SwimmerLastName = 'Granetz' set @BirthDate = '02/04/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Evelin' set @ParentLastName = 'Graham' set @Email = 'evegraham@bellsouth.net' set @Password = 'X12*' + 'evegraham' set @SwimmerFirstName = 'Eldon' set @SwimmerLastName = 'Graham' set @BirthDate = '07/26/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Evelin' set @ParentLastName = 'Graham' set @Email = 'evegraham@bellsouth.net' set @Password = 'X12*' + 'evegraham' set @SwimmerFirstName = 'Mya' set @SwimmerLastName = 'Graham' set @BirthDate = '07/07/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Katie' set @ParentLastName = 'Grimm' set @Email = 'tomandkatie@aol.com' set @Password = 'X12*' + 'tomandkatie' set @SwimmerFirstName = 'Hannah' set @SwimmerLastName = 'Grimm' set @BirthDate = '11/01/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Katie' set @ParentLastName = 'Grimm' set @Email = 'tomandkatie@aol.com' set @Password = 'X12*' + 'tomandkatie' set @SwimmerFirstName = 'Sarah' set @SwimmerLastName = 'Grimm' set @BirthDate = '07/08/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Katie' set @ParentLastName = 'Grimm' set @Email = 'tomandkatie@aol.com' set @Password = 'X12*' + 'tomandkatie' set @SwimmerFirstName = 'Emily' set @SwimmerLastName = 'Grimm' set @BirthDate = '04/27/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rebecca' set @ParentLastName = 'Guidice' set @Email = 'RebeccaGuidice@earthlink.net' set @Password = 'X12*' + 'RebeccaGuidice' set @SwimmerFirstName = 'Mikayla' set @SwimmerLastName = 'Guidice' set @BirthDate = '12/02/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Nikki' set @ParentLastName = 'Hankins' set @Email = 'nikkihankins2@aol.com' set @Password = 'X12*' + 'nikkihankins2' set @SwimmerFirstName = 'Laney' set @SwimmerLastName = 'Hankins' set @BirthDate = '04/20/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ann Dorthe' set @ParentLastName = 'Havmoeller' set @Email = 'havmoeller@yahoo.com' set @Password = 'X12*' + 'havmoeller' set @SwimmerFirstName = 'Emma' set @SwimmerLastName = 'Havmoeller' set @BirthDate = '02/04/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ann Dorthe' set @ParentLastName = 'Havmoeller' set @Email = 'havmoeller@yahoo.com' set @Password = 'X12*' + 'havmoeller' set @SwimmerFirstName = 'Harrison' set @SwimmerLastName = 'Havmoeller' set @BirthDate = '04/29/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kris ' set @ParentLastName = 'Hopkins' set @Email = 'kphopkins@cfids.org' set @Password = 'X12*' + 'kphopkins' set @SwimmerFirstName = 'Katie' set @SwimmerLastName = 'Hopkins' set @BirthDate = '04/24/1997' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kris ' set @ParentLastName = 'Hopkins' set @Email = 'kphopkins@cfids.org' set @Password = 'X12*' + 'kphopkins' set @SwimmerFirstName = 'Kinsey' set @SwimmerLastName = 'Hopkins-Campbell' set @BirthDate = '05/29/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Karen' set @ParentLastName = 'Horky' set @Email = 'jhorky@carolina.rr.com' set @Password = 'X12*' + 'jhorky' set @SwimmerFirstName = 'Kaitlyn' set @SwimmerLastName = 'Horky' set @BirthDate = '03/30/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'April ' set @ParentLastName = 'Sinicrope' set @Email = 'Sinicrope03@hotmail.com' set @Password = 'X12*' + 'Sinicrope03' set @SwimmerFirstName = 'Zack' set @SwimmerLastName = 'Hornbrook' set @BirthDate = '10/19/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kim' set @ParentLastName = 'Hylton' set @Email = 'akimbo@carolina.rr.com' set @Password = 'X12*' + 'akimbo' set @SwimmerFirstName = 'Zach ' set @SwimmerLastName = 'Hylton' set @BirthDate = '09/08/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Renee' set @ParentLastName = 'Jackson' set @Email = 'jack270@bellsouth.net' set @Password = 'X12*' + 'jack270' set @SwimmerFirstName = 'Justin' set @SwimmerLastName = 'Jackson' set @BirthDate = '04/08/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Angela' set @ParentLastName = 'Kellett' set @Email = 'akellett@gmail.com' set @Password = 'X12*' + 'akellett' set @SwimmerFirstName = 'Emma' set @SwimmerLastName = 'Kellett' set @BirthDate = '05/21/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Kidd' set @Email = 'lisakidd@bellsouth.net' set @Password = 'X12*' + 'lisakidd' set @SwimmerFirstName = 'Morgan' set @SwimmerLastName = 'Kidd' set @BirthDate = '06/20/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Kidd' set @Email = 'lisakidd@bellsouth.net' set @Password = 'X12*' + 'lisakidd' set @SwimmerFirstName = 'Luke' set @SwimmerLastName = 'Kidd' set @BirthDate = '03/08/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Susan' set @ParentLastName = 'Landon' set @Email = 'chruisan@bellsouth.net' set @Password = 'X12*' + 'chruisan' set @SwimmerFirstName = 'Sadie' set @SwimmerLastName = 'Landon' set @BirthDate = '10/03/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Dawn Marie' set @ParentLastName = 'Maier' set @Email = '2beachmaiers@msn.com' set @Password = 'X12*' + '2beachmaiers' set @SwimmerFirstName = 'Caleb' set @SwimmerLastName = 'Maier' set @BirthDate = '04/24/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Andrea' set @ParentLastName = 'McCarter' set @Email = 'jmccar3928@aol.com' set @Password = 'X12*' + 'jmccar3928' set @SwimmerFirstName = 'Haden' set @SwimmerLastName = 'McCarter' set @BirthDate = '03/09/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Andrea' set @ParentLastName = 'McCarter' set @Email = 'jmccar3928@aol.com' set @Password = 'X12*' + 'jmccar3928' set @SwimmerFirstName = 'Melia' set @SwimmerLastName = 'McCarter' set @BirthDate = '04/06/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Leigh' set @ParentLastName = 'McConnell' set @Email = 'alwmcc@bellsouth.net' set @Password = 'X12*' + 'alwmcc' set @SwimmerFirstName = 'Ann Mason' set @SwimmerLastName = 'McConnell' set @BirthDate = '05/11/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rebecca' set @ParentLastName = 'McGowan' set @Email = 'rebmcgowan@comporium.net' set @Password = 'X12*' + 'rebmcgowan' set @SwimmerFirstName = 'Blair' set @SwimmerLastName = 'McGowan' set @BirthDate = '09/17/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Nichole' set @ParentLastName = 'Neeld' set @Email = 'nneeld@carolina.rr.com' set @Password = 'X12*' + 'nneeld' set @SwimmerFirstName = 'Gabriella' set @SwimmerLastName = 'Neeld' set @BirthDate = '11/04/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Karen' set @ParentLastName = 'Nero' set @Email = 'Karen.Nero@cms.k12.nc.us' set @Password = 'X12*' + 'Karen.Nero' set @SwimmerFirstName = 'Caitlin' set @SwimmerLastName = 'Nero' set @BirthDate = '09/19/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Brittany' set @ParentLastName = 'Padgett' set @Email = 'padgetts@comporium.net' set @Password = 'X12*' + 'padgetts' set @SwimmerFirstName = 'Ava' set @SwimmerLastName = 'Padgett' set @BirthDate = '12/23/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Brittany' set @ParentLastName = 'Padgett' set @Email = 'padgetts@comporium.net' set @Password = 'X12*' + 'padgetts' set @SwimmerFirstName = 'Caroline' set @SwimmerLastName = 'Padgett' set @BirthDate = '06/02/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Addie' set @ParentLastName = 'Percoco' set @Email = 'WNP2@earthlink.net' set @Password = 'X12*' + 'WNP2' set @SwimmerFirstName = 'Isabelle' set @SwimmerLastName = 'Percoco' set @BirthDate = '03/29/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Heidi' set @ParentLastName = 'Phillips' set @Email = 'emmymorganp@yahoo.com' set @Password = 'X12*' + 'emmymorganp' set @SwimmerFirstName = 'Emily' set @SwimmerLastName = 'Phillips' set @BirthDate = '08/26/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Sherri' set @ParentLastName = 'Pickett' set @Email = 'deanpickett@yahoo.com' set @Password = 'X12*' + 'deanpickett' set @SwimmerFirstName = 'Morgan' set @SwimmerLastName = 'Pickett' set @BirthDate = '11/26/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Anita' set @ParentLastName = 'Pocci' set @Email = 'CoachPoach@yahoo.com' set @Password = 'X12*' + 'CoachPoach' set @SwimmerFirstName = 'Eva' set @SwimmerLastName = 'Pocci' set @BirthDate = '07/13/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Helena' set @ParentLastName = 'Roberts' set @Email = 'happymama1@gmail.com' set @Password = 'X12*' + 'happymama1' set @SwimmerFirstName = 'Gardenia' set @SwimmerLastName = 'Roberts' set @BirthDate = '10/15/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kerri' set @ParentLastName = 'Robinson' set @Email = 'kerri.o''rourke-robins@rich.frb.org' set @Password = 'X12*' + 'kerri.o''rourke-robins' set @SwimmerFirstName = 'Molly' set @SwimmerLastName = 'Robinson' set @BirthDate = '02/08/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Elizabeth' set @ParentLastName = 'Roop' set @Email = 'eproop78@yahoo.com' set @Password = 'X12*' + 'eproop78' set @SwimmerFirstName = 'Colin' set @SwimmerLastName = 'Roop' set @BirthDate = '12/07/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Teresa' set @ParentLastName = 'Salyers' set @Email = 'tsalyers@carolina.rr.com' set @Password = 'X12*' + 'tsalyers' set @SwimmerFirstName = 'Faith' set @SwimmerLastName = 'Salyers' set @BirthDate = '04/04/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Bridget' set @ParentLastName = 'Scharpenberg' set @Email = 'jbscharpenberg@yahoo.com' set @Password = 'X12*' + 'jbscharpenberg' set @SwimmerFirstName = 'Shaelie' set @SwimmerLastName = 'Scharpenberg' set @BirthDate = '06/18/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rhonda' set @ParentLastName = 'Sloan' set @Email = 'Rhondafit1@hotmail.com' set @Password = 'X12*' + 'Rhondafit1' set @SwimmerFirstName = 'Sarah' set @SwimmerLastName = 'Sloan' set @BirthDate = '06/04/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Alice' set @ParentLastName = 'Stewart' set @Email = 'stewara@gmail.com' set @Password = 'X12*' + 'stewara' set @SwimmerFirstName = 'Katherine' set @SwimmerLastName = 'Stewart' set @BirthDate = '06/25/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Leah' set @ParentLastName = 'Trowbridge' set @Email = 'leah.trowbridge@yahoo.com' set @Password = 'X12*' + 'leah.trowbridge' set @SwimmerFirstName = 'William' set @SwimmerLastName = 'Trowbridge' set @BirthDate = '02/08/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Leah' set @ParentLastName = 'Trowbridge' set @Email = 'leah.trowbridge@yahoo.com' set @Password = 'X12*' + 'leah.trowbridge' set @SwimmerFirstName = 'Grayson' set @SwimmerLastName = 'Trowbridge' set @BirthDate = '07/16/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Renda' set @ParentLastName = 'Van Doren' set @Email = 'thevans5@ren.com' set @Password = 'X12*' + 'thevans5' set @SwimmerFirstName = 'Kilee' set @SwimmerLastName = 'Van Doren' set @BirthDate = '08/08/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tammy' set @ParentLastName = 'Wade' set @Email = 'lake2beach@hotmail.com' set @Password = 'X12*' + 'lake2beach' set @SwimmerFirstName = 'Natalie' set @SwimmerLastName = 'Wade' set @BirthDate = '11/03/1997' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Beth' set @ParentLastName = 'Walker' set @Email = 'elizabeth.walker@carolinas.org' set @Password = 'X12*' + 'elizabeth.walker' set @SwimmerFirstName = 'Drew' set @SwimmerLastName = 'Walker' set @BirthDate = '03/24/1995' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Fleming' set @ParentLastName = 'Wallace' set @Email = 'buyerfleming@aol.com' set @Password = 'X12*' + 'buyerfleming' set @SwimmerFirstName = 'Lilly' set @SwimmerLastName = 'Wallace' set @BirthDate = '05/13/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Fleming' set @ParentLastName = 'Wallace' set @Email = 'buyerfleming@aol.com' set @Password = 'X12*' + 'buyerfleming' set @SwimmerFirstName = 'Ginny' set @SwimmerLastName = 'Wallace' set @BirthDate = '07/20/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lesley' set @ParentLastName = 'Wilson' set @Email = 'piedmontprofessionalplumbing@yahoo.com' set @Password = 'X12*' + 'piedmontprofessionalplumbing' set @SwimmerFirstName = 'Maggie' set @SwimmerLastName = 'Wilson' set @BirthDate = '06/25/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lesley' set @ParentLastName = 'Wilson' set @Email = 'piedmontprofessionalplumbing@yahoo.com' set @Password = 'X12*' + 'piedmontprofessionalplumbing' set @SwimmerFirstName = 'Lance' set @SwimmerLastName = 'Wilson' set @BirthDate = '05/10/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ashley' set @ParentLastName = 'Zeller' set @Email = 'lazeller@yahoo.com' set @Password = 'X12*' + 'lazeller' set @SwimmerFirstName = 'Jillian' set @SwimmerLastName = 'Zeller' set @BirthDate = '07/02/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tracie' set @ParentLastName = 'Zielinski' set @Email = 'tntzielinski@juno.com' set @Password = 'X12*' + 'tntzielinski' set @SwimmerFirstName = 'Zachary' set @SwimmerLastName = 'Zielinski' set @BirthDate = '02/14/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tracie' set @ParentLastName = 'Zielinski' set @Email = 'tntzielinski@juno.com' set @Password = 'X12*' + 'tntzielinski' set @SwimmerFirstName = 'Zane' set @SwimmerLastName = 'Zielinski' set @BirthDate = '06/21/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Charlotte', 34,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)


--Create Swimmer TeamSeason records for Palisades
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = @TeamID
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID,StartDate,EndDate)
select SwimmerID,@TeamSeasonID,'05/15/2011','06/30/2011'
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)