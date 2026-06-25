namespace TrackField.Domain.Models;

/// <summary>
/// T&amp;F result — stub for Phase H. MeasurementValue units depend on MeasurementType.
/// </summary>
public class TFResult
{
    public int TFResultId { get; set; }
    public int TenantId { get; set; }
    public int AthleteId { get; set; }
    public int TFEventId { get; set; }
    public string MeasurementType { get; set; } = "Time";
    public decimal? MeasurementValue { get; set; }
    public bool IsDQ { get; set; }
}
