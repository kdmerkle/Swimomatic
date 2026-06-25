using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Data;
using Platform.Core.Tenancy;
using System.Data;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/teams/{teamId:int}/join-requests")]
[Authorize]
public class TeamRequestsController(IDbConnectionFactory connFactory, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetRequests(int teamId)
    {
        using var conn = await connFactory.OpenAsync();
        var requests = await conn.QueryAsync(
            "SELECT AthleteTeamRequestId, AthleteId, TeamId, RequestDate, Status FROM dbo.AthleteTeamRequest WHERE TeamId = @TeamId AND Status = 'Pending'",
            new { TeamId = teamId });
        return Ok(requests);
    }

    [HttpPost("{requestId:int}/approve")]
    [Authorize(Policy = "TeamAdmin")]
    public async Task<IActionResult> Approve(int teamId, int requestId)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spAthleteTeamRequestApprove",
            new { AthleteTeamRequestId = requestId, Approve = true },
            commandType: CommandType.StoredProcedure);
        return NoContent();
    }

    [HttpPost("{requestId:int}/reject")]
    [Authorize(Policy = "TeamAdmin")]
    public async Task<IActionResult> Reject(int teamId, int requestId)
    {
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spAthleteTeamRequestApprove",
            new { AthleteTeamRequestId = requestId, Approve = false },
            commandType: CommandType.StoredProcedure);
        return NoContent();
    }
}
