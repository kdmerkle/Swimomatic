if exists (select * from sysobjects where type = 'P' and name = 'usp_LeagueSave')
	begin
	    drop procedure dbo.usp_LeagueSave
	end
go

create procedure dbo.usp_LeagueSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_LeagueSave

 Description:		Saves an League record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 7/15/2010	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
	 @Description varchar(250)
	,@LeagueID int
	,@LeagueName varchar(100)
	,@RegionID int

as
	declare @InsertedPrimaryKeyTable table (LeagueID int)
		
	if exists (select 1 from dbo.League where LeagueID = @LeagueID)
		begin
			
			update dbo.League
			set
				 [Description] = @Description
				,LeagueName = @LeagueName
				,RegionID = @RegionID
			output inserted.LeagueID into @InsertedPrimaryKeyTable
			where LeagueID = @LeagueID
		end
	else
		begin
			insert into dbo.League(
				 [Description]
				,LeagueName
				,RegionID
			)
			output inserted.LeagueID into @InsertedPrimaryKeyTable
			values (
				 @Description
				,@LeagueName
				,@RegionID
			)
			
		end

	select LeagueID from @InsertedPrimaryKeyTable
		
go
