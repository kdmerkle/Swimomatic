using System.Data;
using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class SeasonRepository(IDbConnectionFactory connFactory) : ISeasonRepository
{
    public async Task<IEnumerable<Season>> GetByLeagueAsync(int leagueId)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<Season>(
            "dbo.spSeasonGetByLeague", new { LeagueId = leagueId }, commandType: CommandType.StoredProcedure);
    }

    public async Task<Season?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<Season>(
            "dbo.spSeasonGetById", new { SeasonId = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(Season season)
    {
        var p = new DynamicParameters();
        p.Add("@SeasonId", season.SeasonId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", season.TenantId);
        p.Add("@LeagueId", season.LeagueId);
        p.Add("@Name", season.Name);
        p.Add("@StartDate", season.StartDate);
        p.Add("@EndDate", season.EndDate);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spSeasonSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@SeasonId");
    }
}
