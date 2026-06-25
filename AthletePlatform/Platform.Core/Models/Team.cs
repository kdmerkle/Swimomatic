namespace Platform.Core.Models;

public class Team
{
    public int TeamId { get; set; }
    public int TenantId { get; set; }
    public string Name { get; set; } = string.Empty;
    public int? HomeLocationId { get; set; }
}
