namespace Platform.Core.Models;

public record TenantConfig(
    string TenantKey,
    string Name,
    IReadOnlyList<string> EnabledSports
);
