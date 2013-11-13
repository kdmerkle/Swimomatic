
if exists (select * from sysobjects where type = 'P' and name = 'usp_PoolConfigGetAllByLocationIDList')
	begin
	    drop procedure dbo.usp_PoolConfigGetAllByLocationIDList
	end
go

create procedure dbo.usp_PoolConfigGetAllByLocationIDList
 /*******************************************************************************************************
 Logical Advantage, LLC
 www.logicaladvantage.com
 704-377-5066
 --------------------------------------------------------------------------------------------------------
 Stored Procedure:	usp_PoolConfigGetAllByLocationIDList
 
 Description:		Selects a PoolConfig record for the given parameters
 
 --------------------------------------------------------------------------------------------------------
 Change Log:
 v1.0.0 - 9/30/2010  Original Release - Generated by LAAF
 ********************************************************************************************************
 To keep the Generator from overwriting this file add the word NOT between the center asterisks ( *NOT* )
 *** DO *NOT* GENERATE ***
 ********************************************************************************************************
 The result of this procedure call is used to populate the PoolConfig Entity
 The Entity expects the following properties to be returned:
   PoolConfigID < System.Int32 >
   PoolID < System.Int32 >
 ********************************************************************************************************/
 @LocationIDList varchar(max)

as

	declare @Location table (LocationID int)

	insert into @Location(LocationID)
	select intValue as LocationID from dbo.udf_GetTableFromDelimitedString (@LocationIDList, '|')

select	 pc.CreatedByUserID
		,pc.CreatedDate
		,pc.[Description]
		,pc.LaneCount
		,pc.LaneLength
		,pc.ModifiedByUserID
		,pc.ModifiedDate
		,pc.PoolConfigID
		,pc.PoolID
		,pc.UOMID
		,l.Name as LocationName
		,u.Abbrev as UOMAbbrev
		,p.[Description] as PoolDescription
	from dbo.PoolConfig pc
	inner join dbo.[Pool] p on p.PoolID = pc.PoolID
	inner join @Location lx on lx.LocationID = p.LocationID
	inner join dbo.Location l on l.LocationID = lx.LocationID
	inner join dbo.UOM u on u.UOMID = pc.UOMID
go

