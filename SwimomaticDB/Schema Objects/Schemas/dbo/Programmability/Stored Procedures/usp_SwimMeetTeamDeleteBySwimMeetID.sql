
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimMeetTeamDeleteBySwimMeetID')
	begin
	    drop procedure dbo.usp_SwimMeetTeamDeleteBySwimMeetID
	end
go

create procedure dbo.usp_SwimMeetTeamDeleteBySwimMeetID
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimMeetTeamDeleteBySwimMeetID
 
 Description:		Selects a SwimMeetTeam record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/19/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @SwimMeetID int

as
	delete
	from dbo.SwimMeetTeam
	where SwimMeetID = @SwimMeetID
		
go
