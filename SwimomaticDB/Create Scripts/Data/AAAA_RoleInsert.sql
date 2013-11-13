if not exists(select 1 from dbo.Role)
begin
	insert into dbo.Role(RoleID,RoleName,Description, IsActive) values(-1,'SysAdminRole','Can Access all parts of the application.  This role cannot be deleted.',1)
	insert into dbo.Role(RoleID,RoleName,Description, IsActive) values(2,'LeagueAdminRole','Can access the League page',1)
	insert into dbo.Role(RoleID,RoleName,Description, IsActive) values(3,'TeamAdminRole','Can access the Team admin page',1)
	insert into dbo.Role(RoleID,RoleName,Description, IsActive) values(4,'MeetAdminRole','Can access the Meet admin page',1)
	insert into dbo.Role(RoleID,RoleName,Description, IsActive) values(5,'ParentRole','Can access the Swimmer admin page',1)

end 

if not exists(select 1 from dbo.Profile)
begin
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(-1,'SysAdminProfile','Can Access all data.  This profile cannot be deleted.',1)
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(2,'LeagueAdminProfile','Can create, edit and delete leagues.',1)
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(3,'TeamAdminProfile','Can create, edit and delete teams.',1)
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(4,'MeetAdminProfile','Can create and edit meets.',1)
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(5,'ParentProfile','Can create and edit swimmers.  Only a parent has access to swimmer personal data.',1)
	insert into dbo.Profile(ProfileID,ProfileName,Description, IsActive) values(6,'SwimmerProfile','Can view swimmer''s own performance stats',1)
end 
