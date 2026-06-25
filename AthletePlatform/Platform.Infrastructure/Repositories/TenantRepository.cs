using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class TenantRepository(IDbConnectionFactory connFactory) : ITenantRepository
{
    public async Task<TenantConfig?> GetConfigAsync(int tenantId)
    {
        using var conn = await connFactory.OpenAsync(bypassRls: true);
        var result = await conn.QuerySingleOrDefaultAsync<(string TenantKey, string Name, string? EnabledSportCodes)>(
            "spTenantGetConfig",
            new { TenantId = tenantId },
            commandType: System.Data.CommandType.StoredProcedure);

        if (result == default) return null;

        var sports = result.EnabledSportCodes is not null
            ? result.EnabledSportCodes.Split(',', StringSplitOptions.RemoveEmptyEntries).ToList()
            : new List<string>();

        return new TenantConfig(result.TenantKey, result.Name, sports);
    }
}
