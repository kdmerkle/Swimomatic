using SwimDomain.Models;

namespace SwimDomain.Services;

public interface IResultService
{
    Task<IEnumerable<SwimResult>> GetResultsByEventAsync(int heatSheetEventId);
    Task<int> RecordResultAsync(SwimResult result);
    Task CalculateScoresAsync(int heatSheetEventId);
}
