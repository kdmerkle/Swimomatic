using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Data;
using Platform.Core.Tenancy;
using SwimDomain.Models;
using System.Data;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/leagues/{leagueId:int}/seasons/{seasonId:int}/scoring")]
[Authorize(Policy = "LeagueAdmin")]
public class ScoringController(IDbConnectionFactory connFactory, ITenantContext tenantContext)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<ScoringScheme>>> GetSchemes(int leagueId, int seasonId)
    {
        using var conn = await connFactory.OpenAsync();
        var schemes = await conn.QueryAsync<ScoringScheme>(
            "dbo.spScoringSchemeGetBySeason",
            new { SeasonId = seasonId },
            commandType: CommandType.StoredProcedure);
        return Ok(schemes);
    }

    [HttpPost]
    public async Task<IActionResult> SaveSchemes(int leagueId, int seasonId, [FromBody] SeasonScoringRequest request)
    {
        using var conn = await connFactory.OpenAsync();
        using var tx = await conn.BeginTransactionAsync();
        try
        {
            // Save dual scheme
            var dualP = new DynamicParameters();
            dualP.Add("@ScoringSchemeId", request.DualScheme.ScoringSchemeId, direction: ParameterDirection.InputOutput);
            dualP.Add("@TenantId", tenantContext.TenantId);
            dualP.Add("@Name", request.DualScheme.Name);
            dualP.Add("@Description", request.DualScheme.Description);
            await conn.ExecuteAsync("dbo.spScoringSchemeSave", dualP, tx, commandType: CommandType.StoredProcedure);
            var dualId = dualP.Get<int>("@ScoringSchemeId");

            // Save championship scheme
            var champP = new DynamicParameters();
            champP.Add("@ScoringSchemeId", request.ChampionshipScheme.ScoringSchemeId, direction: ParameterDirection.InputOutput);
            champP.Add("@TenantId", tenantContext.TenantId);
            champP.Add("@Name", request.ChampionshipScheme.Name);
            champP.Add("@Description", request.ChampionshipScheme.Description);
            await conn.ExecuteAsync("dbo.spScoringSchemeSave", champP, tx, commandType: CommandType.StoredProcedure);
            var champId = champP.Get<int>("@ScoringSchemeId");

            // Link to season
            await conn.ExecuteAsync("dbo.spSeasonScoringSchemeUpsert",
                new { SeasonId = seasonId, ScoringSchemeId = dualId, SchemeType = "Dual" },
                tx, commandType: CommandType.StoredProcedure);
            await conn.ExecuteAsync("dbo.spSeasonScoringSchemeUpsert",
                new { SeasonId = seasonId, ScoringSchemeId = champId, SchemeType = "Championship" },
                tx, commandType: CommandType.StoredProcedure);

            await tx.CommitAsync();
            return NoContent();
        }
        catch
        {
            await tx.RollbackAsync();
            throw;
        }
    }
}
