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
[Route("api/athletes")]
[Authorize]
public class AthletesController(
    IAthleteRepository athleteRepository,
    ITenantContext tenantContext,
    IDbConnectionFactory connFactory)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Athlete>>> GetAthletes()
    {
        var athletes = await athleteRepository.GetAllAsync();
        return Ok(athletes);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<Athlete>> GetAthlete(int id)
    {
        var athlete = await athleteRepository.GetByIdAsync(id);
        return athlete is null ? NotFound() : Ok(athlete);
    }

    [HttpPost]
    public async Task<ActionResult<Athlete>> CreateAthlete([FromBody] Athlete athlete)
    {
        athlete.TenantId = tenantContext.TenantId;
        var id = await athleteRepository.SaveAsync(athlete);
        athlete.AthleteId = id;
        return CreatedAtAction(nameof(GetAthlete), new { id }, athlete);
    }

    [HttpPut("{id:int}")]
    public async Task<IActionResult> UpdateAthlete(int id, [FromBody] Athlete athlete)
    {
        athlete.AthleteId = id;
        athlete.TenantId = tenantContext.TenantId;
        await athleteRepository.SaveAsync(athlete);
        return NoContent();
    }

    [HttpPost("{id:int}/team-requests")]
    public async Task<IActionResult> RequestTeam(int id, [FromBody] AthleteTeamRequestDto request)
    {
        var p = new DynamicParameters();
        p.Add("@AthleteTeamRequestId", 0, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", tenantContext.TenantId);
        p.Add("@AthleteId", id);
        p.Add("@TeamId", request.TeamId);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("dbo.spAthleteTeamRequestSave", p, commandType: CommandType.StoredProcedure);
        return Ok(new { AthleteTeamRequestId = p.Get<int>("@AthleteTeamRequestId") });
    }
}

public record AthleteTeamRequestDto(int TeamId);
