using Platform.Core.Models;

namespace Platform.Core.Repositories;

public interface ILocationRepository
{
    Task<IEnumerable<Location>> GetAllAsync();
    Task<Location?> GetByIdAsync(int id);
    Task<int> SaveAsync(Location location);
}
