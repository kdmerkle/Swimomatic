
if exists (select * from sysobjects where type = 'P' and name = 'usp_ScoringSchemeGet')
	begin
	    drop procedure dbo.usp_ScoringSchemeGet
	end
go

create procedure dbo.usp_ScoringSchemeGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ScoringSchemeGet
 
 Description:		Selects a ScoringScheme record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/10/2011  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @ScoringSchemeID int

as
	select
		 [Description]
		,IndividualPoints
		,IsUSASwimming
		,LaneCount
		,RelayPoints
		,ScoringEventTypeID
		,ScoringSchemeID
	from dbo.ScoringScheme
	where ScoringSchemeID = @ScoringSchemeID
		
go

