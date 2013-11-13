IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uf_IsInAgeClass]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP FUNCTION [dbo].[uf_IsInAgeClass]
	END

GO

create function dbo.uf_IsInAgeClass
(
	  @AgeClassID int
	 ,@AgeClassRuleCustomDate datetime
	 ,@AgeClassRuleID int
	 ,@BirthDate datetime
	 ,@MeetStartDate datetime
	 ,@SeasonEndDate datetime
	 ,@SeasonStartDate datetime
)
returns int
 /*******************************************************************************************************
 Description:		Determines whether a swimmer is in the given age class
 ********************************************************************************************************/

as
begin
	declare @isInAgeClass int
	set @isInAgeClass = 0
	
	declare @CurrentDate datetime
	set @CurrentDate = convert(datetime, getdate(), 101)
	
	--set @AgeClassRuleCustomDate to current year
	declare @Month varchar(2) = cast(datepart(mm,@AgeClassRuleCustomDate) as varchar(2))
	declare @Day varchar(2) = cast(datepart(dd,@AgeClassRuleCustomDate) as varchar(2))
	declare @Year char(4) = cast(datepart(yy,getdate()) as char(4))
	set @AgeClassRuleCustomDate = CAST(@Month + '/' + @Day + '/' + @Year as datetime)

	declare	 @MinAge int
			,@MaxAge int
	select	 @MinAge = MinAge
			,@MaxAge = MaxAge
	from dbo.AgeClass
	where AgeClassID = @AgeClassID
	
	declare @AdjustedAge int
	
	if(@AgeClassRuleID = 1) --AgeAtCustomDate
	begin
		set @AdjustedAge = datediff(dd,@BirthDate,@AgeClassRuleCustomDate)*100/36524
	end
	
	if(@AgeClassRuleID = 2) --AgeAtJan1
	begin
		set @AdjustedAge = datepart(yy,@CurrentDate) - datepart(yy,@BirthDate) - 1
	end
	
	if(@AgeClassRuleID = 3) --AgeAtSeasonStart
	begin
		set @AdjustedAge = datediff(dd,@BirthDate,@SeasonStartDate)*100/36524
	end
	
	if(@AgeClassRuleID = 4) --AgeAtSwimMeet
	begin
		set @AdjustedAge = datediff(dd,@BirthDate,@MeetStartDate)*100/36524
	end
	
	if(@AgeClassRuleID = 5) --AgeAtSeasonEnd
	begin
		set @AdjustedAge = datediff(dd,@BirthDate,@SeasonEndDate)*100/36524
	end
	
	if(@AgeClassRuleID = 6) --AgeAtDec31
	begin
		set @AdjustedAge = datepart(yy,@CurrentDate) - datepart(yy,@BirthDate)
	end
	
	if (@AdjustedAge >= @MinAge and @AdjustedAge <= @MaxAge)
	begin
		set @isInAgeClass = 1
	end

	return @isInAgeClass
end 