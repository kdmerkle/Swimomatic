using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;
using Platform.Core.Tenancy;
using System.Data;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/teams")]
[Authorize]
public class TeamsController(
    ITeamRepository teamRepository,
    ITenantContext tenantContext,
    IDbConnectionFactory connFactory) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Team>>> GetTeams()
    {
        var teams = await teamRepository.GetAllAsync();
        return Ok(teams);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<Team>> GetTeam(int id)
    {
        var team = await teamRepository.GetByIdAsync(id);
        return team is null ? NotFound() : Ok(team);
    }

    [HttpPost]
    public async Task<ActionResult<Team>> CreateTeam([FromBody] Team team)
    {
        team.TenantId = tenantContext.TenantId;
        var id = await teamRepository.SaveAsync(team);
        team.TeamId = id;
        return CreatedAtAction(nameof(GetTeam), new { id }, team);
    }

    [HttpPost("{id:int}/league-requests")]
    public async Task<IActionResult> RequestLeague(int id, [FromBody] TeamLeagueRequestDto request)
    {
        var p = new DynamicParameters();
        p.Add("@TeamLeagueRequestId", 0, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", tenantContext.TenantId);
        p.Add("@TeamId", id);
        p.Add("@LeagueId", request.LeagueId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spTeamLeagueRequestSave", p, commandType: CommandType.StoredProcedure);
        return Ok(new { TeamLeagueRequestId = p.Get<int>("@TeamLeagueRequestId") });
    }
}

public record TeamLeagueRequestDto(int LeagueId);
