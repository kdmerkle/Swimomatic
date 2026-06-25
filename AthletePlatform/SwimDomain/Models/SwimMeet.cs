namespace SwimDomain.Models;

public class SwimMeet
{
    public int SwimMeetId { get; set; }
    public int TenantId { get; set; }
    public int MeetId { get; set; }
    public string Description { get; set; } = string.Empty;
    public DateOnly StartDate { get; set; }
    public DateOnly EndDate { get; set; }
    public int LocationId { get; set; }
    public int SeasonId { get; set; }
    public int SwimMeetTypeId { get; set; }
    public int? PoolConfigId { get; set; }
}
