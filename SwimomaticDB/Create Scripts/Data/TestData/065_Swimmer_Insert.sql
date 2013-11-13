
/*
  SELECT 'insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values(''' +
		FirstName + ''',''' +
        LastName + ''',''' +
        convert(varchar(25),BirthDate,101) + ''','+
        cast(IsMale as char(1)) + ')'
  FROM [dbo].[Swimmer]
  order by IsMale,[BirthDate]
*/

if not exists(select 1 from dbo.Swimmer )
	begin
	
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Amber','Apton','04/10/1992',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alice','Buson','06/10/1992',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Becky','Warren','08/10/1992',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Candy','Houser','09/10/1992',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Katie','Enson','04/15/1993',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Laura','Sommer','06/15/1993',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Lynn','Ellis','07/15/1993',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Emily','Butler','07/15/1993',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Emma','Lee','01/15/1994',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Isabella','Long','02/15/1994',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Madison','Martin','06/15/1994',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Olivia','Brown','09/15/1994',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Sophia','Roy','06/15/1995',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Elizabeth','Tremblay','06/15/1995',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Chloe','McGraw','06/15/1995',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Natalie','Gagnon','06/15/1995',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Ava','Rodriguez','06/15/1996',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Abigail','Wilson','07/15/1996',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Samantha','Martinez','10/15/1996',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Addison','Thomas','01/15/1996',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Mia','Thomas','06/15/1997',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alexis','Moore','07/15/1997',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alyssa','Martin','10/15/1997',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Hannah','Jackson','01/15/1997',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Ashley','Thompson','06/15/1998',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Ella','White','07/15/1998',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Sarah','Lee','10/15/1998',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Grace','Harris','01/15/1998',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Brianna','Clark','06/15/1999',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Lily','Robinson','07/15/1999',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Hailey','Walker','10/15/1999',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Anna','Hall','01/15/1999',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Victoria','Young','06/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Kayla','Allen','07/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Lillian','Wright','10/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Lauren','King','01/15/2000',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Kaylee','Scott','06/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Allison','Green','07/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Savannah','Baker','10/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Gabriella','Adams','01/15/2000',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Julia','Nelson','06/15/2001',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Audrey','Hill','07/15/2001',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Morgan','Campbell','10/15/2001',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alexa','Mitchell','01/15/2001',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Brooke','Roberts','06/15/2002',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Evelyn','Carter','07/15/2002',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Madeline','Phillips','10/15/2002',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Kimberly','Evans','01/15/2002',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Zoe','Turner','06/15/2003',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alexandra','Torres','07/15/2003',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Claire','Parker','10/15/2003',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Maria','Collins','01/15/2003',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Arianna','Edwards','06/15/2004',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jocelyn','Stewart','07/15/2004',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Amelia','Morris','10/15/2004',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Angelina','Murphy','01/15/2004',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Andrea','Rivera','06/15/2005',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Maya','Cook','07/15/2005',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Mackenzie','Rogers','10/15/2005',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Arianna','Morgan','01/15/2005',0)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Valerie','Peterson','06/15/2000',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Rachel','Cooper','07/15/2001',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Vanessa','Reed','10/15/2002',0)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jennifer','Bailey','01/15/2003',0)

--Boys

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jacob','Richardson','06/15/1992',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Ethan','Cox','07/15/1992',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Michael','Howard','10/15/1992',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Alexander','Ward','01/15/1992',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('William','Torres','06/15/1993',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Joshua','Peterson','07/15/1993',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Daniel','Gray','10/15/1993',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jayden','Ramirez','01/15/1993',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Noah','James','06/15/1994',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Anthony','Watson','07/15/1994',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Christopher','Brooks','10/15/1994',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Aiden','Kelly','01/15/1994',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Matthew','Sanders','06/15/1995',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('David','Price','07/15/1995',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Andrew','Bennett','10/15/1995',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Joseph','Wood','01/15/1995',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Logan','Barnes','06/15/1996',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('James','Ross','07/15/1996',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Ryan','Henderson','10/15/1996',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Benjamin','Coleman','01/15/1996',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Elijah','Jenkins','06/15/1997',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Gabriel','Perry','07/15/1997',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Christian','Powell','10/15/1997',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Nathan','Long','01/15/1997',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jackson','Patterson','06/15/1998',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('John','Hughes','07/15/1998',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Samuel','Flores','10/15/1998',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Tyler','Washington','01/15/1998',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Dylan','Butler','06/15/1999',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jonathan','Simmons','07/15/1999',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Nicholas','Foster','10/15/1999',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Gavin','Gonzales','01/15/1999',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Mason','Bryant','06/15/2000',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Evan','Alexander','07/15/2000',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Landon','Russell','10/15/2000',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Lucas','Griffin','01/15/2000',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Steve','Mason','08/30/2001',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Mike','Jones','08/30/2001',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Joey','Smith','10/20/2001',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jack','Edwards','10/20/2001',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Isaac','Diaz','06/15/2002',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Isaiah','Hayes','07/15/2002',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jack','Johnson','10/15/2002',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jose','Williams','01/15/2002',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Kevin','Jones','06/15/2003',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Jordan','Brown','07/15/2003',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Justin','Davis','10/15/2003',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Brayden','Miller','01/15/2003',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Luke','Wilson','06/15/2004',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Liam','Moore','07/15/2004',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Carter','Taylor','10/15/2004',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Owen','Anderson','01/15/2004',1)

insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Connor','Thomas','06/15/2005',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Zachary','Jackson','07/15/2005',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Aaron','White','10/15/2005',1)
insert into dbo.Swimmer(FirstName,LastName,BirthDate,IsMale) values('Robert','Harris','01/15/2005',1)


end

