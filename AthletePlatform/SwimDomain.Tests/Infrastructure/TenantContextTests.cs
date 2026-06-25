using AthletePlatformAPI.Infrastructure.Tenancy;

namespace SwimDomain.Tests.Infrastructure;

public class TenantContextTests
{
    [Fact]
    public void NewTenantContext_IsNotResolved()
    {
        var ctx = new TenantContext();
        Assert.False(ctx.IsResolved);
        Assert.Equal(0, ctx.TenantId);
        Assert.Equal(string.Empty, ctx.TenantKey);
    }
}
