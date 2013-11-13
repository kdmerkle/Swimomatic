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

set @TeamID = 16 --Landing


set @ParentFirstName = 'Keri' set @ParentLastName = 'Allen' set @Email = 'kagator@att.net' set @Password = 'X12*' + 'kagator' set @SwimmerFirstName = 'Jamie' set @SwimmerLastName = 'Allen' set @BirthDate = '12/11/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Keri' set @ParentLastName = 'Allen' set @Email = 'kagator@att.net' set @Password = 'X12*' + 'kagator' set @SwimmerFirstName = 'Will' set @SwimmerLastName = 'Allen' set @BirthDate = '12/11/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Phuong' set @ParentLastName = 'Amiel' set @Email = 'victoriaamiel10@hotmail.com' set @Password = 'X12*' + 'victoriaamiel10' set @SwimmerFirstName = 'Victoria' set @SwimmerLastName = 'Amiel' set @BirthDate = '2/15/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Casey ' set @ParentLastName = 'Augustine' set @Email = 'sixaugustines@hotmail.com' set @Password = 'X12*' + 'sixaugustines' set @SwimmerFirstName = 'Cayla' set @SwimmerLastName = 'Augustine' set @BirthDate = '11/18/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa ' set @ParentLastName = 'Barrett' set @Email = 'lbarrett002@carolina.rr.com' set @Password = 'X12*' + 'lbarrett002' set @SwimmerFirstName = 'Riley' set @SwimmerLastName = 'Barrett ' set @BirthDate = '12/4/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa ' set @ParentLastName = 'Barrett' set @Email = 'lbarrett002@carolina.rr.com' set @Password = 'X12*' + 'lbarrett002' set @SwimmerFirstName = 'Drake' set @SwimmerLastName = 'Barrett ' set @BirthDate = '10/12/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Barrett' set @Email = 'lbarrett002@carolina.rr.com' set @Password = 'X12*' + 'lbarrett002' set @SwimmerFirstName = 'Grant' set @SwimmerLastName = 'Barrett ' set @BirthDate = '5/6/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jennifer ' set @ParentLastName = 'Helton' set @Email = 'jenniferh@bellsouth.net' set @Password = 'X12*' + 'jenniferh' set @SwimmerFirstName = 'Meredith' set @SwimmerLastName = 'Bowman' set @BirthDate = '6/7/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jennifer ' set @ParentLastName = 'Helton' set @Email = 'jenniferh@bellsouth.net' set @Password = 'X12*' + 'jenniferh' set @SwimmerFirstName = 'Christopher' set @SwimmerLastName = 'Bowman' set @BirthDate = '6/7/2001' set @IsMale = cast(1  as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'Bradshaw' set @Email = 'bradshaw@pga.com' set @Password = 'X12*' + 'bradshaw' set @SwimmerFirstName = 'Chad' set @SwimmerLastName = 'Bradshaw' set @BirthDate = '9/7/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'Bradshaw' set @Email = 'bradshaw@pga.com' set @Password = 'X12*' + 'bradshaw' set @SwimmerFirstName = 'Sara-Kate' set @SwimmerLastName = 'Bradshaw' set @BirthDate = '2/22/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'Bradshaw' set @Email = 'bradshaw@pga.com' set @Password = 'X12*' + 'bradshaw' set @SwimmerFirstName = 'Dallas' set @SwimmerLastName = 'Bradshaw' set @BirthDate = '8/9/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura ' set @ParentLastName = 'Brashers' set @Email = 'landsbrash@bellsouth.net' set @Password = 'X12*' + 'landsbrash' set @SwimmerFirstName = 'Amanda' set @SwimmerLastName = 'Brashears' set @BirthDate = '11/8/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura' set @ParentLastName = 'Brashears' set @Email = 'landsbrash@bellsouth.net' set @Password = 'X12*' + 'landsbrash' set @SwimmerFirstName = 'Ashley' set @SwimmerLastName = 'Brashears' set @BirthDate = '5/6/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Noelle' set @ParentLastName = 'Forrest' set @Email = 'noellebrwn@yahoo.com' set @Password = 'X12*' + 'noellebrwn' set @SwimmerFirstName = 'Madison' set @SwimmerLastName = 'Brown' set @BirthDate = '9/20/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Roxanne' set @ParentLastName = 'Bruney' set @Email = 'roxysouthcaralina@live.com' set @Password = 'X12*' + 'roxysouthcaralina' set @SwimmerFirstName = 'Ashley' set @SwimmerLastName = 'Bruney' set @BirthDate = '7/31/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Renee ' set @ParentLastName = 'Carpenter' set @Email = 'rcarpenter@comporium.net' set @Password = 'X12*' + 'rcarpenter' set @SwimmerFirstName = 'Garrett' set @SwimmerLastName = 'Carpenter' set @BirthDate = '4/3/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Renee ' set @ParentLastName = 'Carpenter' set @Email = 'rcarpenter@comporium.net' set @Password = 'X12*' + 'rcarpenter' set @SwimmerFirstName = 'Wil' set @SwimmerLastName = 'Carpenter' set @BirthDate = '6/25/1997' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laurie ' set @ParentLastName = 'McCorkle' set @Email = 'laurie.mccorkle@steritech.com' set @Password = 'X12*' + 'laurie.mccorkle' set @SwimmerFirstName = 'Jarod' set @SwimmerLastName = 'Dollar' set @BirthDate = '1/7/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Stephanie ' set @ParentLastName = 'Galeota' set @Email = 'sgaskinsgaleota@hotmail.com' set @Password = 'X12*' + 'sgaskinsgaleota' set @SwimmerFirstName = 'Addison' set @SwimmerLastName = 'Galeota' set @BirthDate = '7/14/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lee ' set @ParentLastName = 'Garver' set @Email = 'jasonleegarver@bellsouth.net      ' set @Password = 'X12*' + 'jasonleegarver    ' set @SwimmerFirstName = 'Olivia' set @SwimmerLastName = 'Garver' set @BirthDate = '4/8/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lee ' set @ParentLastName = 'Garver' set @Email = 'jasonleegarver@bellsouth.net      ' set @Password = 'X12*' + 'jasonleegarver' set @SwimmerFirstName = 'Morgan' set @SwimmerLastName = 'Garver' set @BirthDate = '7/16/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kelly ' set @ParentLastName = 'Hamilton' set @Email = 'robkellyham@earthlink.net' set @Password = 'X12*' + 'robkellyham' set @SwimmerFirstName = 'Sam' set @SwimmerLastName = 'Hamilton' set @BirthDate = '11/22/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kathy ' set @ParentLastName = 'Hebdon' set @Email = 'kbhebdon@gmail.com' set @Password = 'X12*' + 'kbhebdon' set @SwimmerFirstName = 'Sophie' set @SwimmerLastName = 'Hebbon' set @BirthDate = '11/1/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kathy ' set @ParentLastName = 'Hebdon' set @Email = 'kbhebdon@gmail.com' set @Password = 'X12*' + 'kbhebdon' set @SwimmerFirstName = 'Isabel' set @SwimmerLastName = 'Hebbon' set @BirthDate = '11/14/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Andrea ' set @ParentLastName = 'Hilburn' set @Email = 'Fturner2@att.net' set @Password = 'X12*' + 'Fturner2' set @SwimmerFirstName = 'Amanda' set @SwimmerLastName = 'Hilburn' set @BirthDate = '6/14/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Paige ' set @ParentLastName = 'Howe' set @Email = 'paige.howe@clover.k12.sc.us' set @Password = 'X12*' + 'paige.howe' set @SwimmerFirstName = 'Landon' set @SwimmerLastName = 'Howe' set @BirthDate = '3/30/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Christine' set @ParentLastName = 'Huston' set @Email = 'rtcrhuston@bellsouth.net' set @Password = 'X12*' + 'rtcrhuston' set @SwimmerFirstName = 'Bella' set @SwimmerLastName = 'Huston' set @BirthDate = '11/18/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Christine ' set @ParentLastName = 'Huston' set @Email = 'rtcrhuston@bellsouth.net' set @Password = 'X12*' + 'rtcrhuston' set @SwimmerFirstName = 'Grace' set @SwimmerLastName = 'Huston' set @BirthDate = '9/13/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa ' set @ParentLastName = 'Jubenville' set @Email = 'volsx4@yahoo.com' set @Password = 'X12*' + 'volsx4' set @SwimmerFirstName = 'Payton' set @SwimmerLastName = 'Jubenville' set @BirthDate = '12/7/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa ' set @ParentLastName = 'Jubenville' set @Email = 'volsx4@yahoo.com' set @Password = 'X12*' + 'volsx4' set @SwimmerFirstName = 'Lauren' set @SwimmerLastName = 'Jubenville' set @BirthDate = '2/20/1997' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Caryn ' set @ParentLastName = 'Kerkman' set @Email = 'carynkerkman@bellsouth.net' set @Password = 'X12*' + 'carynkerkman' set @SwimmerFirstName = 'Jenna' set @SwimmerLastName = 'Kerkman' set @BirthDate = '3/23/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Caryn ' set @ParentLastName = 'Kerkman' set @Email = 'carynkerkman@bellsouth.net' set @Password = 'X12*' + 'carynkerkman' set @SwimmerFirstName = 'Julie' set @SwimmerLastName = 'Kerkman' set @BirthDate = '3/23/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Randi' set @ParentLastName = 'Killelea' set @Email = 'killelear@bellsouth.net' set @Password = 'X12*' + 'killelear' set @SwimmerFirstName = 'Katie' set @SwimmerLastName = 'Killelea' set @BirthDate = '4/21/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Randi' set @ParentLastName = 'Killelea' set @Email = 'killelear@bellsouth.net' set @Password = 'X12*' + 'killelear' set @SwimmerFirstName = 'Abbey' set @SwimmerLastName = 'Killelea' set @BirthDate = '1/14/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Randi' set @ParentLastName = 'Killelea' set @Email = 'killelear@bellsouth.net' set @Password = 'X12*' + 'killelear' set @SwimmerFirstName = 'Jack' set @SwimmerLastName = 'Killelea' set @BirthDate = '8/21/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kathryn' set @ParentLastName = 'Kilpatrick' set @Email = 'kilpatrickkathry@bellsouth.net' set @Password = 'X12*' + 'kilpatrickkathry' set @SwimmerFirstName = 'Connor' set @SwimmerLastName = 'Kilpatrick' set @BirthDate = '2/13/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Susan ' set @ParentLastName = 'Maddie' set @Email = 'smaddie@comporium.net' set @Password = 'X12*' + 'smaddie' set @SwimmerFirstName = 'Brooke' set @SwimmerLastName = 'Maddie' set @BirthDate = '10/5/1995' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Pattie ' set @ParentLastName = 'Maier' set @Email = 'pmaier@carolina.rr.com' set @Password = 'X12*' + 'pmaier' set @SwimmerFirstName = 'Caroline' set @SwimmerLastName = 'Maier' set @BirthDate = '5/8/1995' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Maite ' set @ParentLastName = 'Mandakovic' set @Email = 'maite_mandakovic@hotmail.com' set @Password = 'X12*' + 'maite_mandakovic' set @SwimmerFirstName = 'Maite' set @SwimmerLastName = 'Mandakovic' set @BirthDate = '5/5/2005' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Maite ' set @ParentLastName = 'Mandakovic' set @Email = 'maite_mandakovic@hotmail.com' set @Password = 'X12*' + 'maite_mandakovic' set @SwimmerFirstName = 'Lukas' set @SwimmerLastName = 'Mandakovic' set @BirthDate = '9/11/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mead' set @ParentLastName = 'Jennifer' set @Email = 'jennifer.meads.jm@gmail.com' set @Password = 'X12*' + 'jennifer.meads.jm' set @SwimmerFirstName = 'Alex' set @SwimmerLastName = 'Mead' set @BirthDate = '10/18/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Sherr' set @ParentLastName = 'Miller' set @Email = 'sherrimartin63@yahoo.com' set @Password = 'X12*' + 'sherrimartin63' set @SwimmerFirstName = 'Meagan' set @SwimmerLastName = 'Martin' set @BirthDate = '10/3/1995' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tamara' set @ParentLastName = 'McBride' set @Email = 'zigcrom@comporium.net' set @Password = 'X12*' + 'zigcrom' set @SwimmerFirstName = 'Samantha' set @SwimmerLastName = 'McBride' set @BirthDate = '12/6/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Aimee ' set @ParentLastName = 'Onoszko' set @Email = 'aonoszko@bellsouth.net' set @Password = 'X12*' + 'aonoszko' set @SwimmerFirstName = 'Carson' set @SwimmerLastName = 'Onoszko' set @BirthDate = '9/14/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Aimee ' set @ParentLastName = 'Onoszko' set @Email = 'aonoszko@bellsouth.net' set @Password = 'X12*' + 'aonoszko' set @SwimmerFirstName = 'Oscar' set @SwimmerLastName = 'Onoszko' set @BirthDate = '10/6/1998' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Susan ' set @ParentLastName = 'Phillips' set @Email = 'sphillips102003@yahoo.com' set @Password = 'X12*' + 'sphillips102003' set @SwimmerFirstName = 'Jessica' set @SwimmerLastName = 'Phillips' set @BirthDate = '7/14/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Susan ' set @ParentLastName = 'Phillips' set @Email = 'sphillips102003@yahoo.com' set @Password = 'X12*' + 'sphillips102003' set @SwimmerFirstName = 'Jordan' set @SwimmerLastName = 'Phillips' set @BirthDate = '6/26/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rachel ' set @ParentLastName = 'Ringler' set @Email = 'rringler@carolina.rr.com' set @Password = 'X12*' + 'rringler' set @SwimmerFirstName = 'Caroline' set @SwimmerLastName = 'Ringler' set @BirthDate = '5/31/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rachel ' set @ParentLastName = 'Ringler' set @Email = 'rringler@carolina.rr.com' set @Password = 'X12*' + 'rringler' set @SwimmerFirstName = 'David' set @SwimmerLastName = 'Ringler' set @BirthDate = '7/10/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura ' set @ParentLastName = 'Robinson' set @Email = 'kendanproperties@yahoo.com' set @Password = 'X12*' + 'kendanproperties' set @SwimmerFirstName = 'Kennedy' set @SwimmerLastName = 'Robinson' set @BirthDate = '3/11/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura ' set @ParentLastName = 'Robinson' set @Email = 'kendanproperties@yahoo.com' set @Password = 'X12*' + 'kendanproperties' set @SwimmerFirstName = 'Jordan Lee' set @SwimmerLastName = 'Robinson' set @BirthDate = '3/11/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura' set @ParentLastName = 'Chris ' set @Email = 'laura_self@yahoo.com' set @Password = 'X12*' + 'laura_self' set @SwimmerFirstName = 'Hannah' set @SwimmerLastName = 'Self' set @BirthDate = '5/1/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Laura' set @ParentLastName = 'Chris' set @Email = 'laura_self@yahoo.com' set @Password = 'X12*' + 'laura_self' set @SwimmerFirstName = 'Nathan' set @SwimmerLastName = 'Self' set @BirthDate = '7/16/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Karen' set @ParentLastName = 'Shuler' set @Email = 'lifestylept@bellsouth.net' set @Password = 'X12*' + 'lifestylept' set @SwimmerFirstName = 'David' set @SwimmerLastName = 'Shuler' set @BirthDate = '9/14/1997' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Karen' set @ParentLastName = 'Shuler' set @Email = 'lifestylept@bellsouth.net' set @Password = 'X12*' + 'lifestylept' set @SwimmerFirstName = 'Derick "Braxton"' set @SwimmerLastName = 'Shuler' set @BirthDate = '12/9/1994' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Alice ' set @ParentLastName = 'Smith' set @Email = 'zachspack@aol.com' set @Password = 'X12*' + 'zachspack' set @SwimmerFirstName = 'Garrett' set @SwimmerLastName = 'Smith' set @BirthDate = '9/16/1996' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Alice ' set @ParentLastName = 'Smith' set @Email = 'zachspack@aol.com' set @Password = 'X12*' + 'zachspack' set @SwimmerFirstName = 'Patrick' set @SwimmerLastName = 'Smith' set @BirthDate = '9/16/1996' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Nicole' set @ParentLastName = 'Smith' set @Email = 'nicsmith1@bellsouth.net' set @Password = 'X12*' + 'nicsmith1' set @SwimmerFirstName = 'Sydney' set @SwimmerLastName = 'Smith' set @BirthDate = '4/14/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Nicole' set @ParentLastName = 'Smith' set @Email = 'nicsmith1@bellsouth.net' set @Password = 'X12*' + 'nicsmith1' set @SwimmerFirstName = 'Dylan' set @SwimmerLastName = 'Smith' set @BirthDate = '8/19/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Martha' set @ParentLastName = 'Spurrier' set @Email = 'queenma@hotmail.com' set @Password = 'X12*' + 'queenma' set @SwimmerFirstName = 'Sydney' set @SwimmerLastName = 'Spurrier' set @BirthDate = '11/18/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kathryn ' set @ParentLastName = 'Stabell' set @Email = 'kathryn.Stabell@gmail.com' set @Password = 'X12*' + 'kathryn.Stabell' set @SwimmerFirstName = 'Carson' set @SwimmerLastName = 'Stabell' set @BirthDate = '4/23/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kathryn ' set @ParentLastName = 'Stabell' set @Email = 'kathryn.Stabell@gmail.com' set @Password = 'X12*' + 'kathryn.Stabell' set @SwimmerFirstName = 'Jessica' set @SwimmerLastName = 'Stabell' set @BirthDate = '12/6/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Beth ' set @ParentLastName = 'Wedge' set @Email = 'tmacksc@yahoo.com' set @Password = 'X12*' + 'tmacksc' set @SwimmerFirstName = 'Taylor' set @SwimmerLastName = 'Wedge' set @BirthDate = '7/29/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amanda ' set @ParentLastName = 'Winter' set @Email = 'amandawinter@bellsouth.net' set @Password = 'X12*' + 'amandawinter' set @SwimmerFirstName = 'Chase' set @SwimmerLastName = 'Winter' set @BirthDate = '10/5/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amanda ' set @ParentLastName = 'Winter' set @Email = 'amandawinter@bellsouth.net' set @Password = 'X12*' + 'amandawinter' set @SwimmerFirstName = 'Jack' set @SwimmerLastName = 'Winter' set @BirthDate = '7/6/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amanda ' set @ParentLastName = 'Winter' set @Email = 'amandawinter@bellsouth.net' set @Password = 'X12*' + 'amandawinter' set @SwimmerFirstName = 'Ryan' set @SwimmerLastName = 'Winter' set @BirthDate = '7/30/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 0,@Email,'Lake Wylie', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

--Create Swimmer TeamSeason records for Landing
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = 16
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID,StartDate,EndDate)
select SwimmerID,@TeamSeasonID,'05/15/2011','06/30/2011'
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)