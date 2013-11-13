if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimEventSave')
	begin
	    drop procedure dbo.usp_SwimEventSave
	end
go

create procedure dbo.usp_SwimEventSave
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimEventSave

 Description:		Saves an SwimEvent record for the given parameters

 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 8/3/2009	Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @AgeClassID int
,@Description varchar(250)
,@StrokeID int
,@SwimEventID int

as
	declare @InsertedPrimaryKeyTable table (SwimEventID int)
		
	if exists (select 1 from dbo.SwimEvent where SwimEventID = @SwimEventID)
		begin
			
			update dbo.SwimEvent
			set
				 AgeClassID = @AgeClassID
				,Description = @Description
				,StrokeID = @StrokeID
			output inserted.SwimEventID into @InsertedPrimaryKeyTable
			where SwimEventID = @SwimEventID
		end
	--prevent duplicates
	if exists(select 1 from dbo.SwimEvent where AgeClassID = @AgeClassID and StrokeID = @StrokeID)
		begin
			insert into @InsertedPrimaryKeyTable
			select SwimEventID from dbo.SwimEvent where AgeClassID = @AgeClassID and StrokeID = @StrokeID
		end
		
	else
		begin
			if(@Description is null or len(@Description) = 0)
				begin
					declare @StrokeDescription varchar(50),
							@AgeClassDescription varchar(50)

					select @AgeClassDescription = [Description] from [dbo].[AgeClass] where AgeClassID = @AgeClassID
					select @StrokeDescription = [Description] from [dbo].[Stroke] where StrokeID = @StrokeID

					set @Description = @AgeClassDescription + ' ' + @StrokeDescription
				end
			
			insert into dbo.SwimEvent(
				 AgeClassID
				,Description
				,StrokeID
			)
			output inserted.SwimEventID into @InsertedPrimaryKeyTable
			values (
				 @AgeClassID
				,@Description
				,@StrokeID
			)
			
		end

	select SwimEventID from @InsertedPrimaryKeyTable
		
go

