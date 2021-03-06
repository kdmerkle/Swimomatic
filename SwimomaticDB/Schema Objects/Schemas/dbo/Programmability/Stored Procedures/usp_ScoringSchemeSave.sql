if exists (select * from sysobjects where type = 'P' and name = 'usp_ScoringSchemeSave')
	begin
	    drop procedure dbo.usp_ScoringSchemeSave
	end
go

create procedure dbo.usp_ScoringSchemeSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_ScoringSchemeSave

 Description:		Saves an ScoringScheme record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 1/10/2011	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @Description varchar(150)
,@IndividualPoints varchar(50)
,@IsUSASwimming bit
,@LaneCount int
,@RelayPoints varchar(50)
,@ScoringEventTypeID int
,@ScoringSchemeID int

as
	declare @InsertedPrimaryKeyTable table (ScoringSchemeID int)
		
	if exists (select 1 from dbo.ScoringScheme where ScoringSchemeID = @ScoringSchemeID)
		begin
			
			update dbo.ScoringScheme
			set
				 Description = @Description
				,IndividualPoints = @IndividualPoints
				,IsUSASwimming = @IsUSASwimming
				,LaneCount = @LaneCount
				,RelayPoints = @RelayPoints
				,ScoringEventTypeID = @ScoringEventTypeID
			output inserted.ScoringSchemeID into @InsertedPrimaryKeyTable
			where ScoringSchemeID = @ScoringSchemeID
		end
	--prevent duplicate Custom Scoring Schemes with same Individual and Relay points
	if exists(	select 1 
				from dbo.ScoringScheme 
				where IndividualPoints = @IndividualPoints 
				and RelayPoints = @RelayPoints
				and IsUSASwimming = 0
				and ScoringEventTypeID = @ScoringEventTypeID)
		begin
			insert into @InsertedPrimaryKeyTable
			select ScoringSchemeID 
			from dbo.ScoringScheme 
			where IndividualPoints = @IndividualPoints 
			and RelayPoints = @RelayPoints
			and IsUSASwimming = 0
			and ScoringEventTypeID = @ScoringEventTypeID
		end
	else
		begin
			insert into dbo.ScoringScheme(
				 Description
				,IndividualPoints
				,IsUSASwimming
				,LaneCount
				,RelayPoints
				,ScoringEventTypeID
			)
			output inserted.ScoringSchemeID into @InsertedPrimaryKeyTable
			values (
				 @Description
				,@IndividualPoints
				,@IsUSASwimming
				,@LaneCount
				,@RelayPoints
				,@ScoringEventTypeID
			)
			
		end

	select ScoringSchemeID from @InsertedPrimaryKeyTable
		
go

