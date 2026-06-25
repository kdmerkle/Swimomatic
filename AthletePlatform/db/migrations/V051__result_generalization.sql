-- V051__result_generalization.sql
-- Add MeasurementType with default 'Time' — all existing swim rows become 'Time' automatically
-- This is the critical prerequisite for T&F result storage (Phase H / WI-02)

ALTER TABLE dbo.Result ADD CONSTRAINT CK_Result_MeasurementType
    CHECK (MeasurementType IN ('Time','Distance','Height','Points'));
