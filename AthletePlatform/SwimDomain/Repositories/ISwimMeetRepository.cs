using SwimDomain.Models;

namespace SwimDomain.Repositories;

public interface ISwimMeetRepository
{
    Task<IEnumerable<SwimMeet>> GetAllAsync();
    Task<SwimMeet?> GetByIdAsync(int id);
    Task<int> SaveAsync(SwimMeet meet);
    Task<bool> HasResultsAsync(int swimMeetId);
    Task DeleteAsync(int swimMeetId);
}
