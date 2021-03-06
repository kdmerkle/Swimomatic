
if exists (select * from sysobjects where type = 'P' and name = 'usp_SystemUserGetByEmail')
	begin
	    drop procedure dbo.usp_SystemUserGetByEmail
	end
go

create procedure dbo.usp_SystemUserGetByEmail
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SystemUserGetByEmail
 
 Description:		Selects a SystemUser record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/10/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @Email varchar(250)

as
	select
		 su.City
		,su.CreateDate
		,su.Email
		,su.FirstName
		,su.IsActive
		,su.LastName
		,su.ModifiedDate
		,su.[Password]
		,su.RegionID
		,su.RegistrationKey
		,su.ResetPassword
		,su.SystemUserID
		,su.TemporaryPassword
		,su.UserName
		,r.RegionAbbrev
	from dbo.SystemUser su
	inner join dbo.Region r on r.RegionID = su.RegionID
	where su.Email = @Email
		
go

