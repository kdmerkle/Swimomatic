using System.Data;
using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class LeagueRepository(IDbConnectionFactory connFactory) : ILeagueRepository
{
    public async Task<IEnumerable<League>> GetAllAsync(string? sportCode = null)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<League>(
            "spLeagueGetAll", new { SportCode = sportCode }, commandType: CommandType.StoredProcedure);
    }

    public async Task<League?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<League>(
            "spLeagueGetById", new { LeagueId = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(League league)
    {
        var p = new DynamicParameters();
        p.Add("@LeagueId", league.LeagueId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", league.TenantId);
        p.Add("@SportId", league.SportId);
        p.Add("@Name", league.Name);
        p.Add("@Description", league.Description);
        p.Add("@RegionId", league.RegionId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("spLeagueSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@LeagueId");
    }
}
