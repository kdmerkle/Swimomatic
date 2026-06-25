using System.Security.Claims;
using AthletePlatformAPI.Infrastructure.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using Moq;
using Platform.Core.Data;
using Xunit;

namespace SwimDomain.Tests.Infrastructure;

public class SwimMeetAdminHandlerTests
{
    [Fact]
    public async Task HandleAsync_WrongResourceType_DoesNotSucceedOrFail()
    {
        var mockConn = new Mock<IDbConnectionFactory>();
        var handler = new SwimMeetAdminHandler(mockConn.Object);
        var requirement = new AdminRequirement("Team");  // wrong resource type

        var user = new ClaimsPrincipal(new ClaimsIdentity([
            new Claim(ClaimTypes.NameIdentifier, "auth0|123")
        ], "test"));
        var ctx = new AuthorizationHandlerContext([requirement], user, new DefaultHttpContext());

        await handler.HandleAsync(ctx);

        Assert.False(ctx.HasSucceeded);
        Assert.False(ctx.HasFailed);
    }

    [Fact]
    public async Task HandleAsync_NullHttpContext_Fails()
    {
        var mockConn = new Mock<IDbConnectionFactory>();
        var handler = new SwimMeetAdminHandler(mockConn.Object);
        var requirement = new AdminRequirement("SwimMeet");

        var user = new ClaimsPrincipal(new ClaimsIdentity([
            new Claim(ClaimTypes.NameIdentifier, "auth0|123")
        ], "test"));
        // Resource is null (not an HttpContext)
        var ctx = new AuthorizationHandlerContext([requirement], user, null);

        await handler.HandleAsync(ctx);

        Assert.True(ctx.HasFailed);
    }
}
