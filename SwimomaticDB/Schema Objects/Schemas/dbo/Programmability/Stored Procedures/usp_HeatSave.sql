if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSave')
	begin
	    drop procedure dbo.usp_HeatSave
	end
go

create procedure dbo.usp_HeatSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSave

 Description:		Saves an Heat record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 8/3/2009	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @HeatID int
,@HeatNumber tinyint
,@HeatSheetEventID int

as
	declare @InsertedPrimaryKeyTable table (HeatID int)
		
	if exists (select 1 from dbo.Heat where HeatID = @HeatID)
		begin
			
			update dbo.Heat
			set
				 HeatNumber = @HeatNumber
				,HeatSheetEventID = @HeatSheetEventID
			output inserted.HeatID into @InsertedPrimaryKeyTable
			where HeatID = @HeatID
		end
	else
		begin
			if @HeatNumber = 0
				begin
					select @HeatNumber = coalesce(max(HeatNumber),0) + 1 from dbo.Heat where HeatSheetEventID = @HeatSheetEventID
				end
			insert into dbo.Heat(
				 HeatNumber
				,HeatSheetEventID
			)
			output inserted.HeatID into @InsertedPrimaryKeyTable
			values (
				 @HeatNumber
				,@HeatSheetEventID
			)
			
		end

	select HeatID from @InsertedPrimaryKeyTable
		
go

