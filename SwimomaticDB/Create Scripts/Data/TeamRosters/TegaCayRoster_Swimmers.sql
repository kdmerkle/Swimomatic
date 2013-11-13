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

set @TeamID = 2 --Tega Cay

set  @ParentFirstName = 'Tega' set @ParentLastName ='Cay' set @Email = 'tegacayswimteam@gmail.com' set @Password = 'X12*tegacayswimteam'
insert into dbo.SystemUser(UserName,[Password],FirstName,LastName,IsActive,ResetPassword,Email,City,RegionID,RegistrationKey,CreateDate) values(@Email,@Password,@ParentFirstName,@ParentLastName,1, 1,@Email,'Tega Cay', 41,newid(), getdate())
set @SystemUserID = SCOPE_IDENTITY()

set @SwimmerLastName = 'Adams ' set @SwimmerFirstName = 'Mary Joline' set @BirthDate = '12/01/2004' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ancevic' set @SwimmerFirstName = 'Alec' set @BirthDate = '07/12/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ancevic' set @SwimmerFirstName = 'Julia' set @BirthDate = '04/18/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Anderson' set @SwimmerFirstName = 'Nicole' set @BirthDate = '03/24/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Anderson ' set @SwimmerFirstName = 'Mitchell' set @BirthDate = '04/26/2005' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Apolloni' set @SwimmerFirstName = 'Chase' set @BirthDate = '04/25/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Apolloni' set @SwimmerFirstName = 'Makenna' set @BirthDate = '01/19/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Axton' set @SwimmerFirstName = 'Jake' set @BirthDate = '10/24/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Axton' set @SwimmerFirstName = 'Macy' set @BirthDate = '12/27/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bambach' set @SwimmerFirstName = 'Alexis' set @BirthDate = '06/14/1998' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bernesser' set @SwimmerFirstName = 'Skylar' set @BirthDate = '08/01/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bernesser' set @SwimmerFirstName = 'Catlynne' set @BirthDate = '07/01/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bick' set @SwimmerFirstName = 'Kylie ' set @BirthDate = '10/16/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Biehl' set @SwimmerFirstName = 'Brighid' set @BirthDate = '09/07/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Biehl' set @SwimmerFirstName = 'Ashland' set @BirthDate = '01/22/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bogucki' set @SwimmerFirstName = 'Noah' set @BirthDate = '02/09/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bogucki' set @SwimmerFirstName = 'Taylor' set @BirthDate = '06/12/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bonner' set @SwimmerFirstName = 'Brynn' set @BirthDate = '02/19/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bonner' set @SwimmerFirstName = 'Brooke' set @BirthDate = '03/03/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Botzenhardt' set @SwimmerFirstName = 'Emma' set @BirthDate = '08/20/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Brong' set @SwimmerFirstName = 'Maddy ' set @BirthDate = '01/31/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Brong' set @SwimmerFirstName = 'Hanna' set @BirthDate = '11/19/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Brown' set @SwimmerFirstName = 'Jack' set @BirthDate = '04/01/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Brown' set @SwimmerFirstName = 'Camryn' set @BirthDate = '01/20/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Brown' set @SwimmerFirstName = 'Abby' set @BirthDate = '09/28/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Bungard' set @SwimmerFirstName = 'Luke' set @BirthDate = '02/17/2005' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Emily' set @BirthDate = '06/17/1998' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Nathan' set @BirthDate = '05/16/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Xavier' set @BirthDate = '02/06/2006' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Jackson' set @BirthDate = '01/10/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Reagan' set @BirthDate = '09/23/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Burt' set @SwimmerFirstName = 'Olivia' set @BirthDate = '09/23/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Carter' set @SwimmerFirstName = 'Myles ' set @BirthDate = '01/16/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Carter' set @SwimmerFirstName = 'Allison ' set @BirthDate = '12/12/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Case' set @SwimmerFirstName = 'Michelle' set @BirthDate = '12/01/1995' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Case' set @SwimmerFirstName = 'Matthew' set @BirthDate = '12/01/1995' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Case' set @SwimmerFirstName = 'Jeffrey' set @BirthDate = '01/03/1994' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Catan' set @SwimmerFirstName = 'Sophia' set @BirthDate = '03/21/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cavanaugh' set @SwimmerFirstName = 'Brian' set @BirthDate = '06/19/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cavanaugh' set @SwimmerFirstName = 'Julia' set @BirthDate = '08/06/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cavanaugh' set @SwimmerFirstName = 'Holly' set @BirthDate = '07/13/1994' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Certo' set @SwimmerFirstName = 'Ryan' set @BirthDate = '01/16/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cessna' set @SwimmerFirstName = 'Grayson' set @BirthDate = '09/05/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cessna' set @SwimmerFirstName = 'Megan' set @BirthDate = '12/04/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Chandler' set @SwimmerFirstName = 'Aubrey' set @BirthDate = '05/13/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Chatham' set @SwimmerFirstName = 'Caleb' set @BirthDate = '12/17/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Chatham' set @SwimmerFirstName = 'Jonah' set @BirthDate = '04/07/2005' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cicciarello' set @SwimmerFirstName = 'Claire' set @BirthDate = '01/02/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cicciarello' set @SwimmerFirstName = 'Sam' set @BirthDate = '01/01/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Conrey' set @SwimmerFirstName = 'Collin' set @BirthDate = '02/02/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Conrey' set @SwimmerFirstName = 'Lexie' set @BirthDate = '07/13/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cordell' set @SwimmerFirstName = 'Levi' set @BirthDate = '11/13/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cordell' set @SwimmerFirstName = 'Benjamin' set @BirthDate = '10/27/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cordell' set @SwimmerFirstName = 'Shiri' set @BirthDate = '07/29/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cordell' set @SwimmerFirstName = 'Davey' set @BirthDate = '05/05/2006' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Corkery' set @SwimmerFirstName = 'Jack' set @BirthDate = '12/05/1997' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Corkery' set @SwimmerFirstName = 'Owen' set @BirthDate = '07/10/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Coston' set @SwimmerFirstName = 'Blake' set @BirthDate = '12/10/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Coston' set @SwimmerFirstName = 'Indira' set @BirthDate = '02/03/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Coughlen' set @SwimmerFirstName = 'Madison' set @BirthDate = '06/26/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Coughlen' set @SwimmerFirstName = 'Morgan' set @BirthDate = '05/05/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cox ' set @SwimmerFirstName = 'Brian ' set @BirthDate = '08/28/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Cox ' set @SwimmerFirstName = 'Ashton' set @BirthDate = '06/11/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Crimi' set @SwimmerFirstName = 'Mallory' set @BirthDate = '07/03/1996' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Crimi' set @SwimmerFirstName = 'Megan' set @BirthDate = '12/18/1992' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Crumly' set @SwimmerFirstName = 'Brianna' set @BirthDate = '03/07/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Crumly' set @SwimmerFirstName = 'Elizabeth' set @BirthDate = '05/19/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Debbout' set @SwimmerFirstName = 'William' set @BirthDate = '03/27/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Debbout' set @SwimmerFirstName = 'Jack' set @BirthDate = '11/16/1997' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Debbout' set @SwimmerFirstName = 'Michael' set @BirthDate = '04/11/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Debbout' set @SwimmerFirstName = 'Henry ' set @BirthDate = '11/29/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'DeRochi' set @SwimmerFirstName = 'Rachel' set @BirthDate = '08/03/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Dippre' set @SwimmerFirstName = 'Alex' set @BirthDate = '09/05/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Dudley' set @SwimmerFirstName = 'Bryn' set @BirthDate = '06/28/1993' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Dunn' set @SwimmerFirstName = 'Noah' set @BirthDate = '07/12/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Dunn' set @SwimmerFirstName = 'Griffin' set @BirthDate = '08/27/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Eldredge' set @SwimmerFirstName = 'Quentin' set @BirthDate = '05/27/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Elia' set @SwimmerFirstName = 'Nicholas' set @BirthDate = '03/23/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Elia' set @SwimmerFirstName = 'Benjamin' set @BirthDate = '04/28/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Everingham' set @SwimmerFirstName = 'Noah' set @BirthDate = '09/12/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fairbanks' set @SwimmerFirstName = 'Lucas' set @BirthDate = '11/11/1996' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fernandez' set @SwimmerFirstName = 'Esmie' set @BirthDate = '06/14/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fernandez' set @SwimmerFirstName = 'Elly' set @BirthDate = '06/12/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Field' set @SwimmerFirstName = 'Michael' set @BirthDate = '08/26/1996' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Field' set @SwimmerFirstName = 'Sarah' set @BirthDate = '08/04/1994' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fitzgibbon' set @SwimmerFirstName = 'Ryan ' set @BirthDate = '05/11/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fitzpatrick' set @SwimmerFirstName = 'Thomas' set @BirthDate = '05/25/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ford' set @SwimmerFirstName = 'Jackson' set @BirthDate = '01/10/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ford' set @SwimmerFirstName = 'Owen' set @BirthDate = '06/06/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Foster' set @SwimmerFirstName = 'Kennedy' set @BirthDate = '08/09/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Foster' set @SwimmerFirstName = 'Alexandra' set @BirthDate = '11/04/2004' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fuller' set @SwimmerFirstName = 'Shelbey' set @BirthDate = '12/08/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fuller' set @SwimmerFirstName = 'Rachel' set @BirthDate = '06/30/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Fuqua' set @SwimmerFirstName = 'Josh' set @BirthDate = '02/17/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Gast' set @SwimmerFirstName = 'Jordan' set @BirthDate = '03/16/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Gerald' set @SwimmerFirstName = 'Joshua' set @BirthDate = '05/29/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Gillespy' set @SwimmerFirstName = 'Christian' set @BirthDate = '09/29/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Gillespy' set @SwimmerFirstName = 'Karoline' set @BirthDate = '06/26/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Gjuraj' set @SwimmerFirstName = 'Marisa' set @BirthDate = '07/25/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Glendening' set @SwimmerFirstName = 'Erin' set @BirthDate = '10/03/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Hall' set @SwimmerFirstName = 'Allyson' set @BirthDate = '08/06/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Harris' set @SwimmerFirstName = 'Jessica' set @BirthDate = '11/08/1997' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Harris' set @SwimmerFirstName = 'Genevieve' set @BirthDate = '10/20/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Heidel' set @SwimmerFirstName = 'Carsyn' set @BirthDate = '09/30/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Hemmingsen' set @SwimmerFirstName = 'Lauren' set @BirthDate = '05/30/1993' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Homchik' set @SwimmerFirstName = 'Kaelin' set @BirthDate = '03/30/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Homchik' set @SwimmerFirstName = 'Braedin' set @BirthDate = '02/25/2005' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Howard' set @SwimmerFirstName = 'Mason' set @BirthDate = '12/13/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Howard' set @SwimmerFirstName = 'Bryanne' set @BirthDate = '10/18/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Huffman' set @SwimmerFirstName = 'Jamie' set @BirthDate = '03/02/1996' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Hummel' set @SwimmerFirstName = 'Nathan' set @BirthDate = '06/03/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Hunter' set @SwimmerFirstName = 'Jacob' set @BirthDate = '01/04/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Hunter' set @SwimmerFirstName = 'Ryan ' set @BirthDate = '11/28/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Johnson' set @SwimmerFirstName = 'Nadia' set @BirthDate = '09/03/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Jones' set @SwimmerFirstName = 'Brandon' set @BirthDate = '04/17/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Jones' set @SwimmerFirstName = 'Delaney' set @BirthDate = '11/19/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Kam' set @SwimmerFirstName = 'Tyler' set @BirthDate = '07/15/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Kerr ' set @SwimmerFirstName = 'Brock ' set @BirthDate = '05/27/1994' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Kershaw' set @SwimmerFirstName = 'Bristol' set @BirthDate = '07/18/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Kershaw' set @SwimmerFirstName = 'Miller ' set @BirthDate = '07/17/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'King' set @SwimmerFirstName = 'Christopher' set @BirthDate = '01/20/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Krenek' set @SwimmerFirstName = 'Kole' set @BirthDate = '10/09/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Krenek' set @SwimmerFirstName = 'Kendall' set @BirthDate = '07/30/1996' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Krenek' set @SwimmerFirstName = 'Kelsey' set @BirthDate = '10/10/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Letterhos' set @SwimmerFirstName = 'Chloe' set @BirthDate = '03/26/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Letterhos' set @SwimmerFirstName = 'Leah' set @BirthDate = '08/27/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Lininger' set @SwimmerFirstName = 'Olivia' set @BirthDate = '04/24/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Little' set @SwimmerFirstName = 'Madison' set @BirthDate = '04/02/1997' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Little ' set @SwimmerFirstName = 'Tucker ' set @BirthDate = '03/11/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Lounsbury' set @SwimmerFirstName = 'Ryan ' set @BirthDate = '10/01/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Mager' set @SwimmerFirstName = 'Matthew' set @BirthDate = '06/10/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Mager' set @SwimmerFirstName = 'Madison' set @BirthDate = '12/09/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Mathews' set @SwimmerFirstName = 'John' set @BirthDate = '03/25/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Mathur' set @SwimmerFirstName = 'Shirley' set @BirthDate = '11/12/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McCaffrey' set @SwimmerFirstName = 'Jack' set @BirthDate = '08/16/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McCaffrey' set @SwimmerFirstName = 'Sean' set @BirthDate = '03/05/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McCarthy' set @SwimmerFirstName = 'Emma ' set @BirthDate = '04/05/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McCarthy' set @SwimmerFirstName = 'Gabrielle' set @BirthDate = '07/18/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McGrath' set @SwimmerFirstName = 'Ava' set @BirthDate = '09/28/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'McGrath' set @SwimmerFirstName = 'Patrick' set @BirthDate = '08/04/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Menchinger' set @SwimmerFirstName = 'John' set @BirthDate = '08/07/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Meyer' set @SwimmerFirstName = 'Raine' set @BirthDate = '05/06/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Michaeli' set @SwimmerFirstName = 'Brielle' set @BirthDate = '08/18/1998' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Michaeli' set @SwimmerFirstName = 'Abbi' set @BirthDate = '04/03/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Miller ' set @SwimmerFirstName = 'Elyse' set @BirthDate = '10/12/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Namowicz' set @SwimmerFirstName = 'Kylie' set @BirthDate = '10/27/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Neill' set @SwimmerFirstName = 'Katie' set @BirthDate = '07/15/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Nosal' set @SwimmerFirstName = 'Chloe' set @BirthDate = '08/19/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Orehek' set @SwimmerFirstName = 'Payton' set @BirthDate = '05/28/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Orehek' set @SwimmerFirstName = 'Joe' set @BirthDate = '06/20/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Orehek' set @SwimmerFirstName = 'Nate' set @BirthDate = '10/24/2005' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Palmer' set @SwimmerFirstName = 'Samantha' set @BirthDate = '07/10/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Pan' set @SwimmerFirstName = 'Gregory' set @BirthDate = '07/16/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Patterson' set @SwimmerFirstName = 'Sierra' set @BirthDate = '08/22/1997' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Pettus ' set @SwimmerFirstName = 'Anna' set @BirthDate = '07/06/1998' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Rapp' set @SwimmerFirstName = 'Ashley' set @BirthDate = '06/01/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ratliff' set @SwimmerFirstName = 'Lexie' set @BirthDate = '11/22/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Reilly' set @SwimmerFirstName = 'Mac' set @BirthDate = '12/17/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Reilly' set @SwimmerFirstName = 'Madelyne' set @BirthDate = '06/25/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Rings' set @SwimmerFirstName = 'Maddie ' set @BirthDate = '06/07/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ruff' set @SwimmerFirstName = 'Brynee' set @BirthDate = '06/18/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Rumierz' set @SwimmerFirstName = 'Ania' set @BirthDate = '08/15/1994' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Russell' set @SwimmerFirstName = 'Julia ' set @BirthDate = '06/18/1996' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Sale' set @SwimmerFirstName = 'Jacob' set @BirthDate = '02/24/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Sale' set @SwimmerFirstName = 'Jackson' set @BirthDate = '10/17/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Sale' set @SwimmerFirstName = 'Benjamin' set @BirthDate = '08/23/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Scales' set @SwimmerFirstName = 'Andrew' set @BirthDate = '02/18/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Scales' set @SwimmerFirstName = 'Elizabeth' set @BirthDate = '09/11/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Schmitt' set @SwimmerFirstName = 'Emily' set @BirthDate = '08/22/1994' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Schreiber' set @SwimmerFirstName = 'Carly' set @BirthDate = '10/08/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Schreiber' set @SwimmerFirstName = 'Willy' set @BirthDate = '10/17/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Scott' set @SwimmerFirstName = 'Noah' set @BirthDate = '08/18/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Scott' set @SwimmerFirstName = 'Mia' set @BirthDate = '12/16/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Shive' set @SwimmerFirstName = 'Nate' set @BirthDate = '12/27/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Shive' set @SwimmerFirstName = 'Lizzie' set @BirthDate = '02/17/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Shouse' set @SwimmerFirstName = 'Miller ' set @BirthDate = '06/20/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Spingola' set @SwimmerFirstName = 'Bryn' set @BirthDate = '03/27/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Spingola' set @SwimmerFirstName = 'Gia' set @BirthDate = '01/23/1998' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Stacy' set @SwimmerFirstName = 'Kathleen' set @BirthDate = '09/04/1997' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Stacy' set @SwimmerFirstName = 'Mary Jane' set @BirthDate = '09/14/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Starnes' set @SwimmerFirstName = 'Ellison' set @BirthDate = '12/20/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Starnes' set @SwimmerFirstName = 'Piper' set @BirthDate = '10/10/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Strohl' set @SwimmerFirstName = 'Malorie' set @BirthDate = '09/08/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Strohl' set @SwimmerFirstName = 'Mason' set @BirthDate = '10/02/1995' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Strong' set @SwimmerFirstName = 'Luke' set @BirthDate = '08/07/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Strong' set @SwimmerFirstName = 'Jackson' set @BirthDate = '08/07/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Sullivan ' set @SwimmerFirstName = 'Nate ' set @BirthDate = '02/22/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Taylor' set @SwimmerFirstName = 'Madison' set @BirthDate = '07/24/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Trotter' set @SwimmerFirstName = 'David' set @BirthDate = '07/13/1998' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Trucksis' set @SwimmerFirstName = 'Meghan' set @BirthDate = '07/31/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Trucksis' set @SwimmerFirstName = 'Jacob' set @BirthDate = '07/23/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Tucker' set @SwimmerFirstName = 'Isobel' set @BirthDate = '09/02/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Tucker' set @SwimmerFirstName = 'Keigan' set @BirthDate = '01/31/2003' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Van Buskirk' set @SwimmerFirstName = 'Julia' set @BirthDate = '09/21/1993' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Van Buskirk' set @SwimmerFirstName = 'Sam' set @BirthDate = '09/21/1993' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Vollmer' set @SwimmerFirstName = 'Andrew' set @BirthDate = '09/06/1999' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Vollmer' set @SwimmerFirstName = 'Allison ' set @BirthDate = '10/17/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wade ' set @SwimmerFirstName = 'Kennedy' set @BirthDate = '02/04/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wade ' set @SwimmerFirstName = 'Harper ' set @BirthDate = '11/12/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wallace' set @SwimmerFirstName = 'Kennedy' set @BirthDate = '05/18/2004' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wallace' set @SwimmerFirstName = 'Carson' set @BirthDate = '02/19/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wallace' set @SwimmerFirstName = 'Parker' set @BirthDate = '10/23/2000' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ward ' set @SwimmerFirstName = 'Sonner' set @BirthDate = '10/07/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ward ' set @SwimmerFirstName = 'Leslie Hope ' set @BirthDate = '03/30/2005' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Webber' set @SwimmerFirstName = 'Theresa' set @BirthDate = '03/17/1999' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Webber' set @SwimmerFirstName = 'Caroline' set @BirthDate = '05/16/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Weddington' set @SwimmerFirstName = 'Sara' set @BirthDate = '01/01/1993' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'White' set @SwimmerFirstName = 'Reagan' set @BirthDate = '11/05/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wilcox' set @SwimmerFirstName = 'Sawyer' set @BirthDate = '03/12/2002' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wilcox' set @SwimmerFirstName = 'Sydney' set @BirthDate = '06/30/2004' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wilson' set @SwimmerFirstName = 'Clay' set @BirthDate = '05/27/2006' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wood' set @SwimmerFirstName = 'Jennah' set @BirthDate = '07/08/1997' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Wood' set @SwimmerFirstName = 'Lauren' set @BirthDate = '10/13/1994' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Yeager' set @SwimmerFirstName = 'Mary Kate' set @BirthDate = '07/19/2002' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Yeager' set @SwimmerFirstName = 'Gregory' set @BirthDate = '04/09/2001' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Zheng' set @SwimmerFirstName = 'Lily' set @BirthDate = '04/07/2000' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ziemer' set @SwimmerFirstName = 'Emma' set @BirthDate = '04/23/2003' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Ziemer' set @SwimmerFirstName = 'Sydney' set @BirthDate = '07/01/2001' set @IsMale = cast(0 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Zilinskas' set @SwimmerFirstName = 'Kasparas' set @BirthDate = '10/09/1997' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)

set @SwimmerLastName = 'Zilinskas' set @SwimmerFirstName = 'Matas' set @BirthDate = '07/20/2004' set @IsMale = cast(1 as bit)
insert into dbo.Swimmer(LastName,FirstName,BirthDate,IsMale) values(@SwimmerLastName,@SwimmerFirstName,@BirthDate,@IsMale)
set @SwimmerID = SCOPE_IDENTITY()
insert into dbo.UserSwimmer(SystemUserID, SwimmerID) values(@SystemUserID,@SwimmerID)



--Create Swimmer TeamSeason records for TegaCay
declare @TeamSeasonID int
select @TeamSeasonID = TeamSeasonID from dbo.TeamSeason where TeamID = @TeamID
insert into dbo.SwimmerTeamSeason(SwimmerID, TeamSeasonID,StartDate,EndDate)
select SwimmerID,@TeamSeasonID,'05/15/2011','06/30/2011'
from dbo.Swimmer
where SwimmerID not in (select SwimmerID from dbo.SwimmerTeamSeason)