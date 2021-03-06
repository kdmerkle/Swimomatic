
if exists (select * from sysobjects where type = 'P' and name = 'usp_UOMGet')
	begin
	    drop procedure dbo.usp_UOMGet
	end
go

create procedure dbo.usp_UOMGet
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_UOMGet
 
 Description:		Selects a UOM record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 7/12/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the UOM Entity
 The Entity expects the following properties to be returned:
   Description < System.String >
   UOMID < System.Int32 >
   Abbrev < System.String >
 ********************************************************************************************************/
 @UOMID int

as
	select
		 Description
		,UOMID
		,Abbrev
	from dbo.UOM
	where
		UOMID = @UOMID
		
go

