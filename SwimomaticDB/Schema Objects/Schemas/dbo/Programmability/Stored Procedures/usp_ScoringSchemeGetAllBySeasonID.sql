
if exists (select * from sysobjects where type = 'P' and name = 'usp_ScoringSchemeGetAllBySeasonID')
	begin
	    drop procedure dbo.usp_ScoringSchemeGetAllBySeasonID
	end
go

create procedure dbo.usp_ScoringSchemeGetAllBySeasonID
 /*******************************************************************************************************
 Logical Advantage,ss. LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ScoringSchemeGetAllBySeasonID
 
 Description:		Selects a ScoringScheme record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/11/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @SeasonID int

as
	select
		 ss.[Description]
		,ss.IndividualPoints
		,ss.IsUSASwimming
		,ss.LaneCount
		,ss.RelayPoints
		,ss.ScoringEventTypeID
		,ss.ScoringSchemeID
		,sss.SwimMeetTypeID
	from dbo.ScoringScheme ss
	inner join dbo.SeasonScoringScheme sss on sss.ScoringSchemeID = ss.ScoringSchemeID
	where sss.SeasonID = @SeasonID
		
go

