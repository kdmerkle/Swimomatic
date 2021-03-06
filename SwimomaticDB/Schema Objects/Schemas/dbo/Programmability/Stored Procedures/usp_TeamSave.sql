if exists (select * from sysobjects where type = 'P' and name = 'usp_TeamSave')
	begin
	    drop procedure dbo.usp_TeamSave
	end
go

create procedure dbo.usp_TeamSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_TeamSave

 Description:		Saves an Team record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/1/2010	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @Abbrev varchar(5)
,@HomePoolConfigID int
,@TeamID int
,@TeamName varchar(50)

as
	declare @InsertedPrimaryKeyTable table (TeamID int)
		
	if exists (select 1 from dbo.Team where TeamID = @TeamID)
		begin
			
			update dbo.Team
			set
				 Abbrev = @Abbrev
				,HomePoolConfigID = @HomePoolConfigID
				,TeamName = @TeamName
			output inserted.TeamID into @InsertedPrimaryKeyTable
			where TeamID = @TeamID
		end
	else
		begin
			insert into dbo.Team(
				 Abbrev
				,HomePoolConfigID
				,TeamName
			)
			output inserted.TeamID into @InsertedPrimaryKeyTable
			values (
				 @Abbrev
				,@HomePoolConfigID
				,@TeamName
			)
			
		end

	select TeamID from @InsertedPrimaryKeyTable
		
go

