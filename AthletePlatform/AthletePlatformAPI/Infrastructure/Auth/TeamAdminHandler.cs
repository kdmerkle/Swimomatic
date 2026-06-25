using System.Data;
using System.Security.Claims;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Platform.Core.Data;

namespace AthletePlatformAPI.Infrastructure.Auth;

public class TeamAdminHandler(IDbConnectionFactory connFactory)
    : AuthorizationHandler<AdminRequirement>
{
    protected override async Task HandleRequirementAsync(
        AuthorizationHandlerContext ctx, AdminRequirement requirement)
    {
        if (requirement.ResourceType != "Team") return;

        var httpCtx = ctx.Resource as HttpContext;
        if (httpCtx is null) { ctx.Fail(); return; }

        const string cacheKey = "TeamAdmin_Result";
        if (httpCtx.Items.TryGetValue(cacheKey, out var cached))
        {
            if (cached is true) ctx.Succeed(requirement);
            return;
        }

        var auth0UserId = ctx.User.FindFirstValue(ClaimTypes.NameIdentifier);
        if (auth0UserId is null) { ctx.Fail(); return; }

        if (!int.TryParse(httpCtx.GetRouteValue("id")?.ToString(), out var teamId))
        {
            ctx.Fail();
            return;
        }

        using var conn = await connFactory.OpenAsync(bypassRls: true);
        var isAdmin = await conn.QuerySingleOrDefaultAsync<bool>(
            "dbo.spUserTeamIsAdmin",
            new { Auth0UserId = auth0UserId, TeamId = teamId },
            commandType: CommandType.StoredProcedure);

        httpCtx.Items[cacheKey] = isAdmin;
        if (isAdmin) ctx.Succeed(requirement);
    }
}
