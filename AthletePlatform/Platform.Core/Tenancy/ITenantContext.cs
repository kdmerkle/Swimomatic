namespace Platform.Core.Tenancy;

public interface ITenantContext
{
    int TenantId { get; }
    string TenantKey { get; }
    bool IsResolved { get; }
}
