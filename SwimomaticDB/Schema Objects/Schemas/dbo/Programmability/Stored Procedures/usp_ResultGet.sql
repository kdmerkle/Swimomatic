
if exists (select * from sysobjects where type = 'P' and name = 'usp_ResultGet')
	begin
	    drop procedure dbo.usp_ResultGet
	end
go

create procedure dbo.usp_ResultGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ResultGet
 
 Description:		Selects a Result record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/1/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the Result Entity
 The Entity expects the following properties to be returned:
   AgeClassID < System.Int32 >
   Disqualified < System.Boolean >
   Distance < System.Int32 >
   ElapsedTime < System.Double >
   HeatSwimmerID < System.Int32 >
   LaneLength < System.Int32 >
   Penalty < System.Double >
   ResultID < System.Int32 >
   StrokeID < System.Int32 >
   SwimmerID < System.Int32 >
   UOMID < System.Int32 >
   EventDate < System.DateTime >
   TeamSeasonID < System.Int32 >
 ********************************************************************************************************/
 @ResultID int

as
	select
		 r.AgeClassID
		,r.CreatedByUserID
		,r.CreatedDate
		,r.Disqualified
		,r.Distance
		,r.ElapsedTime
		,r.EventDate
		,r.HeatSwimmerID
		,r.IsCertified
		,r.IsProtested
		,r.LaneLength
		,r.ModifiedByUserID
		,r.ModifiedDate
		,r.Place
		,r.Points
		,r.ResultID
		,r.ScoringSchemeID
		,r.Split
		,r.StrokeID
		,r.SwimmerID
		,r.SwimmerTeamSeasonID
		,r.TeamSeasonID
		,r.UOMID
	from dbo.Result r
	where r.ResultID = @ResultID
		
go

