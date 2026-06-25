using SwimDomain.Models;

namespace SwimDomain.Repositories;

public interface IResultRepository
{
    Task<IEnumerable<SwimResult>> GetByEventAsync(int heatSheetEventId);
    Task<int> SaveAsync(SwimResult result);
    Task UpdateScoreAsync(int resultId, decimal? score);
}
