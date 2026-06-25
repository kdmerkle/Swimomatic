using SwimDomain.Models;
using SwimDomain.Repositories;

namespace SwimDomain.Services;

public class ResultService(IResultRepository resultRepository) : IResultService
{
    public Task<IEnumerable<SwimResult>> GetResultsByEventAsync(int heatSheetEventId) =>
        resultRepository.GetByEventAsync(heatSheetEventId);

    public async Task<int> RecordResultAsync(SwimResult result)
    {
        var id = await resultRepository.SaveAsync(result);
        return id;
    }

    public async Task CalculateScoresAsync(int heatSheetEventId)
    {
        var results = (await resultRepository.GetByEventAsync(heatSheetEventId))
            .Where(r => !r.IsDQ && r.ElapsedTime.HasValue)
            .OrderBy(r => r.ElapsedTime)
            .ToList();

        // Default scoring: 6-4-3-2-1 points for places 1-5
        var defaultPoints = new[] { 6m, 4m, 3m, 2m, 1m };

        for (int i = 0; i < results.Count; i++)
        {
            var score = i < defaultPoints.Length ? defaultPoints[i] : 0m;
            await resultRepository.UpdateScoreAsync(results[i].ResultId, score);
        }
    }
}
