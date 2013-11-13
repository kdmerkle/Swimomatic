if not exists(select 1 from dbo.SwimEvent )
begin
	declare @StrokeID int,
			@AgeClassID int,
			@StrokeDescription varchar(50),
			@AgeClassDescription varchar(50)

	set @AgeClassDescription = '6 and under Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '6 and under Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '7-8 Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '7-8 Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '9-10 Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '9-10 Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '11-12 Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '11-12 Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '13-14 Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '13-14 Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '15-16 Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '15-16 Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '17 and over Boys'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

	set @AgeClassDescription = '17 and over Girls'
	set @StrokeDescription = 'Freestyle'
	SELECT @AgeClassID = AgeClassID FROM [dbo].[AgeClass] where Description = @AgeClassDescription
	SELECT @StrokeID = StrokeID FROM [dbo].[Stroke] where Description = @StrokeDescription

	INSERT INTO [dbo].[SwimEvent]([Description],[StrokeID],[AgeClassID])VALUES(@AgeClassDescription + ' ' + @StrokeDescription, @StrokeID, @AgeClassID)

end