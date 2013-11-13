
if exists (select * from sysobjects where type = 'P' and name = 'usp_AgeClassGet')
	begin
	    drop procedure dbo.usp_AgeClassGet
	end
go

create procedure dbo.usp_AgeClassGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_AgeClassGet
 
 Description:		Selects a AgeClass record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 7/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the AgeClass Entity
 The Entity expects the following properties to be returned:
   AgeClassID < System.Int32 >
   Description < System.String >
   IsMale < System.Boolean >
   MinAge < System.Int32 >
   MaxAge < System.Int32 >
 ********************************************************************************************************/
 @AgeClassID int

as
	select
		 AgeClassID
		,Description
		,IsMale
		,MinAge
		,MaxAge
	from dbo.AgeClass
	where
		AgeClassID = @AgeClassID
		
go

