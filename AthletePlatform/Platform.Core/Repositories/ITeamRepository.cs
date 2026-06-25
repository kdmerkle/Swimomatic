using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface ITeamRepository
{
    Task<IEnumerable<Team>> GetAllAsync();
    Task<Team?> GetByIdAsync(int id);
    Task<int> SaveAsync(Team team);
}
