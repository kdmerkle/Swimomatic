IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[udf_GetTableFromDelimitedString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	BEGIN
		DROP FUNCTION [dbo].[udf_GetTableFromDelimitedString]
	END

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  FUNCTION [dbo].[udf_GetTableFromDelimitedString](
		@SourceText	VARCHAR(max),
		@Delimiter	VARCHAR(100) = ',') --default to comma delimited.
 
RETURNS @retTable	TABLE (
		RecordID	INT IDENTITY(1,1),
		intValue	INT, 
		numValue	NUMERIC(18,6),
		txtValue	VARCHAR(8000))

/***********************************************************************************************
** Logical Advantage, LLC
** www.logicaladvantage.com
** 704-377-5066
** -----------------------------------------------------------------------------------------------------------------------------
** Function:	udf_GetTableFromDelimitedString
** 
** Description: Parse values from a delimited string & return the result as a table variable
**
** Version:	1.0.0
**	
** Author:	Kurt Merkle
** 
** -----------------------------------------------------------------------------------------------------------------------------
** Change Log:
** v2.4.2 -  2/15/2006 - KM - Original Release
***********************************************************************************************/

AS

BEGIN
	DECLARE	@w_Continue			INT,
			@w_StartPos			INT,
			@w_Length			INT,
			@w_Delimeter_pos	INT,
			@w_tmp_int			INT,
			@w_tmp_num			NUMERIC(18,6),
			@w_tmp_txt			VARCHAR(2000),
			@w_Delimeter_Len	TINYINT
	  
	IF LEN(@SourceText) = 0
		BEGIN
			SET	@w_Continue = 0 -- force early exit
		END 
	ELSE
		BEGIN
		  -- parse the original @SourceText array into a temp table
		  SET @w_Continue = 1
		  SET @w_StartPos = 1
		  SET @SourceText = RTRIM(LTRIM(@SourceText))
		  SET @w_Length   = DATALENGTH(RTRIM(LTRIM(@SourceText)))
		  SET @w_Delimeter_Len = LEN(@Delimiter)
		END
		
	WHILE @w_Continue = 1
		BEGIN
			SET @w_Delimeter_pos = CHARINDEX(@Delimiter,(SUBSTRING(@SourceText, @w_StartPos,((@w_Length - @w_StartPos) + @w_Delimeter_Len))))
 
			IF @w_Delimeter_pos > 0  -- delimeter(s) found, get the value
				BEGIN
					SET @w_tmp_txt = LTRIM(RTRIM(SUBSTRING(@SourceText, @w_StartPos,(@w_Delimeter_pos - 1))))
					
					IF ISNUMERIC(@w_tmp_txt) = 1
						BEGIN
							SET @w_tmp_int = CAST(CAST(@w_tmp_txt AS NUMERIC) AS INT)
							SET @w_tmp_num = CAST(@w_tmp_txt AS NUMERIC(18,6))
						END
					ELSE
						BEGIN
							SET @w_tmp_int = NULL
							SET @w_tmp_num = NULL
						END
						
					SET @w_StartPos = @w_Delimeter_pos + @w_StartPos + (@w_Delimeter_Len- 1)
				END
				
			ELSE -- No more delimeters, get last value
				BEGIN
					SET @w_tmp_txt = LTRIM(RTRIM(SUBSTRING(@SourceText, @w_StartPos,((@w_Length - @w_StartPos) + @w_Delimeter_Len))))
					IF ISNUMERIC(@w_tmp_txt) = 1
						BEGIN
							SET @w_tmp_int = CAST(CAST(@w_tmp_txt AS NUMERIC) AS INT)
							SET @w_tmp_num = CAST(@w_tmp_txt AS NUMERIC(18,6))
						END
					ELSE
						BEGIN
							SET @w_tmp_int = NULL
							SET @w_tmp_num = NULL
						END
						
					SET @w_Continue = 0
				END
				
			INSERT INTO @retTable(intValue, numValue, txtValue)
			VALUES(@w_tmp_int, @w_tmp_num, @w_tmp_txt)
			
	END --End While Loop
	
	RETURN

END

GO

