-- Seed UOM reference data (if not already seeded)
IF NOT EXISTS (SELECT 1 FROM dbo.UOM WHERE Name = 'Yards')
BEGIN
    INSERT INTO dbo.UOM (Name, Abbreviation) VALUES ('Yards','YD'),('Meters','M');
END
