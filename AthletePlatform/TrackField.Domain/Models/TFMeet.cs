namespace TrackField.Domain.Models;

/// <summary>
/// Track &amp; Field meet — stub for Phase H. Full implementation in WI-02.
/// </summary>
public class TFMeet
{
    public int TFMeetId { get; set; }
    public int TenantId { get; set; }
    public int MeetId { get; set; }
    public string Description { get; set; } = string.Empty;
    public DateOnly StartDate { get; set; }
    public DateOnly EndDate { get; set; }
}
