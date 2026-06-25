namespace SwimDomain.Models;

public class HeatSheet
{
    public int HeatSheetId { get; set; }
    public int TenantId { get; set; }
    public int SwimMeetId { get; set; }
}

public class HeatSheetEvent
{
    public int HeatSheetEventId { get; set; }
    public int TenantId { get; set; }
    public int HeatSheetId { get; set; }
    public int SwimEventId { get; set; }
    public int AgeClassId { get; set; }
    public char Gender { get; set; }
    public int Sequence { get; set; }
    public bool IsScratch { get; set; }
}

public class Heat
{
    public int HeatId { get; set; }
    public int TenantId { get; set; }
    public int HeatSheetEventId { get; set; }
    public int HeatNumber { get; set; }
    public int LaneCount { get; set; }
}

// record class enables `with` expression for non-destructive mutation in heat generation
public record class HeatSwimmer
{
    public int HeatSwimmerId { get; set; }
    public int TenantId { get; set; }
    public int HeatId { get; set; }
    public int AthleteId { get; set; }
    public int LaneNumber { get; set; }
    public decimal? SeedTime { get; set; }
}
