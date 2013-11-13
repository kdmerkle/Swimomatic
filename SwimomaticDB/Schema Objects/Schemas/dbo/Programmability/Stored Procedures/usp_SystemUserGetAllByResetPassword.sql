
if exists (select * from sysobjects where type = 'P' and name = 'usp_SystemUserGetAllByResetPassword')
	begin
	    drop procedure dbo.usp_SystemUserGetAllByResetPassword
	end
go

create procedure dbo.usp_SystemUserGetAllByResetPassword
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SystemUserGetAllByResetPassword
 
 Description:		Selects a SystemUser record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 6/5/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the SystemUser Entity
 The Entity expects the following properties to be returned:
   IsActive < System.Boolean >
   Password < System.String >
   SystemUserID < System.Int32 >
   UserName < System.String >
   ResetPassword < System.Boolean >
   RegistrationKey < System.Guid >
   Email < System.String >
   CreateDate < System.DateTime >
   LastName < System.String >
   FirstName < System.String >
   City < System.String >
   RegionID < System.Int32 >
 ********************************************************************************************************/

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
	where su.ResetPassword = 1
		
go
