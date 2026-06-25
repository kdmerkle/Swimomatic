namespace Platform.Core.Models;

public class Location
{
    public int LocationId { get; set; }
    public int TenantId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Address { get; set; }
    public int? RegionId { get; set; }
}
