if not exists(select 1 from dbo.HeatSwimmer )
	begin
		declare @SwimmerID int
				,@AssignedLaneNumber int

		select @SwimmerID = SwimmerID from dbo.Swimmer where LastName = 'Merkle' and FirstName = 'Daniel'
		set @AssignedLaneNumber = 1
		INSERT INTO dbo.HeatSwimmer(HeatID,SwimmerID,AssignedLaneNumber,ActualLaneNumber,ElapsedTime,Penalty,Disqualified)
		select HeatID,@SwimmerID,@AssignedLaneNumber,null as ActualLaneNumber,null as ElapsedTime,null as Penalty,0 as Disqualified 
		from dbo.Heat
		where HeatID = 1

		select @SwimmerID = SwimmerID from dbo.Swimmer where LastName = 'Merkle' and FirstName = 'Lewis'
		set @AssignedLaneNumber = 2
		INSERT INTO dbo.HeatSwimmer(HeatID,SwimmerID,AssignedLaneNumber,ActualLaneNumber,ElapsedTime,Penalty,Disqualified)
		select HeatID,@SwimmerID,@AssignedLaneNumber,null as ActualLaneNumber,null as ElapsedTime,null as Penalty,0 as Disqualified 
		from dbo.Heat
		where HeatID = 1

		select @SwimmerID = SwimmerID from dbo.Swimmer where LastName = 'Merkle' and FirstName = 'Steffen'
		set @AssignedLaneNumber = 1
		INSERT INTO dbo.HeatSwimmer(HeatID,SwimmerID,AssignedLaneNumber,ActualLaneNumber,ElapsedTime,Penalty,Disqualified)
		select HeatID,@SwimmerID,@AssignedLaneNumber,null as ActualLaneNumber,null as ElapsedTime,null as Penalty,0 as Disqualified 
		from dbo.Heat
		where HeatID = 2

		select @SwimmerID = SwimmerID from dbo.Swimmer where LastName = 'Jones' and FirstName = 'Steve'
		set @AssignedLaneNumber = 1
		INSERT INTO dbo.HeatSwimmer(HeatID,SwimmerID,AssignedLaneNumber,ActualLaneNumber,ElapsedTime,Penalty,Disqualified)
		select HeatID,@SwimmerID,@AssignedLaneNumber,null as ActualLaneNumber,null as ElapsedTime,null as Penalty,0 as Disqualified 
		from dbo.Heat
		where HeatID = 3
	end