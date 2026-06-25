namespace SwimDomain.Models;

public class ScoringScheme
{
    public int ScoringSchemeId { get; set; }
    public int TenantId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? SchemeType { get; set; }  // "Dual" or "Championship"
}

public class SeasonScoringRequest
{
    public ScoringScheme DualScheme { get; set; } = new();
    public ScoringScheme ChampionshipScheme { get; set; } = new();
}
