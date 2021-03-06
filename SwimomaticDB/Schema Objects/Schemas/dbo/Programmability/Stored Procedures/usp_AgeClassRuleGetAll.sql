
if exists (select * from sysobjects where type = 'P' and name = 'usp_AgeClassRuleGetAll')
	begin
	    drop procedure dbo.usp_AgeClassRuleGetAll
	end
go

create procedure dbo.usp_AgeClassRuleGetAll
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_AgeClassRuleGetAll
 
 Description:		Selects a AgeClassRule record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 8/10/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the AgeClassRule Entity
 The Entity expects the following properties to be returned:
   AgeClassRuleID < System.Int32 >
   Description < System.String >
   ShortDescription < System.String >
 ********************************************************************************************************/

as
	select
		 AgeClassRuleID
		,[Description]
		,ShortDescription
	from dbo.AgeClassRule
	order by AgeClassRuleID
		
go

