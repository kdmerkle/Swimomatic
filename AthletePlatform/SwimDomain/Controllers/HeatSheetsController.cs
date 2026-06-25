using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Tenancy;
using SwimDomain.Models;
using SwimDomain.Services;

namespace SwimDomain.Controllers;

[ApiController]
[Route("api/swim/meets/{meetId:int}/heatsheets")]
[Authorize]
public class HeatSheetsController(IHeatSheetService heatSheetService, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<HeatSheet>> GetHeatSheet(int meetId)
    {
        var hs = await heatSheetService.GetHeatSheetAsync(meetId);
        return hs is null ? NotFound() : Ok(hs);
    }

    [HttpPost]
    public async Task<ActionResult<HeatSheet>> CreateHeatSheet(int meetId)
    {
        var id = await heatSheetService.CreateHeatSheetAsync(meetId, tenantContext.TenantId);
        return CreatedAtAction(nameof(GetHeatSheet), new { meetId }, new { HeatSheetId = id });
    }

    [HttpPost("{hsId:int}/generate")]
    public async Task<IActionResult> GenerateHeats(
        int meetId,
        int hsId,
        [FromQuery] int laneCount = 6,
        [FromQuery] SeedType seedType = SeedType.MostRecent)
    {
        var events = await heatSheetService.GetEventsAsync(hsId);
        foreach (var evt in events)
        {
            await heatSheetService.GenerateHeatsAsync(evt.HeatSheetEventId, laneCount, seedType);
        }
        return NoContent();
    }

    [HttpGet("{hsId:int}/events")]
    public async Task<ActionResult<IEnumerable<HeatSheetEvent>>> GetEvents(int meetId, int hsId)
    {
        var events = await heatSheetService.GetEventsAsync(hsId);
        return Ok(events);
    }

    [HttpPost("{hsId:int}/events")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<ActionResult<HeatSheetEvent>> AddEvent(int meetId, int hsId, [FromBody] HeatSheetEvent evt)
    {
        evt.HeatSheetId = hsId;
        evt.TenantId = tenantContext.TenantId;
        var id = await heatSheetService.AddEventAsync(evt);
        evt.HeatSheetEventId = id;
        return CreatedAtAction(nameof(GetEvents), new { meetId, hsId }, evt);
    }

    [HttpDelete("{hsId:int}/events/{eventId:int}")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<IActionResult> DeleteEvent(int meetId, int hsId, int eventId)
    {
        var hasResults = await heatSheetService.EventHasResultsAsync(eventId);
        if (hasResults)
            return Conflict(new ProblemDetails { Title = "Event has results", Status = 409 });
        await heatSheetService.DeleteEventAsync(eventId);
        return NoContent();
    }

    [HttpPut("{hsId:int}/events/resequence")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<IActionResult> ResequenceEvents(int meetId, int hsId, [FromBody] List<int> orderedEventIds)
    {
        await heatSheetService.ResequenceEventsAsync(hsId, orderedEventIds);
        return NoContent();
    }

    [HttpPost("{hsId:int}/events/{eventId:int}/seed")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<IActionResult> SeedEvent(int meetId, int hsId, int eventId, [FromQuery] SeedType seedType = SeedType.MostRecent, [FromQuery] int laneCount = 6)
    {
        await heatSheetService.GenerateHeatsAsync(eventId, laneCount, seedType);
        return NoContent();
    }
}
