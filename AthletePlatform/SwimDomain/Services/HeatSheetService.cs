using SwimDomain.Models;
using SwimDomain.Repositories;

namespace SwimDomain.Services;

public enum SeedType { MostRecent = 1, SeasonBest = 2, PersonalBest = 3 }

public interface IHeatSheetService
{
    Task<HeatSheet?> GetHeatSheetAsync(int swimMeetId);
    Task<int> CreateHeatSheetAsync(int swimMeetId, int tenantId);
    Task<IEnumerable<HeatSheetEvent>> GetEventsAsync(int heatSheetId);
    Task GenerateHeatsAsync(int heatSheetEventId, int laneCount, SeedType seedType);
    Task<int> AddEventAsync(HeatSheetEvent evt);
    Task<bool> EventHasResultsAsync(int heatSheetEventId);
    Task DeleteEventAsync(int heatSheetEventId);
    Task ResequenceEventsAsync(int heatSheetId, IEnumerable<int> orderedIds);
}

public class HeatSheetService(IHeatSheetRepository heatSheetRepository) : IHeatSheetService
{
    public Task<HeatSheet?> GetHeatSheetAsync(int swimMeetId) =>
        heatSheetRepository.GetByMeetIdAsync(swimMeetId);

    public Task<int> CreateHeatSheetAsync(int swimMeetId, int tenantId) =>
        heatSheetRepository.SaveAsync(new HeatSheet { SwimMeetId = swimMeetId, TenantId = tenantId });

    public Task<IEnumerable<HeatSheetEvent>> GetEventsAsync(int heatSheetId) =>
        heatSheetRepository.GetEventsAsync(heatSheetId);

    public async Task GenerateHeatsAsync(int heatSheetEventId, int laneCount, SeedType seedType)
    {
        // Clear existing heats/swimmers first (atomic in repository)
        await heatSheetRepository.ClearSwimmersAsync(heatSheetEventId);

        // Get swimmers ordered by seed time descending (fastest last = last heat)
        var swimmers = (await heatSheetRepository.GetSwimmersBySeedTimeAsync(heatSheetEventId)).ToList();
        if (swimmers.Count == 0) return;

        // Calculate heat count: ceiling(swimmerCount / laneCount)
        var heatCount = (int)Math.Ceiling((double)swimmers.Count / laneCount);

        // Swimmers are sorted fastest-first from SP; reverse so slowest goes to heat 1
        swimmers.Reverse();

        var assignments = new List<(int heatNumber, HeatSwimmer swimmer)>();
        for (int i = 0; i < swimmers.Count; i++)
        {
            var heatNumber = (i / laneCount) + 1;
            var laneNumber = (i % laneCount) + 1;
            assignments.Add((heatNumber, swimmers[i] with { LaneNumber = laneNumber }));
        }

        // Get tenantId from first swimmer
        var tenantId = swimmers[0].TenantId;

        // Save all heats and capture their ids
        var heatIds = new Dictionary<int, int>(); // heatNumber → HeatId
        foreach (var heatNumber in Enumerable.Range(1, heatCount))
        {
            var heatId = await heatSheetRepository.SaveHeatAsync(new Heat
            {
                TenantId = tenantId,
                HeatSheetEventId = heatSheetEventId,
                HeatNumber = heatNumber,
                LaneCount = laneCount
            });
            heatIds[heatNumber] = heatId;
        }

        // Save all heat-swimmer assignments
        foreach (var (heatNumber, swimmer) in assignments)
        {
            var seeded = swimmer with { HeatId = heatIds[heatNumber], TenantId = tenantId };
            await heatSheetRepository.SaveHeatSwimmerAsync(seeded);
        }
    }

    public Task<int> AddEventAsync(HeatSheetEvent evt) =>
        heatSheetRepository.SaveEventAsync(evt);

    public Task<bool> EventHasResultsAsync(int heatSheetEventId) =>
        heatSheetRepository.EventHasResultsAsync(heatSheetEventId);

    public Task DeleteEventAsync(int heatSheetEventId) =>
        heatSheetRepository.DeleteEventAsync(heatSheetEventId);

    public Task ResequenceEventsAsync(int heatSheetId, IEnumerable<int> orderedIds) =>
        heatSheetRepository.ResequenceEventsAsync(string.Join(",", orderedIds));
}
