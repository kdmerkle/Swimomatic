﻿/*
select 'insert into dbo.LaneSequence values(' + cast(LaneCount as varchar(3)) + ',' + cast(LaneNumber as varchar(3)) + ',' + cast(LaneOrder as varchar(3))+ ')'
from dbo.[LaneSequence]
*/

if not exists(select 1 from dbo.LaneSequence)
begin
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(1,1,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(2,1,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(2,2,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(3,1,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(3,2,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(3,3,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(4,1,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(4,2,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(4,3,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(4,4,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(5,1,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(5,2,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(5,3,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(5,4,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(5,5,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,1,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,2,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,3,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,4,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,5,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(6,6,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,1,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,2,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,3,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,4,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,5,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,6,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(7,7,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,1,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,2,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,3,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,4,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,5,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,6,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,7,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(8,8,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,1,9)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,2,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,3,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,4,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,5,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,6,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,7,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,8,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(9,9,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,1,9)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,2,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,3,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,4,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,5,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,6,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,7,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,8,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,9,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(10,10,10)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,1,11)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,2,9)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,3,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,4,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,5,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,6,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,7,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,8,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,9,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,10,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(11,11,10)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,1,11)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,2,9)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,3,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,4,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,5,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,6,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,7,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,8,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,9,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,10,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,11,10)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(12,12,12)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,1,13)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,2,11)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,3,9)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,4,7)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,5,5)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,6,3)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,7,1)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,8,2)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,9,4)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,10,6)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,11,8)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,12,10)
	insert into dbo.LaneSequence(LaneCount,LaneNumber,LaneOrder) values(13,13,12)

end

go
