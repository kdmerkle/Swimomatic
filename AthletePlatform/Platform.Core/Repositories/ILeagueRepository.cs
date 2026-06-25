using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface ILeagueRepository
{
    Task<IEnumerable<League>> GetAllAsync(string? sportCode = null);
    Task<League?> GetByIdAsync(int id);
    Task<int> SaveAsync(League league);
}
