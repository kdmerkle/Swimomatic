/*
SELECT 'insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints) values(''' +
		[Description] + ''',' +
        cast(IsUSASwimming as varchar(1)) + ',' +
        cast(LaneCount as varchar(1)) + ',' +
        cast(SwimMeetTypeID as varchar(1)) + ',' +
        cast(ScoringEventTypeID as varchar(1)) + ',''' +
        IndividualPoints + ''',''' +
        RelayPoints + ''')'
  FROM dbo.ScoringScheme
*/

if not exists(select 1 from UOM)
begin
	--USA Swimming Heat
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming Dual',1,0,1,1,'5,3,1','7')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming Triangular',1,0,2,1,'6,4,3,2,1','8,4')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 4 Lane, Heat Scoring',1,4,3,1,'5,3,2,1','10,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 5 Lane, Heat Scoring',1,5,3,1,'6,4,3,2,1','12,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 6 Lane, Heat Scoring',1,6,3,1,'7,5,4,3,2,1','14,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 7 Lane, Heat Scoring',1,7,3,1,'8,6,5,4,3,2,1','16,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 8 Lane, Heat Scoring',1,8,3,1,'9,7,6,5,4,3,2,1','18,14,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 9 Lane, Heat Scoring',1,9,3,1,'10,8,7,6,5,4,3,2,1','20,16,14,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 10 Lane, Heat Scoring',1,10,3,1,'11,9,8,7,6,5,4,3,2,1','22,18,16,14,12,10,8,6,4,2')


	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 6 Lane, Final Scoring',1,6,3,2,'16,13,12,11,10,9','32,26,24,22,20,18')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 7 Lane, Final Scoring',1,7,3,2,'18,15,14,13,12,11,10','36,30,28,26,24,22,20')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 8 Lane, Final Scoring',1,8,3,2,'20,17,16,15,14,13,12,11','40,34,32,30,28,26,24,22')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 9 Lane, Final Scoring',1,9,3,2,'22,19,18,17,16,15,14,13,12','44,38,36,34,32,30,28,26,24')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 10 Lane, Final Scoring',1,10,3,2,'24,21,20,19,18,17,16,15,14,13','48,42,40,38,36,34,32,30,28,26')

	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 6 Lane, Consolation Scoring',1,6,3,3,'7,5,4,3,2,1','14,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 7 Lane, Consolation Scoring',1,7,3,3,'8,6,5,4,3,2,1','16,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 8 Lane, Consolation Scoring',1,8,3,3,'9,7,6,5,4,3,2,1','18,14,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 9 Lane, Consolation Scoring',1,9,3,3,'10,8,7,6,5,4,3,2,1','20,16,14,12,10,8,6,4,2')
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('USASwimming 10 Lane, Consolation Scoring',1,10,3,3,'11,9,8,7,6,5,4,3,2,1','22,18,16,14,12,10,8,6,4,2')


--Custom
	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('Custom Scoring',0,0,3,1,'5,3,1','7,5,3')

	insert into dbo.ScoringScheme([Description],IsUSASwimming,LaneCount,SwimMeetTypeID,ScoringEventTypeID,IndividualPoints,RelayPoints)
	values('Custom Scoring',0,0,3,1,'8,6,5,4,3,2','16,12,10,8,6,4')

end
GO