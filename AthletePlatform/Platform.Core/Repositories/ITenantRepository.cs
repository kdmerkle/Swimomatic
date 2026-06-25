using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface ITenantRepository
{
    Task<TenantConfig?> GetConfigAsync(int tenantId);
}
