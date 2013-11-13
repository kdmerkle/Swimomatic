
if exists (select * from sysobjects where type = 'P' and name = 'usp_SwimmerGet')
	begin
	    drop procedure dbo.usp_SwimmerGet
	end
go

create procedure dbo.usp_SwimmerGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_SwimmerGet
 
 Description:		Selects a Swimmer record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/19/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the Swimmer Entity
 The Entity expects the following properties to be returned:
   BirthDate < System.DateTime >
   FirstName < System.String >
   LastName < System.String >
   SwimmerID < System.Int32 >
   IsMale < System.Boolean >
 ********************************************************************************************************/
 @SwimmerID int

as
	select
		 BirthDate
		,FirstName
		,LastName
		,SwimmerID
		,IsMale
	from dbo.Swimmer
	where
		SwimmerID = @SwimmerID
		
go

