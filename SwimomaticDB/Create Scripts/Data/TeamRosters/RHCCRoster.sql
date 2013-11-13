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

set @TeamID = 4 --RHCC

set @ParentFirstName = 'Carrie' set @ParentLastName = 'Andrews' set @Email = 'pmpmommy@comporium.net' set @Password = 'X12*' + 'pmpmommy' set @SwimmerFirstName = 'Mollie' set @SwimmerLastName = 'Andrews' set @BirthDate = '01/02/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Carrie' set @ParentLastName = 'Andrews' set @Email = 'pmpmommy@comporium.net' set @Password = 'X12*' + 'pmpmommy' set @SwimmerFirstName = 'Preston' set @SwimmerLastName = 'Andrews' set @BirthDate = '07/12/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Carrie' set @ParentLastName = 'Andrews' set @Email = 'pmpmommy@comporium.net' set @Password = 'X12*' + 'pmpmommy' set @SwimmerFirstName = 'Priscilla' set @SwimmerLastName = 'Andrews' set @BirthDate = '10/13/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tim' set @ParentLastName = 'Baldwin' set @Email = 'baldwins@winthrop.edu' set @Password = 'X12*' + 'baldwins' set @SwimmerFirstName = 'Mallory' set @SwimmerLastName = 'Baldwin' set @BirthDate = '08/08/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Maria' set @ParentLastName = 'Batista' set @Email = 'mbatista@unknown.com' set @Password = 'X12*' + 'mbatista' set @SwimmerFirstName = 'Lissette' set @SwimmerLastName = 'Batista' set @BirthDate = '07/02/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Debbie' set @ParentLastName = 'Bennett' set @Email = 'tdcbennett@comporium.net' set @Password = 'X12*' + 'tdcbennett' set @SwimmerFirstName = 'Courtney' set @SwimmerLastName = 'Bennett' set @BirthDate = '04/07/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Troy' set @ParentLastName = 'Bennett' set @Email = 'gillisbennett@comporium.net' set @Password = 'X12*' + 'gillisbennett' set @SwimmerFirstName = 'Gavin' set @SwimmerLastName = 'Bennett' set @BirthDate = '11/14/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Troy' set @ParentLastName = 'Bennett' set @Email = 'gillisbennett@comporium.net' set @Password = 'X12*' + 'gillisbennett' set @SwimmerFirstName = 'Lillian' set @SwimmerLastName = 'Bennett' set @BirthDate = '05/20/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amanda' set @ParentLastName = 'Boone' set @Email = 'ahboone@comporium.net' set @Password = 'X12*' + 'ahboone' set @SwimmerFirstName = 'Grace' set @SwimmerLastName = 'Boone' set @BirthDate = '02/20/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Katie' set @ParentLastName = 'Childers' set @Email = 'angelia.childers@compoium.net' set @Password = 'X12*' + 'angelia.childers' set @SwimmerFirstName = 'Trenton' set @SwimmerLastName = 'Childers' set @BirthDate = '01/10/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Cox' set @Email = 'scox@rbh.com' set @Password = 'X12*' + 'scox' set @SwimmerFirstName = 'Dennis' set @SwimmerLastName = 'Cox' set @BirthDate = '11/21/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Cox' set @Email = 'scox@rbh.com' set @Password = 'X12*' + 'scox' set @SwimmerFirstName = 'Madeline' set @SwimmerLastName = 'Cox' set @BirthDate = '02/20/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jim' set @ParentLastName = 'Crowder' set @Email = 'jim@carolinacargo.com' set @Password = 'X12*' + 'jim' set @SwimmerFirstName = 'Caroline' set @SwimmerLastName = 'Crowder' set @BirthDate = '01/24/1995' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jim' set @ParentLastName = 'Crowder' set @Email = 'jim@carolinacargo.com' set @Password = 'X12*' + 'jim' set @SwimmerFirstName = 'Jay' set @SwimmerLastName = 'Crowder' set @BirthDate = '02/23/1993' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Betsy' set @ParentLastName = 'Curley' set @Email = 'bnccurley@comporium.net' set @Password = 'X12*' + 'bnccurley' set @SwimmerFirstName = 'Kristen' set @SwimmerLastName = 'Curley' set @BirthDate = '01/27/1997' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Michelle' set @ParentLastName = 'Durkee' set @Email = 'thedurkees@comporium.net' set @Password = 'X12*' + 'thedurkees' set @SwimmerFirstName = 'Andrew' set @SwimmerLastName = 'Durkee' set @BirthDate = '11/01/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Michelle' set @ParentLastName = 'Durkee' set @Email = 'thedurkees@comporium.net' set @Password = 'X12*' + 'thedurkees' set @SwimmerFirstName = 'Mary' set @SwimmerLastName = 'Durkee' set @BirthDate = '01/28/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tricia' set @ParentLastName = 'Eddy' set @Email = 'hneddy@comporium.net' set @Password = 'X12*' + 'hneddy' set @SwimmerFirstName = 'Libby' set @SwimmerLastName = 'Eddy' set @BirthDate = '12/03/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tricia' set @ParentLastName = 'Eddy' set @Email = 'hneddy@comporium.net' set @Password = 'X12*' + 'hneddy' set @SwimmerFirstName = 'Maggie' set @SwimmerLastName = 'Eddy' set @BirthDate = '09/11/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Martha' set @ParentLastName = 'Edwards' set @Email = 'MMcEdwards@yahoo.com' set @Password = 'X12*' + 'MMcEdwards' set @SwimmerFirstName = 'Janie' set @SwimmerLastName = 'Edwards' set @BirthDate = '03/01/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'Faulkenberry' set @Email = 'amyfaulkenberry@yahoo.com' set @Password = 'X12*' + 'amyfaulkenberry' set @SwimmerFirstName = 'Cooper' set @SwimmerLastName = 'Faulkenberry' set @BirthDate = '09/11/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Brenda' set @ParentLastName = 'Ghent' set @Email = 'ghentfamily@comporium.net' set @Password = 'X12*' + 'ghentfamily' set @SwimmerFirstName = 'Breanna' set @SwimmerLastName = 'Ghent' set @BirthDate = '01/01/1994' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Andy' set @ParentLastName = 'Gilliland' set @Email = 'paige@comporium.net' set @Password = 'X12*' + 'paige' set @SwimmerFirstName = 'Summer' set @SwimmerLastName = 'Gilliland' set @BirthDate = '11/21/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Paula' set @ParentLastName = 'Gillman' set @Email = 'pgillman@comporium.net' set @Password = 'X12*' + 'pgillman' set @SwimmerFirstName = 'Amanda' set @SwimmerLastName = 'Gillman' set @BirthDate = '07/06/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Shaunna' set @ParentLastName = 'Gowan' set @Email = 'Shaunnagowan@msn.com' set @Password = 'X12*' + 'Shaunnagowan' set @SwimmerFirstName = 'Christina' set @SwimmerLastName = 'Gowan' set @BirthDate = '12/16/1994' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Melinda' set @ParentLastName = 'Green' set @Email = 'Melinda.greene@mac.com' set @Password = 'X12*' + 'Melinda.greene' set @SwimmerFirstName = 'Liz' set @SwimmerLastName = 'Greene' set @BirthDate = '06/17/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Melinda' set @ParentLastName = 'Green' set @Email = 'Melinda.greene@mac.com' set @Password = 'X12*' + 'Melinda.greene' set @SwimmerFirstName = 'Sara' set @SwimmerLastName = 'Greene' set @BirthDate = '09/10/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Crystal' set @ParentLastName = 'Guyton' set @Email = 'cguyton@unknown.com' set @Password = 'X12*' + 'cguyton' set @SwimmerFirstName = 'Caleb' set @SwimmerLastName = 'Guyton' set @BirthDate = '08/16/1996' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Edith' set @ParentLastName = 'Hartis' set @Email = 'edithhartis@hotmail.com' set @Password = 'X12*' + 'edithhartis' set @SwimmerFirstName = 'Audrey' set @SwimmerLastName = 'Hartis' set @BirthDate = '04/17/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Harriett' set @ParentLastName = 'Hartzog' set @Email = 'thehartzogs@comporium.net' set @Password = 'X12*' + 'thehartzogs' set @SwimmerFirstName = 'Cooper' set @SwimmerLastName = 'Hartzog' set @BirthDate = '04/06/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Harriett' set @ParentLastName = 'Hartzog' set @Email = 'thehartzogs@comporium.net' set @Password = 'X12*' + 'thehartzogs' set @SwimmerFirstName = 'Sydney' set @SwimmerLastName = 'Hartzog' set @BirthDate = '12/27/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'Harwell' set @Email = 'wareagle@comporium.net' set @Password = 'X12*' + 'wareagle' set @SwimmerFirstName = 'Emma' set @SwimmerLastName = 'Harwell' set @BirthDate = '07/14/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Parent' set @ParentLastName = 'UNKNOWN' set @Email = 'khelms@unknown.com' set @Password = 'X12*' + 'khelms' set @SwimmerFirstName = 'Katelyn' set @SwimmerLastName = 'Helms' set @BirthDate = '11/11/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mariel' set @ParentLastName = 'Hines' set @Email = 'mariel@hinesite.com' set @Password = 'X12*' + 'mariel' set @SwimmerFirstName = 'Abby' set @SwimmerLastName = 'Hines' set @BirthDate = '06/21/1996' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mariel' set @ParentLastName = 'Hines' set @Email = 'mariel@hinesite.com' set @Password = 'X12*' + 'mariel' set @SwimmerFirstName = 'Audrey' set @SwimmerLastName = 'Hines' set @BirthDate = '08/12/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mariel' set @ParentLastName = 'Hines' set @Email = 'mariel@hinesite.com' set @Password = 'X12*' + 'mariel' set @SwimmerFirstName = 'Kelcey' set @SwimmerLastName = 'Hines' set @BirthDate = '03/27/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rachel' set @ParentLastName = 'Hubbard' set @Email = 'jrhubbard@comporium.net' set @Password = 'X12*' + 'jrhubbard' set @SwimmerFirstName = 'Lanie' set @SwimmerLastName = 'Hubbard' set @BirthDate = '10/09/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Rachel' set @ParentLastName = 'Hubbard' set @Email = 'jrhubbard@comporium.net' set @Password = 'X12*' + 'jrhubbard' set @SwimmerFirstName = 'Sophia' set @SwimmerLastName = 'Hubbard' set @BirthDate = '07/04/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ann' set @ParentLastName = 'Ingram' set @Email = 'ingram@carolinachinchilla.com' set @Password = 'X12*' + 'ingram' set @SwimmerFirstName = 'Brandi' set @SwimmerLastName = 'Ingram' set @BirthDate = '01/30/1997' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Dave' set @ParentLastName = 'Jenkins' set @Email = 'djenkins@unknown.com' set @Password = 'X12*' + 'djenkins' set @SwimmerFirstName = 'Aidan' set @SwimmerLastName = 'Jenkins' set @BirthDate = '10/10/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kim' set @ParentLastName = 'Hope' set @Email = 'jandkhope@gmail.com' set @Password = 'X12*' + 'jandkhope' set @SwimmerFirstName = 'Bailey' set @SwimmerLastName = 'Jensen' set @BirthDate = '10/09/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Margaret' set @ParentLastName = 'Johnson' set @Email = 'mtjblessed@gmail.com' set @Password = 'X12*' + 'mtjblessed' set @SwimmerFirstName = 'Audrey' set @SwimmerLastName = 'Johnson' set @BirthDate = '02/04/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Barry' set @ParentLastName = 'Johnson' set @Email = 'bjohnson@unknown.com' set @Password = 'X12*' + 'bjohnson' set @SwimmerFirstName = 'Barry' set @SwimmerLastName = 'Johnson' set @BirthDate = '07/02/1992' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Knight' set @Email = 'sknight@comporium.net' set @Password = 'X12*' + 'sknight' set @SwimmerFirstName = 'Lanie Jo' set @SwimmerLastName = 'Knight' set @BirthDate = '11/22/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Shannon' set @ParentLastName = 'League' set @Email = 'sleague@rhtc.net' set @Password = 'X12*' + 'sleague' set @SwimmerFirstName = 'Julianne' set @SwimmerLastName = 'League' set @BirthDate = '10/21/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jeff' set @ParentLastName = 'Long' set @Email = 'jblong1@comporium.net' set @Password = 'X12*' + 'jblong1' set @SwimmerFirstName = 'Victoria' set @SwimmerLastName = 'Long' set @BirthDate = '07/07/1995' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Merri' set @ParentLastName = 'Johnson' set @Email = 'mjmartin@rock-hill.k12.sc.us' set @Password = 'X12*' + 'mjmartin' set @SwimmerFirstName = 'Caleb' set @SwimmerLastName = 'Martin' set @BirthDate = '10/13/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Merri' set @ParentLastName = 'Johnson' set @Email = 'mjmartin@rock-hill.k12.sc.us' set @Password = 'X12*' + 'mjmartin' set @SwimmerFirstName = 'Cameron' set @SwimmerLastName = 'Martin' set @BirthDate = '06/16/1999' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Merri' set @ParentLastName = 'Johnson' set @Email = 'mjmartin@rock-hill.k12.sc.us' set @Password = 'X12*' + 'mjmartin' set @SwimmerFirstName = 'Mason' set @SwimmerLastName = 'Martin' set @BirthDate = '04/16/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'McMillan' set @Email = 'aimeemcmillan@bellsouth.net' set @Password = 'X12*' + 'aimeemcmillan' set @SwimmerFirstName = 'Riley' set @SwimmerLastName = 'McMillan' set @BirthDate = '07/12/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Amy' set @ParentLastName = 'McMillan' set @Email = 'aimeemcmillan@bellsouth.net' set @Password = 'X12*' + 'aimeemcmillan' set @SwimmerFirstName = 'Tyler' set @SwimmerLastName = 'McMillan' set @BirthDate = '10/12/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Susie' set @ParentLastName = 'Miller' set @Email = 'Susiemiller@comporium.net' set @Password = 'X12*' + 'Susiemiller' set @SwimmerFirstName = 'John' set @SwimmerLastName = 'Miller' set @BirthDate = '11/14/1994' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jane' set @ParentLastName = 'Modla' set @Email = 'jmodla@familydollar.com' set @Password = 'X12*' + 'jmodla' set @SwimmerFirstName = 'Dorothy Jane' set @SwimmerLastName = 'Modla' set @BirthDate = '02/06/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jane' set @ParentLastName = 'Modla' set @Email = 'jmodla@ci.rock-hill.sc.us' set @Password = 'X12*' + 'jmodla' set @SwimmerFirstName = 'Georgia' set @SwimmerLastName = 'Modla' set @BirthDate = '07/03/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jane' set @ParentLastName = 'Modla' set @Email = 'jmodla@ci.rock-hill.sc.us' set @Password = 'X12*' + 'jmodla' set @SwimmerFirstName = 'Jennings' set @SwimmerLastName = 'Modla' set @BirthDate = '07/03/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Meredith' set @ParentLastName = 'Holmes' set @Email = 'meredithauctions@carolina.rr.com' set @Password = 'X12*' + 'meredithauctions' set @SwimmerFirstName = 'Mason' set @SwimmerLastName = 'Montagna' set @BirthDate = '05/27/1998' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mary Frances' set @ParentLastName = 'Morton' set @Email = 'maryfrancesmorton@yahoo.com' set @Password = 'X12*' + 'maryfrancesmorton' set @SwimmerFirstName = 'Frances' set @SwimmerLastName = 'Morton' set @BirthDate = '04/05/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mia' set @ParentLastName = 'Ouzts' set @Email = 'robert@allyorkcountyhomes.com' set @Password = 'X12*' + 'robert' set @SwimmerFirstName = 'Eleni' set @SwimmerLastName = 'Ouzts' set @BirthDate = '07/06/1999' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Mia' set @ParentLastName = 'Ouzts' set @Email = 'robert@allyorkcountyhomes.com' set @Password = 'X12*' + 'robert' set @SwimmerFirstName = 'Robbie' set @SwimmerLastName = 'Ouzts' set @BirthDate = '09/06/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jill' set @ParentLastName = 'Parsons' set @Email = 'theparsons@comporium.net' set @Password = 'X12*' + 'theparsons' set @SwimmerFirstName = 'Kendall' set @SwimmerLastName = 'Parsons' set @BirthDate = '06/23/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jennifer' set @ParentLastName = 'Perez' set @Email = 'perezfamily01@gmail.com' set @Password = 'X12*' + 'perezfamily01' set @SwimmerFirstName = 'Christopher' set @SwimmerLastName = 'Perez' set @BirthDate = '08/11/2000' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Jennifer' set @ParentLastName = 'Perez' set @Email = 'perezfamily01@gmail.com' set @Password = 'X12*' + 'perezfamily01' set @SwimmerFirstName = 'Tommy' set @SwimmerLastName = 'Perez' set @BirthDate = '02/15/2005' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'nancy' set @ParentLastName = 'Quinn' set @Email = 'nancyq95@gmail.com' set @Password = 'X12*' + 'nancyq95' set @SwimmerFirstName = 'Ethan' set @SwimmerLastName = 'Quinn' set @BirthDate = '09/27/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ximena' set @ParentLastName = 'Railey' set @Email = 'ojosnegros163@hotmail.com' set @Password = 'X12*' + 'ojosnegros163' set @SwimmerFirstName = 'Kyle' set @SwimmerLastName = 'Railey' set @BirthDate = '07/14/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Rains' set @Email = 'krains1@comporium.net' set @Password = 'X12*' + 'krains1' set @SwimmerFirstName = 'Jackson' set @SwimmerLastName = 'Rains' set @BirthDate = '06/13/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Rains' set @Email = 'krains1@comporium.net' set @Password = 'X12*' + 'krains1' set @SwimmerFirstName = 'Jacob' set @SwimmerLastName = 'Rains' set @BirthDate = '08/26/1998' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Dee' set @ParentLastName = 'Reid' set @Email = 'areid@comporium.net' set @Password = 'X12*' + 'areid' set @SwimmerFirstName = 'Christina' set @SwimmerLastName = 'Reid' set @BirthDate = '01/12/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Kerry' set @ParentLastName = 'Reuland' set @Email = 'reuland@comporium.net' set @Password = 'X12*' + 'reuland' set @SwimmerFirstName = 'Madison' set @SwimmerLastName = 'Reuland' set @BirthDate = '02/06/2004' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tracey' set @ParentLastName = 'Reynolds' set @Email = 's.reynolds@wirelessco.net' set @Password = 'X12*' + 's.reynolds' set @SwimmerFirstName = 'Lex' set @SwimmerLastName = 'Reynolds' set @BirthDate = '10/08/2004' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tracey' set @ParentLastName = 'Reynolds' set @Email = 's.reynolds@wirelessco.net' set @Password = 'X12*' + 's.reynolds' set @SwimmerFirstName = 'Zan' set @SwimmerLastName = 'Reynolds' set @BirthDate = '02/01/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Suzanne' set @ParentLastName = 'Blanken' set @Email = 'suzanne.blanken@gmail.com' set @Password = 'X12*' + 'suzanne.blanken' set @SwimmerFirstName = 'Maurilio' set @SwimmerLastName = 'Saddoud' set @BirthDate = '02/04/2001' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Donna' set @ParentLastName = 'Stevenson' set @Email = 'dstevenson@comporium.net' set @Password = 'X12*' + 'dstevenson' set @SwimmerFirstName = 'Mathew' set @SwimmerLastName = 'Stevenson' set @BirthDate = '09/13/1996' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Tamm' set @ParentLastName = 'Stickland' set @Email = 'tstrickland@carolinaingrediants.com' set @Password = 'X12*' + 'tstrickland' set @SwimmerFirstName = 'Ivan' set @SwimmerLastName = 'Stickland' set @BirthDate = '06/16/2003' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Caroline' set @ParentLastName = 'Strait' set @Email = 'caroline.strait@carolinashealthcare.org' set @Password = 'X12*' + 'caroline.strait' set @SwimmerFirstName = 'Rachel' set @SwimmerLastName = 'Strait' set @BirthDate = '06/22/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Joan' set @ParentLastName = 'Sullivan' set @Email = 'vetro@comporium.net' set @Password = 'X12*' + 'vetro' set @SwimmerFirstName = 'Brianne' set @SwimmerLastName = 'Sullivan' set @BirthDate = '10/12/1994' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Joan' set @ParentLastName = 'Sullivan' set @Email = 'vetro@comporium.net' set @Password = 'X12*' + 'vetro' set @SwimmerFirstName = 'Kathleen' set @SwimmerLastName = 'Sullivan' set @BirthDate = '12/14/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Heather' set @ParentLastName = 'Suskin' set @Email = 'gregheath@comporium.net' set @Password = 'X12*' + 'gregheath' set @SwimmerFirstName = 'Haley' set @SwimmerLastName = 'Suskin' set @BirthDate = '12/18/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Heather' set @ParentLastName = 'Suskin' set @Email = 'gregheath@comporium.net' set @Password = 'X12*' + 'gregheath' set @SwimmerFirstName = 'Rachel' set @SwimmerLastName = 'Suskin' set @BirthDate = '11/09/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Velma' set @ParentLastName = 'Taromina' set @Email = 'vvtaormina@comporium.net' set @Password = 'X12*' + 'vvtaormina' set @SwimmerFirstName = 'Briana' set @SwimmerLastName = 'Taormina' set @BirthDate = '05/17/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Thomas' set @Email = 'lthomas@unknown.com' set @Password = 'X12*' + 'lthomas' set @SwimmerFirstName = 'Abbey' set @SwimmerLastName = 'Thomas' set @BirthDate = '04/07/2002' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Lisa' set @ParentLastName = 'Thomas' set @Email = 'lthomas@unknown.com' set @Password = 'X12*' + 'lthomas' set @SwimmerFirstName = 'Anna' set @SwimmerLastName = 'Thomas' set @BirthDate = '10/22/1998' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Cindi' set @ParentLastName = 'Venables' set @Email = 'jvenable@rock-hill.k12.sc.us' set @Password = 'X12*' + 'jvenable' set @SwimmerFirstName = 'Ben' set @SwimmerLastName = 'Venables' set @BirthDate = '09/05/2002' set @IsMale = cast(1 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Cindi' set @ParentLastName = 'Venables' set @Email = 'jvenable@rock-hill.k12.sc.us' set @Password = 'X12*' + 'jvenable' set @SwimmerFirstName = 'Carron' set @SwimmerLastName = 'Venables' set @BirthDate = '09/11/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ann' set @ParentLastName = 'Wellborn' set @Email = 'annjwellborn@comporium.net' set @Password = 'X12*' + 'annjwellborn' set @SwimmerFirstName = 'Anna' set @SwimmerLastName = 'Wellborn' set @BirthDate = '06/08/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Ann' set @ParentLastName = 'Wellborn' set @Email = 'annjwellborn@comporium.net' set @Password = 'X12*' + 'annjwellborn' set @SwimmerFirstName = 'Katherine' set @SwimmerLastName = 'Wellborn' set @BirthDate = '10/22/2001' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Robert' set @ParentLastName = 'Wozniak' set @Email = 'woznis0s@aol.com' set @Password = 'X12*' + 'woznis0s' set @SwimmerFirstName = 'Karen' set @SwimmerLastName = 'Wozniak' set @BirthDate = '10/14/2000' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @ParentFirstName = 'Robert' set @ParentLastName = 'Wozniak' set @Email = 'woznis0s@aol.com' set @Password = 'X12*' + 'woznis0s' set @SwimmerFirstName = 'Nina' set @SwimmerLastName = 'Wozniak' set @BirthDate = '05/22/2003' set @IsMale = cast(0 as bit)
if not exists (select 1 from dbo.SystemUser where Email = @Email)
begin
	insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Rock Hill', 41,newid(), getdate())
	set @SystemUserID = SCOPE_IDENTITY()
end
else
begin
	select @SystemUserID = SystemUserID from dbo.SystemUser where Email = @Email
end
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

--Create Swimmer TeamSeason records for RHCC
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = 4
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID,StartDate,EndDate)
select SwimmerID,@TeamSeasonID,'05/15/2011','06/30/2011'
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)