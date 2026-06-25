using SwimDomain.Models;

namespace SwimDomain.Services;

public interface ISwimMeetService
{
    Task<IEnumerable<SwimMeet>> GetAllMeetsAsync();
    Task<SwimMeet?> GetMeetAsync(int id);
    Task<int> CreateMeetAsync(SwimMeet meet);
    Task UpdateMeetAsync(SwimMeet meet);
    Task<bool> HasResultsAsync(int swimMeetId);
    Task DeleteMeetAsync(int swimMeetId);
}
