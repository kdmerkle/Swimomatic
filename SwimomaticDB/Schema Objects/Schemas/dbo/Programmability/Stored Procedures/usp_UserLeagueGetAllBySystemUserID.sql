
if exists (select * from sysobjects where type = 'P' and name = 'usp_UserLeagueGetAllBySystemUserID')
	begin
	    drop procedure dbo.usp_UserLeagueGetAllBySystemUserID
	end
go

create procedure dbo.usp_UserLeagueGetAllBySystemUserID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_UserLeagueGetAllBySystemUserID
 
 Description:		Selects a UserLeague record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/19/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the UserLeague Entity
 The Entity expects the following properties to be returned:
   LeagueID < System.Int32 >
   SystemUserID < System.Int32 >
   UserLeagueID < System.Int32 >
 ********************************************************************************************************/
 @SystemUserID int

as
	select
		 LeagueID
		,SystemUserID
		,UserLeagueID
	from dbo.UserLeague
	where
		SystemUserID = @SystemUserID
		
go

