using System.Security.Claims;
using AthletePlatformAPI.Infrastructure.Tenancy;
using Microsoft.AspNetCore.Http;
using Moq;
using Platform.Core.Data;
using Platform.Core.Tenancy;

namespace SwimDomain.Tests.Infrastructure;

public class TenantResolutionMiddlewareTests
{
    private const string TenantClaimType = "https://athleteplatform.com/tenant_id";

    [Fact]
    public async Task InvokeAsync_UnauthenticatedRequest_CallsNext()
    {
        // Arrange
        var nextCalled = false;
        RequestDelegate next = _ => { nextCalled = true; return Task.CompletedTask; };
        var middleware = new TenantResolutionMiddleware(next);

        var ctx = new DefaultHttpContext();
        // User is not authenticated (default)

        var mockTenantCtx = new Mock<ITenantContext>();
        var mockConnFactory = new Mock<IDbConnectionFactory>();

        // Act
        await middleware.InvokeAsync(ctx, mockTenantCtx.Object, mockConnFactory.Object);

        // Assert
        Assert.True(nextCalled);
    }

    [Fact]
    public async Task InvokeAsync_AuthenticatedWithMissingClaim_Returns401()
    {
        // Arrange
        var nextCalled = false;
        RequestDelegate next = _ => { nextCalled = true; return Task.CompletedTask; };
        var middleware = new TenantResolutionMiddleware(next);

        var ctx = new DefaultHttpContext();
        // Authenticated but no tenant claim
        var identity = new ClaimsIdentity(
            [new Claim(ClaimTypes.NameIdentifier, "user123")], "test");
        ctx.User = new ClaimsPrincipal(identity);

        var mockTenantCtx = new Mock<ITenantContext>();
        var mockConnFactory = new Mock<IDbConnectionFactory>();

        // Act
        await middleware.InvokeAsync(ctx, mockTenantCtx.Object, mockConnFactory.Object);

        // Assert
        Assert.Equal(401, ctx.Response.StatusCode);
        Assert.False(nextCalled);
    }
}
