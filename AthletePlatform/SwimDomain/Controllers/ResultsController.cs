using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Tenancy;
using SwimDomain.Models;
using SwimDomain.Services;

namespace SwimDomain.Controllers;

[ApiController]
[Route("api/swim/events/{heatSheetEventId:int}/results")]
[Authorize]
public class ResultsController(IResultService resultService, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<SwimResult>>> GetResults(int heatSheetEventId)
    {
        var results = await resultService.GetResultsByEventAsync(heatSheetEventId);
        return Ok(results);
    }

    [HttpPost]
    public async Task<ActionResult<SwimResult>> RecordResult(
        int heatSheetEventId,
        [FromBody] SwimResult result)
    {
        result.TenantId = tenantContext.TenantId;
        var id = await resultService.RecordResultAsync(result);
        result.ResultId = id;
        return CreatedAtAction(nameof(GetResults), new { heatSheetEventId }, result);
    }

    [HttpPost("calculate-scores")]
    public async Task<IActionResult> CalculateScores(int heatSheetEventId)
    {
        await resultService.CalculateScoresAsync(heatSheetEventId);
        return NoContent();
    }
}
