namespace TrackField.Domain.Models;

/// <summary>
/// Track &amp; Field event (100m, Long Jump, etc.) — stub for Phase H.
/// </summary>
public class TFEvent
{
    public int TFEventId { get; set; }
    public int TenantId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string MeasurementType { get; set; } = "Time"; // "Time", "Distance", "Height"
    public bool IsField { get; set; }  // false = track event, true = field event
}
