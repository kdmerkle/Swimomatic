using System.Data;
using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class LocationRepository(IDbConnectionFactory connFactory) : ILocationRepository
{
    public async Task<IEnumerable<Location>> GetAllAsync()
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<Location>(
            "dbo.spLocationGetAll", commandType: CommandType.StoredProcedure);
    }

    public async Task<Location?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<Location>(
            "dbo.spLocationGetById", new { LocationId = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(Location location)
    {
        var p = new DynamicParameters();
        p.Add("@LocationId", location.LocationId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", location.TenantId);
        p.Add("@Name", location.Name);
        p.Add("@Address", location.Address);
        p.Add("@RegionId", location.RegionId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spLocationSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@LocationId");
    }
}
