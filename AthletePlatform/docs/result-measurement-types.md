# Result MeasurementType Convention

The `dbo.Result` table supports multi-sport results via `MeasurementType` and `MeasurementValue` columns.

## Values

| MeasurementType | Sport       | Unit         | Example |
|-----------------|-------------|--------------|---------|
| `Time`          | Swimming, T&F (track events) | Seconds (decimal) | 65.40 |
| `Distance`      | T&F (field events: long jump, shot put) | Centimeters | 650.50 |
| `Height`        | T&F (high jump, pole vault) | Centimeters | 195.00 |

## Swim-specific

Swim always uses `MeasurementType = 'Time'`. `ElapsedTime` mirrors `MeasurementValue` for backward compat.

## T&F-specific

T&F uses `tf.TFResult` for its own result storage (separate table) and writes a cross-sport summary
to `dbo.Result` with the appropriate `MeasurementType` for multi-sport athlete profile aggregation.
