using Microsoft.ApplicationInsights.Channel;
using Microsoft.ApplicationInsights.DataContracts;
using Microsoft.ApplicationInsights.Extensibility;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Infrastructure.Telemetry;

public class TenantIdTelemetryInitializer(IHttpContextAccessor httpContextAccessor)
    : ITelemetryInitializer
{
    public void Initialize(ITelemetry telemetry)
    {
        if (telemetry is not ISupportProperties props) return;
        var ctx = httpContextAccessor.HttpContext;
        if (ctx is null) return;
        var tenantContext = ctx.RequestServices.GetService<ITenantContext>();
        if (tenantContext?.IsResolved == true)
        {
            props.Properties["TenantKey"] = tenantContext.TenantKey;
            props.Properties["TenantId"] = tenantContext.TenantId.ToString();
        }
    }
}
