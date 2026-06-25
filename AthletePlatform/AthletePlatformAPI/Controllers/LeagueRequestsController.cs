using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Data;
using Platform.Core.Tenancy;
using System.Data;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/league-requests")]
[Authorize]
public class LeagueRequestsController(IDbConnectionFactory connFactory, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet("pending")]
    public async Task<IActionResult> GetPending()
    {
        using var conn = await connFactory.OpenAsync();
        var requests = await conn.QueryAsync(
            "SELECT TeamLeagueRequestId, TeamId, LeagueId, RequestDate, Status FROM dbo.TeamLeagueRequest WHERE Status = 'Pending'");
        return Ok(requests);
    }

    [HttpPost("{id:int}/approve")]
    [Authorize(Policy = "LeagueAdmin")]
    public async Task<IActionResult> Approve(int id)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spTeamLeagueRequestApprove",
            new { TeamLeagueRequestId = id, Approve = true },
            commandType: CommandType.StoredProcedure);
        return NoContent();
    }

    [HttpPost("{id:int}/reject")]
    [Authorize(Policy = "LeagueAdmin")]
    public async Task<IActionResult> Reject(int id)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spTeamLeagueRequestApprove",
            new { TeamLeagueRequestId = id, Approve = false },
            commandType: CommandType.StoredProcedure);
        return NoContent();
    }
}
