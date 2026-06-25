using System.Data;
using Dapper;
using Platform.Core.Data;
using SwimDomain.Models;

namespace SwimDomain.Repositories;

public class ResultRepository(IDbConnectionFactory connFactory) : IResultRepository
{
    public async Task<IEnumerable<SwimResult>> GetByEventAsync(int heatSheetEventId)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<SwimResult>(
            "swim.spResultGetByEvent",
            new { HeatSheetEventId = heatSheetEventId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(SwimResult result)
    {
        var p = new DynamicParameters();
        p.Add("@ResultId", result.ResultId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", result.TenantId);
        p.Add("@HeatSwimmerId", result.HeatSwimmerId);
        p.Add("@ElapsedTime", result.ElapsedTime);
        p.Add("@IsDQ", result.IsDQ);
        p.Add("@MeasurementType", result.MeasurementType);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("swim.spResultSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@ResultId");
    }

    public async Task UpdateScoreAsync(int resultId, decimal? score)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync(
            "UPDATE dbo.Result SET Score = @Score WHERE ResultId = @ResultId",
            new { Score = score, ResultId = resultId });
    }
}
