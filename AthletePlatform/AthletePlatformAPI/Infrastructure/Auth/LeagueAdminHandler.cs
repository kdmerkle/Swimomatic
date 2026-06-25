using System.Data;
using System.Security.Claims;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Platform.Core.Data;

namespace AthletePlatformAPI.Infrastructure.Auth;

public class LeagueAdminHandler(IDbConnectionFactory connFactory)
    : AuthorizationHandler<AdminRequirement>
{
    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext ctx, AdminRequirement requirement)
    {
        if (requirement.ResourceType != "League") return;

        var httpCtx = ctx.Resource as HttpContext;
        if (httpCtx is null) { ctx.Fail(); return; }

        const string cacheKey = "LeagueAdmin_Result";
        if (httpCtx.Items.TryGetValue(cacheKey, out var cached))
        {
            if (cached is true) ctx.Succeed(requirement);
            return;
        }

        var auth0UserId = ctx.User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (auth0UserId is null) { ctx.Fail(); return; }

        var routeId = httpCtx.GetRouteValue("id")?.ToString() ?? httpCtx.GetRouteValue("leagueId")?.ToString();
        if (!int.TryParse(routeId, out var leagueId))
        {
            ctx.Fail();
            return;
        }

        using var conn = await connFactory.OpenAsync(bypassRls: true);
        var isAdmin = await conn.QuerySingleOrDefaultAsync<bool>(
            "dbo.spUserLeagueIsAdmin",
            new { Auth0UserId = auth0UserId, LeagueId = leagueId },
            commandType: CommandType.StoredProcedure);

        httpCtx.Items[cacheKey] = isAdmin;
        if (isAdmin) ctx.Succeed(requirement);
    }
}
