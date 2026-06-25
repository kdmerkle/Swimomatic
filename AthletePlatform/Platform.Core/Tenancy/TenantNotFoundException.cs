namespace Platform.Core.Tenancy;

public class TenantNotFoundException(string tenantKey)
    : Exception($"Tenant '{tenantKey}' not found or is inactive.")
{
    public string TenantKey { get; } = tenantKey;
}
