using System.Data;
using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class TeamRepository(IDbConnectionFactory connFactory) : ITeamRepository
{
    public async Task<IEnumerable<Team>> GetAllAsync()
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<Team>("spTeamGetAll", commandType: CommandType.StoredProcedure);
    }

    public async Task<Team?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<Team>(
            "spTeamGetById", new { TeamId = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(Team team)
    {
        var p = new DynamicParameters();
        p.Add("@TeamId", team.TeamId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", team.TenantId);
        p.Add("@Name", team.Name);
        p.Add("@HomeLocationId", team.HomeLocationId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("spTeamSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@TeamId");
    }
}
