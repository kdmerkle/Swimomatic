using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Platform.Core;

namespace TrackField.Domain;

public sealed class TrackFieldModule : ISportModule
{
    public string SportCode => "tf";

    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        // TODO: Register T&F services when implemented (Phase H / WI-02)
    }
}
