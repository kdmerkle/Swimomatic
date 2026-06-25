using SwimDomain.Models;
using SwimDomain.Repositories;

namespace SwimDomain.Services;

public class SwimMeetService(ISwimMeetRepository repository) : ISwimMeetService
{
    public Task<IEnumerable<SwimMeet>> GetAllMeetsAsync() => repository.GetAllAsync();
    public Task<SwimMeet?> GetMeetAsync(int id) => repository.GetByIdAsync(id);
    public Task<int> CreateMeetAsync(SwimMeet meet) => repository.SaveAsync(meet);

    public async Task UpdateMeetAsync(SwimMeet meet)
    {
        if (meet.SwimMeetId == 0)
            throw new ArgumentException("SwimMeetId must be set for update.");
        await repository.SaveAsync(meet);
    }

    public Task<bool> HasResultsAsync(int swimMeetId) => repository.HasResultsAsync(swimMeetId);

    public Task DeleteMeetAsync(int swimMeetId) => repository.DeleteAsync(swimMeetId);
}
