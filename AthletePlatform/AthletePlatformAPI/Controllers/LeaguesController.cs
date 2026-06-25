using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Models;
using Platform.Core.Repositories;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/leagues")]
[Authorize]
public class LeaguesController(
    ILeagueRepository leagueRepository,
    ISeasonRepository seasonRepository,
    ITenantContext tenantContext) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<League>>> GetLeagues([FromQuery] string? sport = null)
    {
        var leagues = await leagueRepository.GetAllAsync(sport);
        return Ok(leagues);
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<League>> GetLeague(int id)
    {
        var league = await leagueRepository.GetByIdAsync(id);
        return league is null ? NotFound() : Ok(league);
    }

    [HttpPost]
    public async Task<ActionResult<League>> CreateLeague([FromBody] League league)
    {
        league.TenantId = tenantContext.TenantId;
        var id = await leagueRepository.SaveAsync(league);
        league.LeagueId = id;
        return CreatedAtAction(nameof(GetLeague), new { id }, league);
    }

    [HttpGet("{id:int}/seasons")]
    public async Task<ActionResult<IEnumerable<Season>>> GetSeasons(int id)
    {
        var seasons = await seasonRepository.GetByLeagueAsync(id);
        return Ok(seasons);
    }

    [HttpPost("{id:int}/seasons")]
    public async Task<ActionResult<Season>> CreateSeason(int id, [FromBody] Season season)
    {
        season.LeagueId = id;
        season.TenantId = tenantContext.TenantId;
        var seasonId = await seasonRepository.SaveAsync(season);
        season.SeasonId = seasonId;
        return CreatedAtAction(nameof(GetSeasons), new { id }, season);
    }
}
