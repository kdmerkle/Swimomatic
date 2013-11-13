
if exists (select * from sysobjects where type = 'P' and name = 'usp_UserTeamGetAllBySystemUserID')
	begin
	    drop procedure dbo.usp_UserTeamGetAllBySystemUserID
	end
go

create procedure dbo.usp_UserTeamGetAllBySystemUserID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_UserTeamGetAllBySystemUserID
 
 Description:		Selects a UserTeam record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/19/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the UserTeam Entity
 The Entity expects the following properties to be returned:
   SystemUserID < System.Int32 >
   TeamID < System.Int32 >
   UserTeamID < System.Int32 >
 ********************************************************************************************************/
 @SystemUserID int

as
	select
		 SystemUserID
		,TeamID
		,UserTeamID
	from dbo.UserTeam
	where
		SystemUserID = @SystemUserID
		
go
