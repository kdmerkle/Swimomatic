using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface IAthleteRepository
{
    Task<IEnumerable<Athlete>> GetAllAsync();
    Task<Athlete?> GetByIdAsync(int id);
    Task<int> SaveAsync(Athlete athlete);
}
