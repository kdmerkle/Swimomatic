using System.Data;
using Dapper;
using Platform.Core.Data;
using SwimDomain.Models;

namespace SwimDomain.Repositories;

public class SwimMeetRepository(IDbConnectionFactory connFactory) : ISwimMeetRepository
{
    public async Task<IEnumerable<SwimMeet>> GetAllAsync()
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<SwimMeet>(
            "swim.spSwimMeetGetAll", commandType: CommandType.StoredProcedure);
    }

    public async Task<SwimMeet?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<SwimMeet>(
            "swim.spSwimMeetGetById",
            new { SwimMeetId = id },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(SwimMeet meet)
    {
        var p = new DynamicParameters();
        p.Add("@SwimMeetId", meet.SwimMeetId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", meet.TenantId);
        p.Add("@SeasonId", meet.SeasonId);
        p.Add("@LocationId", meet.LocationId);
        p.Add("@Description", meet.Description);
        p.Add("@StartDate", meet.StartDate);
        p.Add("@EndDate", meet.EndDate);
        p.Add("@SwimMeetTypeId", meet.SwimMeetTypeId);
        p.Add("@PoolConfigId", meet.PoolConfigId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spSwimMeetSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@SwimMeetId");
    }

    public async Task<bool> HasResultsAsync(int swimMeetId)
    {
        using var conn = await connFactory.OpenAsync();
        var result = await conn.QuerySingleAsync<bool>(
            "swim.spSwimMeetDelete",
            new { SwimMeetId = swimMeetId },
            commandType: CommandType.StoredProcedure);
        return result;
    }

    public async Task DeleteAsync(int swimMeetId)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync(
            "swim.spSwimMeetDeleteById",
            new { SwimMeetId = swimMeetId },
            commandType: CommandType.StoredProcedure);
    }
}
