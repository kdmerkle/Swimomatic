namespace Platform.Core.Models;

public class Season
{
    public int SeasonId { get; set; }
    public int TenantId { get; set; }
    public int LeagueId { get; set; }
    public string Name { get; set; } = string.Empty;
    public DateOnly StartDate { get; set; }
    public DateOnly EndDate { get; set; }
}
