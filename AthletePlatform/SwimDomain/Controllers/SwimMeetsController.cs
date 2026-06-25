using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Tenancy;
using SwimDomain.Models;
using SwimDomain.Services;

namespace SwimDomain.Controllers;

[ApiController]
[Route("api/swim/meets")]
[Authorize]
public class SwimMeetsController(ISwimMeetService swimMeetService, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<SwimMeet>>> GetMeets()
    {
        var meets = await swimMeetService.GetAllMeetsAsync();
        return Ok(meets);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<SwimMeet>> GetMeet(int id)
    {
        var meet = await swimMeetService.GetMeetAsync(id);
        return meet is null ? NotFound() : Ok(meet);
    }

    [HttpPost]
    public async Task<ActionResult<SwimMeet>> CreateMeet([FromBody] SwimMeet meet)
    {
        meet.TenantId = tenantContext.TenantId;
        var id = await swimMeetService.CreateMeetAsync(meet);
        meet.SwimMeetId = id;
        return CreatedAtAction(nameof(GetMeet), new { id }, meet);
    }

    [HttpPut("{id:int}")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<IActionResult> UpdateSwimMeet(int id, [FromBody] SwimMeet meet)
    {
        meet.SwimMeetId = id;
        meet.TenantId = tenantContext.TenantId;
        await swimMeetService.UpdateMeetAsync(meet);
        return NoContent();
    }

    [HttpDelete("{id:int}")]
    [Authorize(Policy = "SwimMeetAdmin")]
    public async Task<IActionResult> DeleteSwimMeet(int id)
    {
        if (await swimMeetService.HasResultsAsync(id))
            return Conflict(new ProblemDetails
            {
                Title = "Cannot delete swim meet with results",
                Detail = "Remove all results before deleting this meet.",
                Status = 409
            });
        await swimMeetService.DeleteMeetAsync(id);
        return NoContent();
    }
}
