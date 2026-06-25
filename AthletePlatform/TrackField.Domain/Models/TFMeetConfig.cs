namespace TrackField.Domain.Models;

/// <summary>
/// T&amp;F meet configuration — scoring type, field attempt count, etc.
/// </summary>
public class TFMeetConfig
{
    public int TFMeetConfigId { get; set; }
    public int TenantId { get; set; }
    public int TFMeetId { get; set; }
    public int FieldAttemptCount { get; set; } = 3;
    public string ScoringType { get; set; } = "Points"; // "Points", "Time", "Combined"
}
