namespace Platform.Core.Models;

public class League
{
    public int LeagueId { get; set; }
    public int TenantId { get; set; }
    public int SportId { get; set; }
    public string SportCode { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public int? RegionId { get; set; }
    public DateTime CreatedDate { get; set; }
}
