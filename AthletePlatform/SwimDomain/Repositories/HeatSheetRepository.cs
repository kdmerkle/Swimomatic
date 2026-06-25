using System.Data;
using Dapper;
using Platform.Core.Data;
using SwimDomain.Models;

namespace SwimDomain.Repositories;

public class HeatSheetRepository(IDbConnectionFactory connFactory) : IHeatSheetRepository
{
    public async Task<HeatSheet?> GetByMeetIdAsync(int swimMeetId)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<HeatSheet>(
            "swim.spHeatSheetGetByMeet",
            new { SwimMeetId = swimMeetId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(HeatSheet heatSheet)
    {
        var p = new DynamicParameters();
        p.Add("@HeatSheetId", heatSheet.HeatSheetId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", heatSheet.TenantId);
        p.Add("@SwimMeetId", heatSheet.SwimMeetId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spHeatSheetSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@HeatSheetId");
    }

    public async Task<IEnumerable<HeatSheetEvent>> GetEventsAsync(int heatSheetId)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<HeatSheetEvent>(
            "swim.spHeatSheetEventGetByHeatSheet",
            new { HeatSheetId = heatSheetId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveEventAsync(HeatSheetEvent evt)
    {
        var p = new DynamicParameters();
        p.Add("@HeatSheetEventId", evt.HeatSheetEventId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", evt.TenantId);
        p.Add("@HeatSheetId", evt.HeatSheetId);
        p.Add("@SwimEventId", evt.SwimEventId);
        p.Add("@AgeClassId", evt.AgeClassId);
        p.Add("@Gender", evt.Gender);
        p.Add("@Sequence", evt.Sequence);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spHeatSheetEventSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@HeatSheetEventId");
    }

    public async Task<IEnumerable<HeatSwimmer>> GetSwimmersBySeedTimeAsync(int heatSheetEventId)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<HeatSwimmer>(
            "swim.spHeatSwimmerGetBySeedTime",
            new { HeatSheetEventId = heatSheetEventId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task ClearSwimmersAsync(int heatSheetEventId)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync(
            "swim.spHeatSheetEventClearSwimmers",
            new { HeatSheetEventId = heatSheetEventId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveHeatAsync(Heat heat)
    {
        var p = new DynamicParameters();
        p.Add("@HeatId", heat.HeatId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", heat.TenantId);
        p.Add("@HeatSheetEventId", heat.HeatSheetEventId);
        p.Add("@HeatNumber", heat.HeatNumber);
        p.Add("@LaneCount", heat.LaneCount);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spHeatSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@HeatId");
    }

    public async Task<int> SaveHeatSwimmerAsync(HeatSwimmer swimmer)
    {
        var p = new DynamicParameters();
        p.Add("@HeatSwimmerId", swimmer.HeatSwimmerId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", swimmer.TenantId);
        p.Add("@HeatId", swimmer.HeatId);
        p.Add("@AthleteId", swimmer.AthleteId);
        p.Add("@LaneNumber", swimmer.LaneNumber);
        p.Add("@SeedTime", swimmer.SeedTime);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spHeatSwimmerSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@HeatSwimmerId");
    }

    public async Task<bool> EventHasResultsAsync(int heatSheetEventId)
    {
        using var conn = await connFactory.OpenAsync();
        var result = await conn.QuerySingleOrDefaultAsync<bool>(
            "swim.spHeatSheetEventDelete",
            new { HeatSheetEventId = heatSheetEventId },
            commandType: CommandType.StoredProcedure);
        return result;
    }

    public async Task DeleteEventAsync(int heatSheetEventId)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync(
            "swim.spHeatSheetEventDelete",
            new { HeatSheetEventId = heatSheetEventId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task ResequenceEventsAsync(string commaSeparatedIds)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync(
            "swim.spHeatSheetEventsResequence",
            new { HeatSheetEventIds = commaSeparatedIds },
            commandType: CommandType.StoredProcedure);
    }
}
