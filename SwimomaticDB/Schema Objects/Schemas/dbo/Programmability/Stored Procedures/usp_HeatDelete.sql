
if exists (select * from sysobjects where type = 'P' and name = 'usp_HeatDelete')
	begin
	    drop procedure dbo.usp_HeatDelete
	end
go

create procedure dbo.usp_HeatDelete
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 -------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_HeatDelete
 
 Description:		Deletes a Heat record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 5/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************/
 @HeatID int

as
	delete
	from dbo.Heat
	where HeatID = @HeatID

go

