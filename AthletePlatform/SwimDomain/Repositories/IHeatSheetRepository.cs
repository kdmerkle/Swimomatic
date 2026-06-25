using SwimDomain.Models;

namespace SwimDomain.Repositories;

public interface IHeatSheetRepository
{
    Task<HeatSheet?> GetByMeetIdAsync(int swimMeetId);
    Task<int> SaveAsync(HeatSheet heatSheet);
    Task<IEnumerable<HeatSheetEvent>> GetEventsAsync(int heatSheetId);
    Task<int> SaveEventAsync(HeatSheetEvent evt);
    Task<bool> EventHasResultsAsync(int heatSheetEventId);
    Task DeleteEventAsync(int heatSheetEventId);
    Task ResequenceEventsAsync(string commaSeparatedIds);
    Task<IEnumerable<HeatSwimmer>> GetSwimmersBySeedTimeAsync(int heatSheetEventId);
    Task ClearSwimmersAsync(int heatSheetEventId);
    Task<int> SaveHeatAsync(Heat heat);
    Task<int> SaveHeatSwimmerAsync(HeatSwimmer swimmer);
}
