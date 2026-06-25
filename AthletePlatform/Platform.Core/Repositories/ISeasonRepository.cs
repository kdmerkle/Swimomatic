using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface ISeasonRepository
{
    Task<IEnumerable<Season>> GetByLeagueAsync(int leagueId);
    Task<Season?> GetByIdAsync(int id);
    Task<int> SaveAsync(Season season);
}
