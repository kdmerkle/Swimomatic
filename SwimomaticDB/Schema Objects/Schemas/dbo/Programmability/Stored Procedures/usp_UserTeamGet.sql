
if exists (select * from sysobjects where type = 'P' and name = 'usp_UserTeamGet')
	begin
	    drop procedure dbo.usp_UserTeamGet
	end
go

create procedure dbo.usp_UserTeamGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_UserTeamGet
 
 Description:		Selects a UserTeam record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/9/2010  Original Release - Generated by LAAF
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
 @UserTeamID int

as
	select
		 SystemUserID
		,TeamID
		,UserTeamID
	from dbo.UserTeam
	where
		UserTeamID = @UserTeamID
		
go

