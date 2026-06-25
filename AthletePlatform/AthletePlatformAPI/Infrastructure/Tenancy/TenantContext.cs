using Dapper;
using Platform.Core.Data;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Infrastructure.Tenancy;

public sealed class TenantContext : ITenantContext
{
    public int TenantId { get; private set; }
    public string TenantKey { get; private set; } = string.Empty;
    public bool IsResolved { get; private set; }

    public async Task ResolveAsync(string tenantKey, IDbConnectionFactory connFactory)
    {
        using var conn = await connFactory.OpenAsync(bypassRls: true);
        var tenant = await conn.QuerySingleOrDefaultAsync<(int Id, string Key)>(
            "SELECT TenantId, TenantKey FROM dbo.Tenant WHERE TenantKey = @key AND IsActive = 1",
            new { key = tenantKey });
        if (tenant == default)
            throw new TenantNotFoundException(tenantKey);
        TenantId = tenant.Id;
        TenantKey = tenant.Key;
        IsResolved = true;
    }
}
