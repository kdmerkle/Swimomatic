IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uf_GetConvertedTime]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP FUNCTION [dbo].[uf_GetConvertedTime]
	END

GO

create function dbo.uf_GetConvertedTime
(
	 @LaneLength1 decimal(9,4)
	,@UOMID1 int
	,@ElapsedTime decimal(9,4)
	,@LaneLength2 decimal(9,4)
	,@UOMID2 int
)

returns decimal(8,4)
/***********************************************************************************************
** -----------------------------------------------------------------------------------------------------------------------------
** Function:	uf_GetConvertedTime
** 
** Description:	Takes a race time from a pool with a given length and returns the time for a pool with a different length
**
** Version:	1.0.0
**	
** Author:	Kurt Merkle
** 
** -----------------------------------------------------------------------------------------------------------------------------
** Change Log:
** v1.0 -  4/29/2010 - kurtm - Original Release
***********************************************************************************************/
as
begin
	-- Declare the return variable here
	declare @ConvertedTime decimal(9,4)
	declare @LengthRatio decimal(9,4)
	declare @ConversionFactor decimal(12,9)
	
	set @LengthRatio = @LaneLength2 / @LaneLength1
	
	if (@UOMID1 = @UOMID2)
		begin
			set @ConversionFactor = 1.0
		end
	else
		begin
			--Meters
			if	(@UOMID1 = 1 and @UOMID2 = 2) --Meters to yards
			begin
				set @ConversionFactor = 0.9144 --M/y
			end
			
			if	(@UOMID1 = 1 and @UOMID2 = 3) --Meters to Centimeters
			begin
				set @ConversionFactor = 0.01 --M/cm
			end

			if	(@UOMID1 = 1 and @UOMID2 = 4) --Meters to Inches
			begin
				set @ConversionFactor = .0254 --M/in
			end

			--Yards
			if	(@UOMID1 = 2 and @UOMID2 = 1) --Yards to Meters
			begin
				set @ConversionFactor = 1.0936133 --Y/M
			end
			
			if	(@UOMID1 = 2 and @UOMID2 = 3) --Yards to Centimeters
			begin
				set @ConversionFactor = 0.010936133 --Y/cm
			end

			if	(@UOMID1 = 2 and @UOMID2 = 4) --Yards to Inches
			begin
				set @ConversionFactor = 0.0277777778 --Y/in
			end

			--Centimeters
			if	(@UOMID1 = 3 and @UOMID2 = 1) --Centimeters to Meters
			begin
				set @ConversionFactor = 100.0 --cm/M
			end
			
			if	(@UOMID1 = 3 and @UOMID2 = 2) --Centimeters to Yards
			begin
				set @ConversionFactor = 91.44 --cm/Y
			end

			if	(@UOMID1 = 3 and @UOMID2 = 4) --Centimeters to Inches
			begin
				set @ConversionFactor = 2.54 --cm/in
			end

			--Inches
			if	(@UOMID1 = 4 and @UOMID2 = 1) --Inches to Meters
			begin
				set @ConversionFactor = 39.3700787 --in/M
			end
			
			if	(@UOMID1 = 4 and @UOMID2 = 2) --Inches to Yards
			begin
				set @ConversionFactor = 36.0 --in/Y
			end

			if	(@UOMID1 = 4 and @UOMID2 = 3) --Inches to Centimeters
			begin
				set @ConversionFactor = 0.393700787  --in/cm
			end
		end
			
		set @ConvertedTime = @ConversionFactor * @LengthRatio * @ElapsedTime
		
	return @ConvertedTime

end 