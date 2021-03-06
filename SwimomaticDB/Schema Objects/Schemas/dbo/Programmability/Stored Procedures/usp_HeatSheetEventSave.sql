if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatSheetEventSave')
	begin
	    drop procedure dbo.usp_HeatSheetEventSave
	end
go

create procedure dbo.usp_HeatSheetEventSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatSheetEventSave

 Description:		Saves an HeatSheetEvent record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 10/6/2010	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @Distance int
,@HeatSheetEventID int
,@HeatSheetID int
,@Sequence int
,@SwimEventID int

as
	declare @InsertedPrimaryKeyTable table (HeatSheetEventID int)
		
	if exists (select 1 from dbo.HeatSheetEvent where HeatSheetEventID = @HeatSheetEventID)
		begin
			
			update dbo.HeatSheetEvent
			set
				 Distance = @Distance
				,HeatSheetID = @HeatSheetID
				,Sequence = @Sequence
				,SwimEventID = @SwimEventID
			output inserted.HeatSheetEventID into @InsertedPrimaryKeyTable
			where HeatSheetEventID = @HeatSheetEventID
		end
	--prevent duplicates
	if exists(select 1 from dbo.HeatSheetEvent where HeatSheetID = @HeatSheetID and SwimEventID = @SwimEventID and Distance = @Distance)
		begin
			insert into @InsertedPrimaryKeyTable
			select HeatSheetEventID from dbo.HeatSheetEvent where HeatSheetID = @HeatSheetID and SwimEventID = @SwimEventID and Distance = @Distance
		end
	else
		begin
			if (@Sequence = 0)
				begin
					select @Sequence = coalesce(max([Sequence]),0) + 1 from dbo.HeatSheetEvent where HeatSheetID = @HeatSheetID
				end
			insert into dbo.HeatSheetEvent(
				 Distance
				,HeatSheetID
				,Sequence
				,SwimEventID
			)
			output inserted.HeatSheetEventID into @InsertedPrimaryKeyTable
			values (
				 @Distance
				,@HeatSheetID
				,@Sequence
				,@SwimEventID
			)
			
		end

	select HeatSheetEventID from @InsertedPrimaryKeyTable
		
go

