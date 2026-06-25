using System.Security.Claims;
using Platform.Core.Data;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Infrastructure.Tenancy;

public class TenantResolutionMiddleware(RequestDelegate next)
{
    private const string TenantClaimType = "https://athleteplatform.com/tenant_id";

    public async Task InvokeAsync(HttpContext ctx, ITenantContext tenantContext,
        IDbConnectionFactory connFactory)
    {
        if (ctx.User.Identity?.IsAuthenticated == true)
        {
            var tenantKey = ctx.User.FindFirstValue(TenantClaimType);
            if (tenantKey is null)
            {
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                return;
            }
            if (tenantContext is TenantContext tc)
                await tc.ResolveAsync(tenantKey, connFactory);
        }
        await next(ctx);
    }
}
